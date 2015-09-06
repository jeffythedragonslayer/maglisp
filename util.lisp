(defun shuffle-list (sequence)
        (loop for i from (length sequence) downto 2
              do (rotatef (elt sequence (random i))
                         (elt sequence (1- i))))
              sequence)

(defmacro let1 (var val &body body)
        `(let ((,var ,val))
                ,@body))

(defmacro with-color (col &body body)
        `(progn
                (color ,col)
                ,@body
                (color 'white)))

(defun color (col)
        (cond 
                ((eq col 'white)  (format t "~C[0m"  #\Esc))
                ((eq col 'black)  (format t "~C[30m" #\Esc))
                ((eq col 'black)  (format t "~C[30m" #\Esc))
                ((eq col 'red)    (format t "~C[31m" #\Esc))
                ((eq col 'green)  (format t "~C[32m" #\Esc))
                ((eq col 'yellow) (format t "~C[33m" #\Esc))
                ((eq col 'blue)   (format t "~C[34m" #\Esc))
                ((eq col 'purple) (format t "~C[35m" #\Esc))
                ((eq col 'cyan)   (format t "~C[36m" #\Esc))))
