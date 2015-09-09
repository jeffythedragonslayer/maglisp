(defun duplicate-card (card num)
        (loop for i from 1 upto num collect (copy-card card)))

(defun build-deck (cardlist)
        (loop for pair in cardlist append (duplicate-card (eval (cadr pair)) (car pair))))

(defun build-singleton-deck (cardlist)
        (loop for pair in cardlist append (duplicate-card (eval (cadr pair)) 1)))

(defun print-deck (deck)
        (mapcar #'print deck))

