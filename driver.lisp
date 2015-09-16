(setf *all-cards* (append (build-singleton-deck *price-of-glory*)
                                  (build-singleton-deck *infernal-intervention*)))

(defparameter *bob*   (make-instance 'player :name "Bob"   :library (build-deck *price-of-glory*)))
(defparameter *alice* (make-instance 'player :name "Alice" :library (build-deck *infernal-intervention*)))
(setf *all-players* (list *bob* *alice*))

(setf *apnap-circle* (copy-list *all-players*))
(circular! *apnap-circle*)

(defun owndeck! (player)
        (mapcar (lambda (x)
                        (set-card-owner      x player)
                        (set-card-controller x player))
                (slot-value player 'library)))
 
(defun main ()
        (shuffle *bob*)
        (shuffle *alice*)
        (owndeck! *bob*)
        (owndeck! *alice*)
        (drawn *bob*   20)
        (drawn *alice* 20)
        (loop until *game-over* do
              (turn *bob*)
              (turn *alice*))
	(format t "Game ended~%"))

(defun bwmain ()
        (bw)
        (main))
