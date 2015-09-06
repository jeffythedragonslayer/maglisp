(load "util.lisp")
(load "todo/event.lisp")
(load "card.lisp")
(load "land.lisp")
(load "todo/planeswalker.lisp")
(load "variants/grand-melee.lisp")
(load "variants/free-for-all.lisp")
(load "state-based-actions.lisp")
(load "variants/shared-team-turns.lisp")
(load "decks/deck-util.lisp")
(load "decks/infernal-intervention.lisp")
(load "decks/price-of-glory.lisp") 
(load "turn-structure.lisp")
(load "player.lisp")

(defparameter *player1*    (make-instance 'player :name "Bob"   :library (build-deck *price-of-glory*)))
(defparameter *player2*    (make-instance 'player :name "Alice" :library (build-deck *infernal-intervention*)))
(defparameter *game-over*  'nil)

(defun main ()
        (loop until *game-over* do
              (turn *player1*)
              (turn *player2*))
	(format t "Game ended~%"))

(defun win-game (player)
        (format t "Game Over ")
        (format t "~a~%" (name player)))

(defun lose-game (player)
        (setf *game-over* t)
        (format t "Game Over ")
        (format t "~a~%" (name player)))

(defun concede (player)
        (lose-game player))

