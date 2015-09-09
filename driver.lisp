(defparameter *all-cards* (append (build-singleton-deck *price-of-glory*)
                                  (build-singleton-deck *infernal-intervention*)))

(defparameter *player1*    (make-instance 'player :name "Bob"   :library (build-deck *price-of-glory*)))
(defparameter *player2*    (make-instance 'player :name "Alice" :library (build-deck *infernal-intervention*)))
(defparameter *game-over*  'nil)

(defun main ()
        (shuffle *player1*)
        (shuffle *player2*)
        (drawn *player1* 7)
        (drawn *player2* 7)
        (loop until *game-over* do
              (turn *player1*)
              (turn *player2*))
	(format t "Game ended~%"))

(defun win-game (player)
        (format t "Game Over ")
        (format t "~a~%" (get-player-name player)))

(defun lose-game (player)
        (setf *game-over* t)
        (format t "Game Over ")
        (format t "~a~%" (get-player-name player))
        (error 'gameover "game over"))

(defun concede (player)
        (lose-game player))
