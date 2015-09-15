(setf *all-cards* (append (build-singleton-deck *price-of-glory*)
                                  (build-singleton-deck *infernal-intervention*)))

(defparameter *bob*   (make-instance 'player :name "Bob"   :library (build-deck *price-of-glory*)))
(defparameter *alice* (make-instance 'player :name "Alice" :library (build-deck *infernal-intervention*)))
(setf *all-players* (list *bob* *alice*))

(setf *apnap-circle* (copy-list *all-players*))
(circular! *apnap-circle*)


(defun main ()
        (shuffle *bob*)
        (shuffle *alice*)
        (drawn *bob*   7)
        (drawn *alice* 7)
        (loop until *game-over* do
              (turn *bob*)
              (turn *alice*))
	(format t "Game ended~%"))

