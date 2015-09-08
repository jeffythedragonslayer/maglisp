(load "zones.lisp")

(defparameter *tap-symbol*                 'T)
(defparameter *untap-symbol*               'Q)

(defclass mtg-object   ()
        ((owner      :initarg :owner      :accessor owner)
         (controller :initarg :controller :accessor controller)))

(defclass characteristics () ; 109.3
        ((name                :initarg :name                :accessor name)
         (cmc                 :initarg :cmc                 :accessor cmc)
         (colors              :initarg :colors              :accessor colors)
         (color-indicator     :initarg :color-indicator     :accessor color-indicator)
         (cardtypes           :initarg :cardtypes           :accessor cardtypes)
         (subtype             :initarg :subtype             :accessor subtype)
         (supertype           :initarg :supertype           :accessor supertype)
         (text                :initarg :text                :accessor text)
         (abilities           :initarg :abilities           :accessor abilities)
         (power               :initarg :power               :accessor power)
         (toughness           :initarg :toughness           :accessor toughness)
         (loyalty             :initarg :loyalty             :accessor loyalty)
         (hand-modifier       :initarg :hand-modifier       :accessor hand-modifier)
         (life-modifier       :initarg :life-modifier       :accessor life-modifier)))

(defclass status () ; 110.6
        ((tapped   :initarg :tapped   :initform nil :accessor tapped)
         (flipped  :initarg :flipped  :initform nil :accessor flipped)
         (faceup   :initarg :faceup   :initform t   :accessor faceup)
         (phasedin :initarg :phasedin :initform t   :accessor phasedin)))

(defclass card (mtg-object)
        ((artist              :initarg :artist              :accessor artist)
         (rarity              :initarg :rarity              :accessor rarity)
         (flavor              :initarg :flavor :initform "" :accessor flavor)
         (characteristics     :initarg :characteristics     :accessor characteristics :initform (make-instance 'characteristics))
         (status              :initarg :status              :accessor status          :initform (make-instance 'status))))

(defun card-name (card)
        (slot-value (slot-value card 'characteristics) 'name))

(defun make-card (&key name cmc colors types subtype supertype text abilities
                       static-abilities tap-abilities activated-abilities triggered-abilities
                       power toughness loyalty artist rarity flavor)
        (let* ((chars (make-instance 'characteristics))
	       (stats (make-instance 'status))
	       (c     (make-instance 'card)))
	  (progn
                (setf (slot-value chars 'name)      name)
                (setf (slot-value chars 'cmc)       cmc)
                (setf (slot-value chars 'colors)    colors)
                (setf (slot-value chars 'cardtypes) types)
                (setf (slot-value chars 'subtype)   subtype)
                (setf (slot-value chars 'supertype) supertype)
                (setf (slot-value chars 'text)      text)
                (setf (slot-value chars 'power)     power)
                (setf (slot-value chars 'toughness) toughness)
                (setf (slot-value chars 'loyalty)   loyalty)
                (setf (slot-value c 'characteristics) chars)
                (setf (slot-value c 'status) stats)
	        c)))
	       

;(defclass copy-of-card (mtg-object) ())

;(defclass spell (card) ())
;(defclass permanent (mtg-object)
;        ((tapped   :initarg :tapped   :initform nil :accessor tapped)
;         (facedown :initarg :facedown :initform nil :accessor facedown)))

;(defclass card-permanent (permanent)
;        ())

;(defclass snow () ())

;(defclass attachable (mtg-object)
;        ((attach-target :initarg :attach-target :accessor attach-target)
;         (timestamp     :initarg :timestamp     :accessor timestamp)))

;(defclass artifact (card permanent) ()) 
;        (defclass equipment (artifact attachable) ())
;        (defclass fortification (artifact attachable) ())
;        (defclass contraption (artifact) ())
;(defclass artifact-creature (artifact creature) ())
;(defclass artifact-lands (artifact lands) ())
;(defclass instant (spell) ())
;        (defclass interrupt (spell) ())
;        (defclass trap (spell) ())
;        (defclass arcane (spell) ())
;(defclass sorcery (spell) ())
;(defclass enchantment (spell) ())
;        (defclass curse (enchantment) ())
 ;       (defclass shrine (spell) ())
;        (defclass world (enchantment) ())
;(defclass aura (enchantment attachable) ())
;(defclass token (permanent) ())
;(defclass legend () ())
;(defclass enchantment-artifact (enchantment artifact) ())
;(defclass enchantment-creature (enchantment creature) ())
;(defclass artifact-enchantment-creature (artifact-enchantment creature) ())

(defclass emblem (mtg-object) ())

(defun get-controller () nil)
(defun get-owner      () nil)

;(defun converted-mana-cost (mtg-obj))
;(defgeneric damage (perm))

;(defun tap (perm)
;        (setf (tapped perm) t))

;(defun untap (perm)
;        (setf (tapped perm) nil))

;(defun flip-faceup (perm)
;        (setf (facedown perm) nil))

;(defun flip-facedown (perm)
;        (setf (facedown perm) t))

;(defun attach (source target)
;        (setf (attach-target source) target)
;        (setf (timestamp     source) (get-universal-time)))

;(defun detach (source)
;        (setf (attach-target source) nil)
;        (setf (timestamp     source) nil))

;(defun proliferate ())

;(defun is-vanilla (card))
;(defun get-timestamp () 'nil)
;(defun devotion (player type))

(defmethod print-object ((obj card) stream)
        (format stream "~a~%" (card-name obj)))
