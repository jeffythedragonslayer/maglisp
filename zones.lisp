(defparameter *stack*       nil)
(defparameter *battlefield* nil)
(defparameter *graveyard*   nil)
(defparameter *exile*       nil)
(defparameter *command*     nil)
(defparameter *ante*        nil)
(defparameter *sideboard*   nil)

(defun draw (player) ; move a card from the library to the hand
        (if (null (get-player-library player))
	    (lose-game player) 
	    (let ((card (car (get-player-library player))))
		    (set-player-library player (cdr (get-player-library player)))
		    (set-player-hand    player (cons card (get-player-hand player))))))

(defun drawn (player n)
        (loop for i from 1 upto n do (draw player)))

(defun mill (player) ; move a card from the library to the graveyard
        (if (null (get-player-library player))
	    (lose-game player) 
	    (let ((card (car (get-player-library player))))
		    (set-player-library   player (cdr (get-player-library player)))
		    (set-player-graveyard player (cons card (graveyard player))))))

(defun hand-size (player) (length (get-player-hand player)))

(defun mulligan (player))
(defun scry (player num)
  nil)

(defun push-stack     () nil)
(defun resolve-stack  () nil)
(defun stack-empty    () nil)

(defun flicker ())
(defun bounce ()) 

(defun exile     (perm))
(defun destroy   (perm)) 
(defun sacrifice (perm))

(defun graveyard-size (player))
