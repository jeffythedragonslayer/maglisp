(defparameter *planeswalker-symbol*        'PW)
(defparameter *planeswalker-types* '(Ajani Ashiok Bolas Chandra Dack Daretti Domri Elspeth Freyalise Garruk Gideon Jace Karn Kiora Koth Liliana Nahiri
                                     Narset Nissa Nixilis Ral Sarkhan Sorin Tamiyo Teferi Tezzeret Tibalt Ugin Venser Vraska Xenagos))

(defclass planeswalker-data ()
        ((loyalty))) 

(defun get-planeswalker-loyalty (x)
        (slot-value (slot-value x 'planeswalker-dat) 'loyalty))

(defun set-planeswalker-loyalty (x loy)
        (setf (slot-value (slot-value x 'planeswalker-dat) 'loyalty) loy))
