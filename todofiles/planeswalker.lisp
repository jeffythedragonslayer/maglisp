(defparameter *planeswalker-symbol*        'PW)
(defparameter *planeswalker-types* '(Ajani Ashiok Bolas Chandra Dack Daretti Domri Elspeth Freyalise Garruk Gideon Jace Karn Kiora Koth Liliana Nahiri
                                     Narset Nissa Nixilis Ral Sarkhan Sorin Tamiyo Teferi Tezzeret Tibalt Ugin Venser Vraska Xenagos))

(defclass planeswalker-data (card)
        ((loyalty)))

(defun get-planeswalker-loyalty (planeswalker)
        (slot-value (slot-value planeswalker 'planeswalker-dat) 'loyalty))

(defun set-planeswalker-loyalty (planeswalker loy)
        (setf (slot-value (slot-value planeswalker 'planeswalker-dat) 'loyalty) loy))
