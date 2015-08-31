(defun build-deck (cardlist)
  (loop for pair in cardlist append (make-list (car pair) :initial-element (cadr pair))))
