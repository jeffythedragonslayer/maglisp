(defparameter *active-player* 'nil)

(defun list-hand        () (mapcar (lambda (x) (format t "~a~%" (name (eval x)))) (objs (hand *active-player*)))) 
(defun list-battlefield () (mapcar (lambda (x) (format t "~a~%" (name (eval x)))) (objs *mtg-battlefield*))) 
(defun list-graveyard   () (mapcar (lambda (x) (format t "~a~%" (name (eval x)))) (objs *mtg-graveyard*))) 
(defun list-exile       () (mapcar (lambda (x) (format t "~a~%" (name (eval x)))) (objs *mtg-exile*))) 

(defun list-commands ()
        (format t "commands available:~%")
        (format t "p                    - pass priority~%")
        (format t "h                    - list cards in hand~%")
        (format t "b                    - list cards on battlefield~%")
        (format t "g                    - list cards in graveyard~%")
        (format t "e                    - list cards in exile zone~%")
        (format t "desc [card]          - describe text on card~%")
        (format t "cast [card]          - cast a card~%")
        (format t "play [land]          - play a land~%")
        (format t "activate [ability]   - activate an ability~%")
        (format t "faceup [permanent]   - turn a permanent faceup~%")
        (format t "concede              - concede the game~%"))

(defun play-card (inname)
        (let1 c (find-if (lambda (x) (equalp inname (name (eval x)))) (objs (hand *player1*)))
                (if c
                    (format t "playing ~a~%" (name (eval c)))
                    (format t "not a valid card name~%"))))

(defun describe-card (inname)
        (let1 c (find-if (lambda (x) (equalp inname (name (eval x)))) (objs (hand *player1*)))
                (if c
                    (print (eval c))
                    (format t "not a valid card name~%"))))

(defun get-priority ()
	(loop   (with-color 'red (format t "~a-> " (name *active-player*)))
                (finish-output nil)
                (let1 a (read-line)
                        (cond ((equalp a "concede")          (progn (format t "conceding~%") (concede *player1*) (return)))
                              ((equalp a "p")                                                                    (return))
                              ((equalp a "cast")             (progn (format t "cast~%") (prompt-play)))
                              ((string-begins-with a "play") (play-card (string-trim-first-n a 5)))
                              ((equalp a "activate")         (format t "activate~%"))
                              ((equalp a "faceup")           (format t "faceup"))
                              ((string-begins-with a "desc") (describe-card (string-trim-first-n a 5)))
                              ((equalp a "h")                (list-hand))
                              ((equalp a "b")                (list-battlefield))
                              ((equalp a "g")                (list-graveyard))
                              ((equalp a "e")                (list-exile))
                              (t                             (list-commands))))))

(defun untap-step () 
        (with-color 'yellow (format t "Untap Step~%"))
        ;(phasing)
        ;(untap-all))
        nil)

(defun upkeep-step () 
        (with-color 'yellow (format t "Upkeep Step~%"))
        ;(triggers)
        (get-priority)
        nil)

(defun draw-step ()
        (with-color 'yellow (format t "Draw Step~%"))
        (draw *player1*)
        ;(draw active-player 1)
        ;(triggers)
        (get-priority)
        nil)

(defun beginning-phase ()
        (with-color 'green (format t "--- Beginning Phase ---~%"))
	(untap-step)
	(upkeep-step)
	(draw-step))

(defun main-phase (which)
        (with-color 'green (format t "--- Main Phase ~a ---~%" which))
	(get-priority)
        ;(play-land))
        nil)

(defun beginning-of-combat-step ()
      (with-color 'yellow (format t "Beginning of Combat Step~%"))
      ;507.1. First, if the game being played is a multiplayer game in which the active player’s opponents don’t all automatically become defending players,
      ;       the active player chooses one of his or her opponents. That player becomes the defending player. This turn-based action doesn’t use the stack. (See rule 506.2.)
      ;507.2. Second, any abilities that trigger at the beginning of combat go on the stack. (See rule 603, “Handling Triggered Abilities.”)
      (get-priority)) ;507.3

(defun declare-attackers-step () 
      (with-color 'yellow (format t "Declare Attackers Step~%"))
      (get-priority))

(defun declare-blockers-step ()
      (with-color 'yellow (format t "Declare Blockers Step~%"))
      (get-priority))

(defun combat-damage-step () 
      (with-color 'yellow (format t "Combat Damage Step~%"))
      (get-priority))

(defun end-of-combat-step ()
      (with-color 'yellow (format t "End of Combat Step~%"))
      ; 511.1 First, all “at end of combat” abilities trigger and go on the stack. (See rule 603, “Handling Triggered Abilities.”) 
      (get-priority)) ;511.2
      ; 511.3 As soon as the end of combat step ends, all creatures and planeswalkers are removed from combat.
      ;       After the end of combat step ends, the combat phase is over and the postcombat main phase begins (see rule 505).

(defun combat-phase ()
        (with-color 'green (format t "--- Combat Phase ---~%"))
        (beginning-of-combat-step)
        (declare-attackers-step)
        (declare-blockers-step)
        (combat-damage-step)
        (end-of-combat-step))

(defun end-step ()
        (with-color 'yellow (format t "End Step~%"))
	(get-priority))

(defun cleanup-step ()
        (with-color 'yellow (format t "Cleanup Step~%")))

(defun ending-phase ()
        (with-color 'green (format t "--- Ending Phase ---~%"))
	(end-step)
	(cleanup-step))

(defun turn (player)
        (setf *active-player* player) 
        (with-color 'cyan (format t "========= ~a's Turn =========~%" (name player)))
	(beginning-phase)
	(main-phase 1)
	(combat-phase)
	(main-phase 2)
	(ending-phase))
