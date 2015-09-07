(load "zones.lisp")

(defparameter *tap-symbol*                 'T)
(defparameter *untap-symbol*               'Q)

(defclass mtg-object   ()
        ((owner      :initarg :owner      :accessor owner)
         (controller :initarg :controller :accessor controller)))

(defclass card (mtg-object)
        ((name                :initarg :name                :accessor name)
         (cmc                 :initarg :cmc                 :accessor cmc)
         (artist              :initarg :artist              :accessor artist)
         (rarity              :initarg :rarity              :accessor rarity)
         (flavor              :initarg :flavor :initform "" :accessor flavor)
         (text                :initarg :text                :accessor text)
         (abilities           :initarg :abilities           :accessor abilities)
         (triggered-abilities :initarg :triggered-abilities :accessor triggered-abilities)
         (colors              :initarg :colors              :accessor colors)))

(defclass copy-of-card (mtg-object) ())

(defclass spell (card) ())
(defclass permanent (mtg-object)
        ((tapped   :initarg :tapped   :initform nil :accessor tapped)
         (facedown :initarg :facedown :initform nil :accessor facedown)))

(defclass snow () ())

(defclass attachable (mtg-object)
        ((attach-target :initarg :attach-target :accessor attach-target)
         (timestamp     :initarg :timestamp     :accessor timestamp)))

(defclass artifact (card permanent) ()) 
        (defclass equipment (artifact attachable) ())
        (defclass fortification (artifact attachable) ())
        (defclass contraption (artifact) ())
(defclass artifact-creature (artifact creature) ())
(defclass artifact-lands (artifact lands) ())
(defclass instant (spell) ())
        (defclass interrupt (spell) ())
        (defclass trap (spell) ())
        (defclass arcane (spell) ())
(defclass sorcery (spell) ())
(defclass enchantment (spell) ())
        (defclass curse (enchantment) ())
        (defclass shrine (spell) ())
        (defclass world (enchantment) ())
(defclass aura (enchantment attachable) ())
(defclass token (mtg-object) ())
(defclass legend () ())
(defclass enchantment-artifact (enchantment artifact) ())
(defclass enchantment-creature (enchantment creature) ())
(defclass artifact-enchantment-creature (artifact-enchantment creature) ())

(defclass emblem (mtg-object) ())

(defun get-controller () nil)
(defun get-owner      () nil)

(defun converted-mana-cost (mtg-obj))
;(defgeneric damage (perm))

(defun tap (perm)
        (setf (tapped perm) t))

(defun untap (perm)
        (setf (tapped perm) nil))

(defun flip-faceup (perm)
        (setf (facedown perm) nil))

(defun flip-facedown (perm)
        (setf (facedown perm) t))

(defun attach (source target)
        (setf (attach-target source) target)
        (setf (timestamp     source) (get-universal-time)))

(defun detach (source)
        (setf (attach-target source) nil)
        (setf (timestamp     source) nil))

(defun proliferate ())

(defun is-vanilla (card))
(defun get-timestamp () 'nil)
(defun devotion (player type))

(defmethod print-object ((obj mtg-object) stream)
        (format stream "~a~%" (name obj)))
