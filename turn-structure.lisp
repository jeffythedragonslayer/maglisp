(defparameter *player1* (make-instance 'player :name "Bob"   :library (build-deck *price-of-glory*)))
(defparameter *player2* (make-instance 'player :name "Alice" :library (build-deck *infernal-intervention*)))

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
	    (mapcar #'print (slot-value *mtg-battlefield* 'objs))
	    (format t "~%"))))

(defun list-graveyard ()
    (if (null (objs *mtg-graveyard*))
	(format t "The graveyard is empty~%")
	(progn
	    (format t "Graveyard: ")
	    (mapcar #'print (slot-value *mtg-graveyard* 'objs))
	    (format t "~%"))))

(defun list-exile ()
    (if (null (objs *mtg-exile*))
	(format t "The exile zone is empty~%")
	(progn
	    (format t "Exile: ")
	    (mapcar #'print (slot-value *mtg-exile* 'objs))
	    (format t "~%"))))

(defun list-commands ()
    (format t "commands available:~%")
    (format t "quit - concede the game~%")
    (format t "cast [card]~%")
    (format t "play [card]~%")
    (format t "activate [ability]~%")
    (format t "faceup [permanent]~%")
    (format t "h - list cards in hard~%")
    (format t "b - list cards on battlefield~%")
    (format t "g - list cards in graveyard~%")
    (format t "e - list cards in exile zone~%"))

(defun get-priority ()
	(loop (format t "priority> ")
	      (let ((a (read-line)))
		(cond ((equal a "quit")     (progn (format t "quitting~%") (concede *player1*) (return)))
		      ((equal a "cast")     (progn (format t "cast~%") (return)))
		      ((equal a "play")     (progn (format t "play~%") (return)))
		      ((equal a "activate") (progn (format t "activate~%") (return)))
		      ((equal a "faceup")   (progn (format t "faceup")) (return))
		      ((equal a "h") (list-hand))
		      ((equal a "b") (list-battlefield))
		      ((equal a "g") (list-graveyard))
		      ((equal a "e") (list-exile))
		      (t (list-commands))))))

        (defun untap-step ()
	        (format t "Untap Step~%")
                ;(phasing)
                ;(untap-all))
	        nil)
        (defun upkeep-step ()
	        (format t "Upkeep Step~%")
                ;(triggers)
                (get-priority)
	        nil)
        (defun draw-step ()
	        (format t "Draw Step~%")
		(draw *player1*)
                ;(draw active-player 1)
                ;(triggers)
                (get-priority)
	         nil)

(defun beginning-phase ()
        (format t "Beginning Phase~%")
	(untap-step)
	(upkeep-step)
	(draw-step))

(defun main-phase (which)
        (format t "Main Phase ~a~%" which)
	(get-priority)
        ;(play-land))
        nil)

    (defun beginning-of-combat-step ()
      (format t "Beginning of Combat Step~%")
      ;507.1. First, if the game being played is a multiplayer game in which the active player’s opponents don’t all automatically become defending players,
      ;       the active player chooses one of his or her opponents. That player becomes the defending player. This turn-based action doesn’t use the stack. (See rule 506.2.)
      ;507.2. Second, any abilities that trigger at the beginning of combat go on the stack. (See rule 603, “Handling Triggered Abilities.”)
      (get-priority)) ;507.3

    (defun declare-attackers-step ()
      (format t "Declare Attackers Step~%")
      (get-priority))

    (defun declare-blockers-step ()
      (format t "Declare Blockers Step~%")
      (get-priority))

    (defun combat-damage-step ()
      (format t "Combat Damage Step~%") 
      (get-priority))

    (defun end-of-combat-step ()
      (format t "End of Combat Step~%") 
      ; 511.1 First, all “at end of combat” abilities trigger and go on the stack. (See rule 603, “Handling Triggered Abilities.”) 
      (get-priority)) ;511.2
      ; 511.3 As soon as the end of combat step ends, all creatures and planeswalkers are removed from combat.
      ;       After the end of combat step ends, the combat phase is over and the postcombat main phase begins (see rule 505).

(defun combat-phase ()
  (format t "Combat Phase~%")
  (beginning-of-combat-step)
  (declare-attackers-step)
  (declare-blockers-step)
  (combat-damage-step)
  (end-of-combat-step))

(defun end-step ()
	(format t "End Step~%")
	(get-priority))

(defun cleanup-step ()
	(format t "Cleanup Step~%"))

(defun ending-phase ()
        (format t "Ending Phase~%")
	(end-step)
	(cleanup-step))

(defun turn ()
	(beginning-phase)
	(main-phase 1)
	(combat-phase)
	(main-phase 2)
	(ending-phase))

(defun main ()
        (loop until *game-over* do (turn))
	(format t "Game ended~%"))

(defun draw (player) ; move a card from the library to the hand
        (if (null (library player))
	    (lose-game player) 
	    (let ((card (car (library player))))
		    (setf (library player) (cdr (library player)))
		    (setf (objs (hand player)) (cons card (objs (hand player)))))))
