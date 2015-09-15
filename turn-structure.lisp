(defparameter *active-player*    nil)
(defparameter *nonactive-player* nil)
(defparameter *current-phase*    nil)
(defparameter *current-step*     nil)

(defun list-hand        () (mapcar (lambda (x) (format t "~a~%" (get-card-name x))) (get-player-hand *active-player*)))
(defun list-graveyard   () (mapcar (lambda (x) (format t "~a~%" (get-card-name x))) *graveyard*))
(defun list-exile       () (mapcar (lambda (x) (format t "~a~%" (get-card-name x))) *exile*))

(defun list-battlefield ()       (mapcar (lambda (x) (print-card x)) *battlefield*))
(defun list-manapool    (player) (format t "~a~%" (get-player-manapool player)))
(defun list-life        (player) (format t "~a~%" (get-player-life player)))

(defun list-commands ()
        (format t "commands available:~%")
        (format t "p                    - pass priority~%")
        (format t "h                    - list cards in hand~%")
        (format t "b                    - list cards on battlefield~%")
        (format t "g                    - list cards in graveyard~%")
        (format t "e                    - list cards in exile zone~%")
        (format t "fm                   - free mana~%")
        (format t "mp                   - see mana pool~%")
        (format t "desc [card]          - describe text on card~%")
        (format t "cast [card]          - cast a card~%")
        (format t "play [land]          - play a land~%")
        (format t "tap [bnum]           - tap a land for mana")
        (format t "untap [bnum]         - untap a land for mana")
        (format t "activate [ability]   - activate an ability~%")
        (format t "faceup [permanent]   - turn a permanent faceup~%")
        (format t "concede              - concede the game~%"))

(defun list-attackers-commands()
        (format t "commands available:~%")
        (format t "commit               - commit to chosen attackers~%")
        (format t "h                    - list cards in hand~%")
        (format t "b                    - list cards on battlefield~%")
        (format t "g                    - list cards in graveyard~%")
        (format t "e                    - list cards in exile zone~%")
        (format t "fm                   - free mana~%")
        (format t "mp                   - see mana pool~%")
        (format t "attack [bnum]        - attack opponent with a creature~%")
        (format t "unattack [bnum]      - don't attack opponent with a creature~%")
        (format t "la                   - list attackers~%")
        (format t "concede              - concede the game~%"))

(defun list-blockers-commands ()
        (format t "commands available:~%")
        (format t "commit               - commit to chosen blockers~%")
        (format t "h                    - list cards in hand~%")
        (format t "b                    - list cards on battlefield~%")
        (format t "g                    - list cards in graveyard~%")
        (format t "e                    - list cards in exile zone~%")
        (format t "fm                   - free mana~%")
        (format t "mp                   - see mana pool~%")
        (format t "block [bnum]         - block opponent with a creature~%")
        (format t "unblock [bnum]       - don't block opponent with a creature~%")
        (format t "la                   - list attackers~%")
        (format t "concede              - concede the game~%"))

(defun free-mana (player)      (set-player-manapool player (+ 1 (get-player-manapool player)))) 
(defun pay-mana  (player cost) (set-player-manapool player (-   (get-player-manapool player) cost)))

(defun play-card (player inname)
        (let* ((handcards (get-player-hand player))
               (c (find-if (lambda (x) (equalp inname (get-card-name x))) handcards)))
                     (unless c                              (beep-format t "not a card in your hand~%")         (return-from play-card nil))
                     (unless (land? c)                      (beep-format t "not a land, use cast for spells~%") (return-from play-card nil))
                     (unless (equal *active-player* player) (beep-format t "not your turn~%")                   (return-from play-card nil))
                     (when (get-player-playedland player)
                           (beep-format t "already played a land this turn~%")
                           (return-from play-card nil))
                     (format t "playing ~a~%" (get-card-name c))
                     (setf *battlefield* (cons c *battlefield*))
                     (set-player-playedland player t)
                     (set-player-hand player (remove c handcards :count 1)))
                     t)

(defun cast-card (player inname)
        (let* ((handcards (get-player-hand player))
               (c (find-if (lambda (x) (equalp inname (get-card-name x))) handcards)))
                (unless c         (beep-format t "not a card in your hand~%")           (return-from cast-card nil))
                (when   (land? c) (beep-format t "can't cast land, use play instead~%") (return-from cast-card nil)) 
                (when (< (get-player-manapool player) (get-card-cmc c))
                      (beep-format t "insufficient mana, ~a costs ~a~%" (get-card-name c) (get-card-cmc c))
                      (return-from cast-card nil))
                (unless (or (instant? c)
                            (equal *active-player* player))
                        (format t "not your turn~%")
                        (return-from cast-card nil))
                (format t "casting ~a~%" (get-card-name c))
                (pay-mana (get-card-cmc c))
                (set-player-hand player (remove c handcards :count 1))
                (push-stack c)
                (resolve-stack))
                t)

(defun describe-card (inname)
        (let1 c (find-if (lambda (x) (equalp inname (get-card-name x))) *all-cards*)
              (unless c (beep-format t "not a valid card name~%") (return-from describe-card))
              (print-card c)))

(defun tap-card (player nstr)
        (handler-case 
	    (let1 c (nth (parse-integer nstr) *battlefield*)
	          (when (tapped? c) (beep-format t "~a already tapped~%" (get-card-name c)) (return-from tap-card nil))
   		  (tap! c)
		  (free-mana player)
		  (format t "tapped ~a~%" (get-card-name c))
                  t)
	    (condition ()
                       (beep-format t "enter an integer between 0 and battlefieldsize-1~%")
                       nil)))
	  
(defun untap-card (nstr)
        (handler-case 
	    (let1 c (nth (parse-integer nstr) *battlefield*)
	          (unless (tapped? c) (beep-format t "~a already untapped~%" (get-card-name c)) (return-from untap-card nil))
   		  (untap! c)
		  (format t "untapped ~a~%" (get-card-name c))
                  t)
	    (condition () 
                       (beep-format t "enter an integer between 0 and battlefieldsize-1~%")
                       nil)))

(defparameter *declared-attackers* nil)
(defparameter *declared-blockers*  nil)

(defun attack-withcard (nstr)
        (handler-case
	        (let1 c (nth (parse-integer nstr) *battlefield*)
		      (unless (creature? c)                     (beep-format t "~a not a creature, can't attack~%"                   (get-card-name c)) (return-from attack-withcard))
	              (when   (sick?     c)                     (beep-format t "~a has summoning sickness, can't attack this turn~%" (get-card-name c)) (return-from attack-withcard))
                      (when   (tapped?   c)                     (beep-format t "~a tapped, can't attack~%"                           (get-card-name c)) (return-from attack-withcard))
                      (when   (has-static-ability? c 'defender) (beep-format t "~a has defender, can't attack~%"                     (get-card-name c)) (return-from attack-withcard))
                      (when   (member c *declared-attackers*)   (beep-format t "already attacking with ~a~%"                         (get-card-name c)) (return-from attack-withcard))
                      (format t "going to attack with ~a~%" (get-card-name c))
                      (setf *declared-attackers* (cons c *declared-attackers*)))
                (condition () (beep-format t "enter an integer between 0 and battlefieldsize-1~%"))))

(defun unattack-withcard (nstr)
        (handler-case
	        (let1 c (nth (parse-integer nstr) *battlefield*)
		      (unless (creature? c)                     (beep-format t "~a not a creature, can't attack~%"                   (get-card-name c)) (return-from unattack-withcard))
                      (when   (sick?     c)                     (beep-format t "~a has summoning sickness, can't attack this turn~%" (get-card-name c)) (return-from unattack-withcard))
                      (when   (tapped?   c)                     (beep-format t "~a tapped, can't attack~%"                           (get-card-name c)) (return-from unattack-withcard)) 
                      (when   (has-static-ability? c 'defender) (beep-format t "~a has defender, can't attack~%"                     (get-card-name c)) (return-from unattack-withcard))
                      (unless (member c *declared-attackers*)   (beep-format t "already not attacking with ~a~%"                     (get-card-name c)) (return-from unattack-withcard))
                      (format t "not going to attack with ~a~%" (get-card-name c))
                      (setf *declared-attackers* (remove c *declared-attackers*)))
                (condition () (format t "enter an integer between 0 and battlefieldsize-1~%"))))

(defun block-withcard (nstr)
        (handler-case
	        (let1 c (nth (parse-integer nstr) *battlefield*)
		      (unless (creature? c)                   (beep-format t "~a not a creature, can't block~%"                   (get-card-name c)) (return-from block-withcard))
                      (when   (tapped?   c)                   (beep-format t "~a tapped, can't block~%"                           (get-card-name c)) (return-from block-withcard))
                      (when   (member c *declared-attackers*) (beep-format t "already blocking with ~a~%"                         (get-card-name c)) (return-from block-withcard))
                      (format t "going to block with ~a~%" (get-card-name c))
                      (setf *declared-attackers* (cons c *declared-attackers*)))
                (condition () (beep-format t "enter an integer between 0 and battlefieldsize-1~%"))))

(defun unblock-withcard (nstr)
        (handler-case
	        (let1 c (nth (parse-integer nstr) *battlefield*)
		      (unless (creature? c)                   (beep-format t "~a not a creature, can't block~%"                    (get-card-name c)) (return-from unblock-withcard))
                      (when   (tapped?   c)                   (beep-format t "~a tapped, can't block~%"                            (get-card-name c)) (return-from unblock-withcard))
                      (unless (member c *declared-attackers*) (beep-format t "already not blocking with ~a~%"                      (get-card-name c)) (return-from unblock-withcard))
                      (format t "not going to block with ~a~%" (get-card-name c))
                      (setf *declared-attackers* (remove c *declared-attackers*)))
                (condition () (format t "enter an integer between 0 and battlefieldsize-1~%"))))

(defun commit-attackers ()
        (format t "commited attackers~%"))

(defun deal-damage ()
        (mapcar (lambda (c)
                        (let1 num (get-card-power c)
                              (lose-life *nonactive-player* num)
                              (format t "~a dealt ~a damage to ~a~%" (get-card-name c) num (get-player-name *nonactive-player*))
                              (when (has-static-ability? c 'lifelink)
                                    (gain-life *active-player* num)
                                    (format't "~a gained ~a ~a life from lifelink" (get-card-name c) (get-player-name *active-player*) num))))
                *declared-attackers*)
        (setf *declared-attackers* nil)
        (setf *declared-blockers*  nil))

(defun commit-blockers ()
        (format t "committed blockers~%"))

(defun list-attackers () (mapcar #'print-card *declared-attackers*)) 
(defun list-blockers  () (mapcar #'print-card *declared-blockers*))

(defun get-priority-loop ()
        (loop while (not (equal (car *apnap-circle*) *active-player*))
              do (setf *apnap-circle* (cdr *apnap-circle*)))
        (loop while (get-priority *active-player*))
        (setf *apnap-circle* (cdr *apnap-circle*))
        (let* ((last-player    *active-player*)
               (current-spot   *apnap-circle*)
               (current-player (car current-spot)))
                (loop while (not (equal last-player current-player))
                      do 
                        (when (get-priority current-player)
                              (format t "action happened, looping~%")
                              (setf last-player current-player)
                              (loop while (get-priority current-player)))
                        (setf current-spot (cdr current-spot))
                        (setf current-player (car current-spot)))))


(defun get-priority (player)
        (check-state-based-actions)
        (with-color 'red (format t "~a priority-> " (get-player-name player)))
	(loop 
                (finish-output nil)
                (let1 a (read-line)
                        (cond ((equalp a "concede")          (progn (format t "conceding~%") (concede player)              (return-from get-priority nil)))
                              ((equalp a "p")                                                                              (return-from get-priority nil))
                              ((string-begins-with a "cast")   (when (cast-card       player (string-trim-first-n a 5))    (return-from get-priority t)))
                              ((string-begins-with a "play")   (when (play-card       player (string-trim-first-n a 5))    (return-from get-priority t)))
                              ((string-begins-with a "tap")    (when (tap-card        player (string-trim-first-n a 4))    (return-from get-priority t)))
                              ((string-begins-with a "untap")  (when (untap-card      player (string-trim-first-n a 6))    (return-from get-priority t)))
                              ((string-begins-with a "desc")   (describe-card   (string-trim-first-n a 5)))
                              ((equalp a "activate")           (format t "activate~%")                        (return-from get-priority t))
                              ((equalp a "faceup")             (format t "faceup")                            (return-from get-priority t))
                              ((equalp a "mp")                 (list-manapool player))
                              ((equalp a "fm")                 (free-mana player))
                              ((equalp a "h")                  (list-hand))
                              ((equalp a "b")                  (list-battlefield))
                              ((equalp a "g")                  (list-graveyard))
                              ((equalp a "e")                  (list-exile))
			      ((equalp a "life")               (list-life))
                              (t                               (progn (beep) (list-commands)))))
                (with-color 'red (format t "~a priority | " (get-player-name player)))))

(defun prompt-attackers (player)
	(loop   (with-color 'red (format t "~a attackers-> " (get-player-name player)))
                (finish-output nil)
                (let1 a (read-line)
                        (cond ((equalp a "concede")              (progn (format t "conceding~%") (concede player) (return)))
                              ((equalp a "commit")               (progn (commit-attackers)                        (return)))
			      ((string-begins-with a "attack")   (  attack-withcard (string-trim-first-n a 7)))
			      ((string-begins-with a "unattack") (unattack-withcard (string-trim-first-n a 9)))
                              ((equalp a "la")                   (list-attackers))
                              ((equalp a "mp")                   (list-manapool player))
                              ((equalp a "fm")                   (free-mana player))
                              ((equalp a "h")                    (list-hand))
                              ((equalp a "b")                    (list-battlefield))
                              ((equalp a "g")                    (list-graveyard))
                              ((equalp a "e")                    (list-exile))
			      ((equalp a "life")                 (list-life))
                              (t                                 (progn (list-attackers-commands) (beep)))))))

(defun prompt-blockers (player)
	(loop   (with-color 'red (format t "~a blockers-> " (get-player-name player)))
                (finish-output nil)
                (let1 a (read-line)
                        (cond ((equalp a "concede")              (progn (format t "conceding~%") (concede player) (return)))
                              ((equalp a "commit")               (progn (commit-blockers)                         (return)))
			      ((string-begins-with a "block")    (  block-withcard (string-trim-first-n a 6)))
			      ((string-begins-with a "unblock")  (unblock-withcard (string-trim-first-n a 8)))
                              ((equalp a "la")                   (list-blockers))
                              ((equalp a "mp")                   (list-manapool player))
                              ((equalp a "fm")                   (free-mana player))
                              ((equalp a "h")                    (list-hand))
                              ((equalp a "b")                    (list-battlefield))
                              ((equalp a "g")                    (list-graveyard))
                              ((equalp a "e")                    (list-exile))
			      ((equalp a "life")                 (list-life))
                              (t                                 (progn (list-blockers-commands) (beep)))))))

(defun untap-all       () (mapcar #'untap! *battlefield*)) 
(defun empty-manapools () (mapcar #'empty-manapool *all-players*))

(defun untap-step () 
        (setf *current-step* 'untap)
        (with-color 'yellow (format t "Untap Step~%"))
        ;(phasing)
        (untap-all)
        (empty-manapools))

(defun upkeep-step () 
        (setf *current-step* 'upkeep)
        (with-color 'yellow (format t "Upkeep Step~%"))
        ;(triggers)
        (get-priority-loop)
        (empty-manapools))

(defun draw-step ()
        (setf *current-step* 'draw)
        (with-color 'yellow (format t "Draw Step~%"))
        (draw *active-player*) 
        ;(triggers)
        (get-priority-loop)
        (empty-manapools))

(defun beginning-phase ()
        (setf *current-phase* 'beginning)
        (with-color 'green (format t "--- Beginning Phase ---~%"))
	(untap-step)
	(upkeep-step)
	(draw-step)
        (empty-manapools))

(defun main-phase (which)
        (setf *current-phase* 'main)
        (with-color 'green (format t "--- Main Phase ~a ---~%" which))
	(get-priority-loop)
        (empty-manapools))

(defun beginning-of-combat-step () 
        (setf *current-step* 'beginning-of-combat)
        (with-color 'yellow (format t "Beginning of Combat Step~%"))
        ;507.1. First, if the game being played is a multiplayer game in which the active player’s opponents don’t all automatically become defending players,
        ;       the active player chooses one of his or her opponents. That player becomes the defending player. This turn-based action doesn’t use the stack. (See rule 506.2.)
        ;507.2. Second, any abilities that trigger at the beginning of combat go on the stack. (See rule 603, “Handling Triggered Abilities.”)
        (get-priority-loop) ;507.3
        (empty-manapools))

(defun declare-attackers-step () 
        (setf *current-step* 'declare-attackers)
        (with-color 'yellow (format t "Declare Attackers Step~%"))
        (prompt-attackers *active-player*)
        (mapcar (lambda (x) (unless (has-static-ability? x 'vigilance)) #'tap!) *declared-attackers*)
        (get-priority-loop)
        (empty-manapools))

(defun declare-blockers-step ()
        (setf *current-step*'declare-blockers)
        (with-color 'yellow (format t "Declare Blockers Step~%"))
        (prompt-blockers *nonactive-player*)
        (get-priority-loop)
        (empty-manapools))

(defun combat-damage-step () 
        (setf *current-step* 'combat-damage)
        (with-color 'yellow (format t "Combat Damage Step~%"))
        (deal-damage)
        (get-priority-loop)
        (empty-manapools))

(defun end-of-combat-step ()
        (setf *current-step* 'end-of-combat)
        (with-color 'yellow (format t "End of Combat Step~%"))
        ; 511.1 First, all “at end of combat” abilities trigger and go on the stack. (See rule 603, “Handling Triggered Abilities.”) 
        (get-priority-loop) ;511.2
        ; 511.3 As soon as the end of combat step ends, all creatures and planeswalkers are removed from combat.
        ;       After the end of combat step ends, the combat phase is over and the postcombat main phase begins (see rule 505).
        (empty-manapools))

(defun combat-phase ()
        (setf *current-phase* 'combat)
        (with-color 'green (format t "--- Combat Phase ---~%"))
        (beginning-of-combat-step)
        (declare-attackers-step)
        (if *declared-attackers*
            (progn (declare-blockers-step)
                   (combat-damage-step))
            (format t "no attackers, skipping declare blockers and combat damage steps~%")) ; 508.6
        (end-of-combat-step)
        (empty-manapools))

(defun end-step ()
        (setf *current-step* 'end)
        (with-color 'yellow (format t "End Step~%"))
	(get-priority-loop)
        (empty-manapools))

(defun heal-all-permanents ()
        (mapcar (lambda (x)
                        (when (creature? x)
                              (heal! x)))
                *battlefield*))

(defun cleanup-step ()
        (setf *current-step* 'cleanup)
        (with-color 'yellow (format t "Cleanup Step~%"))
        (discard-downto *active-player* 7)
        (heal-all-permanents)
        (when (check-state-based-actions)
              (cleanup-step))
        (empty-manapools))

(defun ending-phase ()
        (setf *current-phase* 'ending)
        (with-color 'green (format t "--- Ending Phase ---~%"))
	(end-step)
	(cleanup-step)
        (empty-manapools))

(defun reset-summoning-sickness ()
        (mapcar #'notsick! *battlefield*))

(defun turn (player)
        (setf *active-player* player) 
	(if (equal *active-player* *bob*)
	    (setf *nonactive-player* *alice*)
	    (setf *nonactive-player* *alice*)) 
	(set-player-playedland *active-player* nil)
	(reset-summoning-sickness)
        (with-color 'cyan (format t "========= ~a's Turn =========~%" (get-player-name player)))
	(beginning-phase)
	(main-phase 1)
	(combat-phase)
	(main-phase 2)
	(ending-phase))
