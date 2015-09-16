(defvar *all-cards*    nil) 
(defvar *all-players*  nil)
(defvar *apnap-circle* nil)
(defvar *game-over*    nil)

(defun win-game! (player)
        (format t "Game Over ")
        (format t "~a~%" (get-player-name player)))

(defun lose-game! (player)
        (setf *game-over* t)
        (format t "Game Over ")
        (format t "~a~%" (get-player-name player))
        (error 'gameover "game over"))

(defun concede! (player)
        (lose-game! player))
