(defclass zone ()
        ((objs :initform nil :accessor objs)))

(defclass public-zone   (zone) ()) ; 400.2
(defclass hidden-zone   (zone) ()) ; 400.2
(defclass personal-zone (zone) ()) ; 400.1

(defclass library     (hidden-zone personal-zone) ())
(defclass hand        (hidden-zone personal-zone) ()) 
(defclass graveyard   (public-zone personal-zone) ()) 
(defclass battlefield (public-zone) ()) 
(defclass stack       (public-zone) ()) 
(defclass exile       (public-zone) ()) 
(defclass command     (public-zone) ())
(defclass ante        (public-zone) ()) 

(defclass sideboard ()
  	((objs :initform nil :accessor objs)))

(defparameter *mtg-stack*       (make-instance 'stack))
(defparameter *mtg-battlefield* (make-instance 'battlefield))
(defparameter *mtg-graveyard*   (make-instance 'graveyard))
(defparameter *mtg-exile*       (make-instance 'exile))
(defparameter *mtg-command*     (make-instance 'command))
(defparameter *mtg-ante*        (make-instance 'ante))
(defparameter *mtg-sideboard*   (make-instance 'sideboard))

(defun draw (player) ; move a card from the library to the hand
        (if (null (library player))
	    (lose-game player) 
	    (let ((card (car (library player))))
		    (setf (library player) (cdr (library player)))
		    (setf (objs (hand player)) (cons card (objs (hand player)))))))

(defun drawn (player n)
        (loop for i from 1 upto n do (draw player)))

(defun mill (player) ; move a card from the library to the graveyard
        (if (null (library player))
	    (lose-game player) 
	    (let ((card (car (library player))))
		    (setf (library player) (cdr (library player)))
		    (setf (objs (graveyard player)) (cons card (objs (graveyard player)))))))

(defun hand-size (player)) 
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
