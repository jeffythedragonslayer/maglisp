(defparameter *stack*       nil)
(defparameter *battlefield* nil)
(defparameter *graveyard*   nil)
(defparameter *exile*       nil)
(defparameter *command*     nil)
(defparameter *ante*        nil)
(defparameter *sideboard*   nil)

(defun draw (player) ; move a card from the library to the hand
        (if (null (get-player-library player))
            (set-player-emptydraw player)
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

(defun push-stack     (card)
        (setf *stack* (cons card *stack*)))

;(defun resolve-stack  (spell)
 ;       (if (or (artifact? spell)
 ;               (instant?  spell))
;            (progn
;                (format t "resolving ~a~%" (get-card-name spell)))))

(defun stack-empty    () (null *stack*))

(defun change-zones (card old-zone new-zone)
        (setf old-zone (remove card old-zone :count 1))
        (setf new-zone (cons card new-zone)))

(defun flicker (card)
        (change-zones perm *battlefield* *exile*)
        (change-zones perm *exile* *battlefield*))

;(defun bounce  (card)) 

(defun exile     (perm) (change-zones perm *battlefield* *exile*))
(defun destroy   (perm) (change-zones perm *battlefield* *graveyard*)) 
(defun sacrifice (perm) (change-zones perm *battlefield* *graveyard*))

;(defun graveyard-size (player)
;        )
