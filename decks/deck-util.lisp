(defun duplicate-card (card num)
        (loop for i from 1 upto num collect (copy-card card)))

(defun build-deck (cardlist)
        (loop for pair in cardlist append (make-list (car pair) :initial-element (cadr pair))))

(defun print-deck (deck)
        (mapcar #'print deck))

