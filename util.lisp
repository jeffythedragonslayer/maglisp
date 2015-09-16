(defun circular! (items)
        (setf (cdr (last items)) items)
        items)

(setf *print-circle* t)

(defun shuffle-list! (sequence)
        (loop for i from (length sequence) downto 2
              do (rotatef (elt sequence (random i))
                          (elt sequence (1- i))))
              sequence)

(defun sort-symbols (symbols)
        (sort symbols (lambda (x y) (string< (symbol-name x) (symbol-name y)))))

(defmacro let1 (var val &body body)
        `(let ((,var ,val))
                ,@body))

(defparameter *use-colors* t)

(defun bw () (setf *use-colors* nil))

(defun beep ()
        (format t "~a" #\bell))

(defun beep-format (&rest vals)
        (beep)
        (apply #'format vals))

(defmacro with-color (col &body body)
        `(progn
                (when *use-colors* (color ,col))
                ,@body
                (when *use-colors* (color 'white))))

(defun color (col)
        (cond 
                ((eq col 'white)  (format t "~c[0m"  #\Esc))
                ((eq col 'black)  (format t "~c[30m" #\Esc))
                ((eq col 'black)  (format t "~c[30m" #\Esc))
                ((eq col 'red)    (format t "~c[31m" #\Esc))
                ((eq col 'green)  (format t "~c[32m" #\Esc))
                ((eq col 'yellow) (format t "~c[33m" #\Esc))
                ((eq col 'blue)   (format t "~c[34m" #\Esc))
                ((eq col 'purple) (format t "~c[35m" #\Esc))
                ((eq col 'cyan)   (format t "~c[36m" #\Esc))))

(defun string-trim-first-n (str n)
        (subseq str n (length str)))

(defun string-begins-with (str beg)
        (let1 l (length beg)
                (if (>= (length str) l)
                    (equal beg (subseq str 0 (length beg)))
                    nil)))

(defun read-int (low high)
        (when (< high low) (error "high < low"))
        (handler-case
                (let1 num (parse-integer (read-line))
                        (if (or (< num low)
                                (> num high))
                            (progn
                                (beep-format t "enter an integer between ~a and ~a: " low high)
                                (read-int low high))
                            num))
        (condition ()
                (beep-format t "enter an integer: " low high)
                (read-int low high))))
