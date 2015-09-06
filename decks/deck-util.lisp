(load "~/maglisp/creature.lisp")

(defun build-deck (cardlist)
        (loop for pair in cardlist append (make-list (car pair) :initial-element (cadr pair))))

(defun print-deck (deck)
        (mapcar #'print deck))

