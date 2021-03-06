(defun list-hand        (player) (mapcar (lambda (x) (format t "~a~%" (get-card-name x))) (get-player-hand player)))
(defun list-graveyard   ()       (mapcar (lambda (x) (format t "~a~%" (get-card-name x))) *graveyard*))
(defun list-exile       ()       (mapcar (lambda (x) (format t "~a~%" (get-card-name x))) *exile*))

(defun list-battlefield ()       (mapcar (lambda (x) (print-card x)) *battlefield*))
(defun list-manapool    (player) (format t "~a~%" (get-player-manapool player)))
(defun list-life        (player) (format t "~a~%" (get-player-life player)))

(defun list-commands ()
        (format t "commands available:                             ~%~
                   p                    - pass priority            ~%~
                   h                    - list cards in hand       ~%~
                   b                    - list cards on battlefield~%~
                   g                    - list cards in graveyard  ~%~
                   e                    - list cards in exile zone ~%~
                   fm                   - free mana                ~%~
                   mp                   - see mana pool            ~%~
                   desc                 - describe text on card    ~%~
                   cast                 - cast a card              ~%~
                   play                 - play a land              ~%~
                   tap                  - tap a land for mana      ~%~
                   untap                - untap a land for mana    ~%~
                   activate [ability]   - activate an ability      ~%~
                   faceup [permanent]   - turn a permanent faceup  ~%~
                   concede              - concede the game         ~%"))

(defun list-attackers-commands()
        (format t "commands available:                                          ~%~
                   commit               - commit to chosen attackers            ~%~
                   h                    - list cards in hand                    ~%~
                   b                    - list cards on battlefield             ~%~
                   g                    - list cards in graveyard               ~%~
                   e                    - list cards in exile zone              ~%~
                   fm                   - free mana                             ~%~
                   mp                   - see mana pool                         ~%~
                   attack               - attack opponent with a creature       ~%~
                   unattack             - don't attack opponent with a creature ~%~
                   la                   - list attackers                        ~%~
                   concede              - concede the game                      ~%"))

(defun list-blockers-commands ()
        (format t "commands available:                                          ~%~
                   commit               - commit to chosen blockers             ~%~
                   h                    - list cards in hand                    ~%~
                   b                    - list cards on battlefield             ~%~
                   g                    - list cards in graveyard               ~%~
                   e                    - list cards in exile zone              ~%~
                   fm                   - free mana                             ~%~
                   mp                   - see mana pool                         ~%~
                   block                - block opponent with a creature        ~%~
                   unblock              - don't block opponent with a creature  ~%~
                   la                   - list attackers                        ~%~
                   concede              - concede the game                      ~%"))

(defun free-mana (player num)  (set-player-manapool! player (+ num (get-player-manapool player)))) 
(defun pay-mana  (player cost) (set-player-manapool! player (-     (get-player-manapool player) cost)))

(defun play-card (player) 
        (format t "which card? ")
        (let* ((inname    (read-line))
               (handcards (get-player-hand player))
               (c         (find-if (lambda (x) (equalp inname (get-card-name x))) handcards)))
                     (unless c                              (beep-format t "not a card in your hand        ~%") (return-from play-card nil))
                     (unless (land? c)                      (beep-format t "not a land, use cast for spells~%") (return-from play-card nil))
                     (unless (equal *active-player* player) (beep-format t "not your turn                  ~%") (return-from play-card nil))
                     (when (get-player-playedland player)
                           (beep-format t "already played a land this turn~%")
                           (return-from play-card nil))
                     (format t "playing ~a~%" (get-card-name c))
                     (setf *battlefield* (cons c *battlefield*))
                     (set-player-playedland! player t)
                     (set-player-hand! player (remove c handcards :count 1))
                     t))

(defun cast-card (player)
        (format t "which card? ")
        (let* ((inname    (read-line))
               (handcards (get-player-hand player))
               (c         (find-if (lambda (x) (equalp inname (get-card-name x))) handcards)))
                        (unless c         (beep-format t "not a card in your hand          ~%") (return-from cast-card nil))
                        (when   (land? c) (beep-format t "can't cast land, use play instead~%") (return-from cast-card nil)) 
                        (when (< (get-player-manapool player) (get-card-cmc c))
                              (beep-format t "insufficient mana, ~a costs ~a~%" (get-card-name c) (get-card-cmc c))
                              (return-from cast-card nil))
                        (unless (or (instant? c)
                                    (equal *active-player* player))
                                (format t "not your turn~%")
                                (return-from cast-card nil))
                        (format t "casting ~a~%" (get-card-name c))
                        (pay-mana player (get-card-cmc c))
                        (set-player-hand! player (remove c handcards :count 1))
                        (push-stack! c)
                        (resolve-stack)
                        t))

(defun describe-card ()
        (format t "which card? ") 
        (let* ((inname (read-line))
               (c (find-if (lambda (x) (equalp inname (get-card-name x))) *all-cards*)))
                      (unless c (beep-format t "not a valid card name~%") (return-from describe-card))
                      (print-card c)))

(defun tap-card (player) 
        (format t "which card?")
        (let1 c (nth (read-int 0 (1- (length *battlefield*))) *battlefield*)
                  (unless (equal player (get-card-controller c)) (beep-format t "you don't control ~a~%" (get-card-name c)) (return-from tap-card nil))
                  (when (tapped? c)                              (beep-format t "~a already tapped   ~%" (get-card-name c)) (return-from tap-card nil))
                  (tap! c)
                  (free-mana player 1000)
                  (format t "tapped ~a~%" (get-card-name c))
                  t))
	  
(defun untap-card (player) 
        (format t "which card?")
        (let1 c (nth (read-int 0 (1- (length *battlefield*))) *battlefield*)
                  (unless (equal player (get-card-controller c)) (beep-format t "you don't control ~a ~%" (get-card-name c)) (return-from untap-card nil))
                  (unless (tapped? c)                            (beep-format t "~a already untapped  ~%" (get-card-name c)) (return-from untap-card nil))
                  (untap! c)
                  (format t "untapped ~a~%" (get-card-name c))
                  t))

(defun attack-withcard (player)
        (format t "which creature? ")
        (let* ((c    (nth (read-int 0 (1- (length *battlefield*))) *battlefield*))
               (name (get-card-name c))) 
                      (unless (equal player (get-card-controller c)) (beep-format t "you don't control ~a"                                name) (return-from attack-withcard))
                      (unless (creature? c)                          (beep-format t "~a not a creature, can't attack~%"                   name) (return-from attack-withcard))
                      (when   (sick?     c)                          (beep-format t "~a has summoning sickness, can't attack this turn~%" name) (return-from attack-withcard))
                      (when   (tapped?   c)                          (beep-format t "~a tapped, can't attack~%"                           name) (return-from attack-withcard))
                      (when   (has-static-ability? c 'defender)      (beep-format t "~a has defender, can't attack~%"                     name) (return-from attack-withcard))
                      (when   (member c *attackers*)                 (beep-format t "already attacking with ~a~%"                         name) (return-from attack-withcard))
                      (format t "going to attack with ~a~%" name)
                      (setf *attackers* (cons c *attackers*))))

(defun unattack-withcard (player) 
        (format t "which creature? ")
        (let* ((c    (nth (read-int 0 (1- (length *battlefield*))) *battlefield*))
               (name (get-card-name c)))
                      (unless (equal player (get-card-controller c)) (beep-format t "you don't control ~a"                                name) (return-from unattack-withcard))
                      (unless (creature? c)                          (beep-format t "~a not a creature, can't attack                  ~%" name) (return-from unattack-withcard))
                      (when   (sick?     c)                          (beep-format t "~a has summoning sickness, can't attack this turn~%" name) (return-from unattack-withcard))
                      (when   (tapped?   c)                          (beep-format t "~a tapped, can't attack                          ~%" name) (return-from unattack-withcard)) 
                      (when   (has-static-ability? c 'defender)      (beep-format t "~a has defender, can't attack                    ~%" name) (return-from unattack-withcard))
                      (unless (member c *attackers*)                 (beep-format t "already not attacking with ~a                    ~%" name) (return-from unattack-withcard))
                      (format t "not going to attack with ~a~%" c)
                      (setf *attackers* (remove c *attackers*))))

(defun block-withcard (player) 
        (format t "which creature? ")
        (let* ((c    (nth (read-int 0 (1- (length *battlefield*))) *battlefield*))
               (name (get-card-name c)))
                      (unless (equal player (get-card-controller c)) (beep-format t "you don't control ~a          ~%" name) (return-from block-withcard))
                      (unless (creature? c)                          (beep-format t "~a not a creature, can't block~%" name) (return-from block-withcard))
                      (when   (tapped?   c)                          (beep-format t "~a tapped, can't block        ~%" name) (return-from block-withcard))
                      (when   (member c *blockers*)                  (beep-format t "already blocking with ~a      ~%" name) (return-from block-withcard))
                      (let1 blocking nil
                              (if (= 1 (length *attackers*))
                                  (setf blocking (car *attackers*)) ; default to only attacker
                                  (progn
                                          (format t "choose an attacker to block [num]: ")
                                          (finish-output nil)
                                          (setf blocking (nth (read-int 0 (1- (length *battlefield*))) *blockers*))))
                              (format t "going to block with ~a~%" name)
                              (setf *blockers* (cons (cons c blocking) *blockers*)))))

(defun unblock-withcard (player) 
        (format t "which creature?" )
        (let* ((c    (nth (read-int 0 (1- (length *battlefield*))) *battlefield*))
               (name (get-card-name c)))
                      (unless (equal player (get-card-controller c)) (beep-format t "you don't control ~a          ~%" name) (return-from unblock-withcard)) 
                      (unless (creature? c)                          (beep-format t "~a not a creature, can't block~%" name) (return-from unblock-withcard))
                      (when   (tapped?   c)                          (beep-format t "~a tapped, can't block        ~%" name) (return-from unblock-withcard))
                      (unless (member c *blockers*)                  (beep-format t "already not blocking with ~a  ~%" name) (return-from unblock-withcard))
                      (format t "not going to block with ~a~%" name)
                      (setf *blockers* (remove-if (lambda (x) (equal (car x) c)) *blockers*))))

(defun commit-attackers ()
        (format t "commited attackers~%"))

(defun get-blockers (attacker)
        (mapcar (lambda (x)
                        (if (equal (car x) attacker)
                            (cdr attacker)
                            nil))
                *blockers*))

(defun unblocked? (attacker)
        (null (get-blockers attacker)))

(defun simultaneous-damage (attacker blocker)
        (format t "~a and ~a are dealing damage simultaneously~%" (get-card-name attacker) (get-card-name blocker))
        (do-damage! attacker (get-card-power blocker))
        (do-damage! blocker  (get-card-power attacker)))

(defun deal-damage (target-player)
        (mapcar (lambda (attacker)
                        (if (unblocked? attacker)
                            (let1 num (get-card-power attacker)
                                  (lose-life! target-player num)
                                  (format t "~a dealt ~a damage to ~a~%" (get-card-name attacker) num (get-player-name target-player))
                                  (when (has-static-ability? attacker 'lifelink)
                                        (gain-life! *active-player* num)
                                        (format't "~a gained ~a ~a life from lifelink" (get-card-name attacker) (get-player-name *active-player*) num)))
                            (mapcar (lambda (x) (simultaneous-damage attacker x)) *blockers*))) 
                *attackers*)
        (setf *attackers* nil)
        (setf *blockers*  nil))

(defun commit-blockers ()
        (format t "committed blockers~%"))

(defun list-attackers () (mapcar #'print-card *attackers*)) 
(defun list-blockers  () (mapcar #'print-card *blockers*))

(defun get-priority (player)
        (check-state-based-actions!)
        (with-color 'red (format t "~a priority-> " (get-player-name player)))
	(loop 
                (finish-output nil)
                (case (intern (string-upcase (read-line)))
                      (concede   (progn (format t "conceding~%") (concede! player) (return-from get-priority nil)))
                      (p                                                           (return-from get-priority nil))
                      (cast      (when (cast-card player)                          (return-from get-priority t)))
                      (play      (when (play-card player)                          (return-from get-priority t)))
                      (tap       (when (tap-card   player))                        (return-from get-priority t))
                      (untap     (when (untap-card player))                        (return-from get-priority t))
                      (activate  (format t "activate~%")                           (return-from get-priority t))
                      (faceup    (format t "faceup")                               (return-from get-priority t))
                      (desc      (describe-card))
                      (mp        (list-manapool player))
                      (fm        (free-mana player 1000))
                      (h         (list-hand player))
                      (b         (list-battlefield))
                      (g         (list-graveyard))
                      (e         (list-exile))
                      (life      (list-life player))
                      (otherwise (progn (beep) (list-commands))))
                (with-color 'red (format t "~a priority | " (get-player-name player)))))

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

(defun prompt-attackers (player)
	(loop   (with-color 'red (format t "~a attackers-> " (get-player-name player)))
                (finish-output nil)
                (case (intern (string-upcase (read-line)))
                      (concede   (progn (format t "conceding~%") (concede! player) (return)))
                      (commit    (progn (commit-attackers)                        (return)))
                      (attack    (  attack-withcard player))
                      (unattack  (unattack-withcard player))
                      (la        (list-attackers))
                      (mp        (list-manapool player))
                      (fm        (free-mana player 1000))
                      (h         (list-hand player))
                      (b         (list-battlefield))
                      (g         (list-graveyard))
                      (e         (list-exile))
                      (life      (list-life player))
                      (otherwise (progn (list-attackers-commands) (beep))))))

(defun prompt-blockers! (player)
	(loop   (with-color 'red (format t "~a blockers-> " (get-player-name player)))
                (finish-output nil)
                (case (intern (string-upcase (read-line)))
                      (concede   (progn (format t "conceding~%") (concede! player) (return)))
                      (commit    (progn (commit-blockers)                         (return)))
                      (block     (block-withcard   player))
                      (unblock   (unblock-withcard player))
                      (la        (list-blockers))
                      (mp        (list-manapool player))
                      (fm        (free-mana player 1000))
                      (h         (list-hand player))
                      (b         (list-battlefield))
                      (g         (list-graveyard))
                      (e         (list-exile))
                      (life      (list-life player))
                      (otherwise (progn (list-blockers-commands) (beep))))))
