(defparameter *active-player* 'nil)

(defun list-hand ()
    (if (null (objs (hand *player1*)))
	(format t "The hand is empty~%")
	(progn
	    (format t "Hand: ")
	    (mapcar #'print (objs (hand *player1*)))
	    (format t "~%"))))

(defun list-battlefield ()
    (if (null (objs *mtg-battlefield*))
	(format t "The battlefield is empty~%")
	(progn
	    (format t "Battlefield: ")
	    (mapcar #'print (objs *mtg-battlefield*))
	    (format t "~%"))))

(defun list-graveyard ()
    (if (null (objs *mtg-graveyard*))
	(format t "The graveyard is empty~%")
	(progn
	    (format t "Graveyard: ")
	    (mapcar #'print (objs *mtg-graveyard*))
	    (format t "~%"))))

(defun list-exile ()
        (if (null (objs *mtg-exile*))
            (format t "The exile zone is empty~%")
            (progn
                (format t "Exile: ")
                (mapcar #'print (objs *mtg-exile*))
                (format t "~%"))))

(defun list-commands ()
        (format t "commands available:~%")
        (format t "p                    - pass priority~%")
        (format t "h                    - list cards in hand~%")
        (format t "b                    - list cards on battlefield~%")
        (format t "g                    - list cards in graveyard~%")
        (format t "e                    - list cards in exile zone~%")
        (format t "cast [card]          - cast a card~%")
        (format t "play [land]          - play a land~%")
        (format t "activate [ability]   - activate an ability~%")
        (format t "faceup [permanent]   - turn a permanent faceup~%")
        (format t "concede              - concede the game~%"))

(defun get-priority ()
	(loop 
                (with-color 'red (format t "~a-> " (name *active-player*)))
                (let1 a (read-line)
                        (cond ((equal a "concede")  (progn (format t "conceding~%") (concede *player1*) (return)))
                              ((equal a "p")                                                            (return))
                              ((equal a "cast")     (progn (format t "cast~%")                          (return)))
                              ((equal a "play")     (progn (format t "play~%")                          (return)))
                              ((equal a "activate") (progn (format t "activate~%")                      (return)))
                              ((equal a "faceup")   (progn (format t "faceup"))                         (return))
                              ((equal a "h")        (list-hand))
                              ((equal a "b")        (list-battlefield))
                              ((equal a "g")        (list-graveyard))
                              ((equal a "e")        (list-exile))
                              (t                    (list-commands))))))

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
