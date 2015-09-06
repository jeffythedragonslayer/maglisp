(defclass player ()
        ((name    :initarg :name                  :accessor name)
         (life    :initarg :life :initform 20     :accessor life)
         (library :initarg :library               :accessor library)
         (hand    :initform (make-instance 'hand) :accessor hand)))

(defun is-teammate (player1 player2))
(defun is-opponent (player1 player2))
(defun get-apnap ()) 
(defun get-active-player ())

(defun gain-life (player num) nil)
(defun lose-life (player num) nil)
(defun set-life  (player num) nil)
(defun gain-poison (player num) nil)
(defun lose-poison (player num) nil)

(defclass team ()
        ((name)
         (teammates :initarg :teammates)))

(defun tapped-out (player))

(defun shuffle (player))
