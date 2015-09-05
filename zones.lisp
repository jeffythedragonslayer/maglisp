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
