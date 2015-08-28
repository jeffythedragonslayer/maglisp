(load "creature.lisp")
(load "event.lisp")
(load "land.lisp")
(load "planeswalker.lisp")
(load "grand-melee.lisp")
(load "free-for-all.lisp")
(load "state-based-actions.lisp")
(load "turn-structure.lisp")
(load "zones.lisp")
(load "shared-team-turns.lisp")

(defparameter *colors*                     '(white blue black red green))
(defparameter *mana-symbols*               '(W     U    B     R   G))
(defparameter *hybrid-symbols*             '(W/U W/B U/B U/R B/R B/G R/G R/W G/W G/U))
(defparameter *phyrexian-mana-symbols*     '(W/P U/P B/P R/P G/P))
(defparameter *monocolored-hybrid-symbols* '(2/W 2/U 2/B 2/R 2/G))
(defparameter *tap-symbol*                 'T)
(defparameter *untap-symbol*               'Q)
(defparameter *planeswalker-symbol*        'PW)
(defparameter *snow-symbol*                'S)

(defparameter *mana-types* '(white blue black red green colorless))
(defparameter *mana-burn*  'false)

(defclass mtg-object   ()
        ((owner      :initarg :owner)
         (controller :initarg :controller)))

(defclass card (mtg-object)
        ((name      :initarg :name)
         (cmc       :initarg :cmc)
	 (artist    :initarg :artist)
	 (rarity    :initarg :rarity)
	 (flavor    :initarg :flavor)
	 (text      :initarg :text)
	 (abilities :initarg :abilities)
	 (colors    :initarg :colors)))

(defclass copy-of-card (mtg-object) ())

(defclass spell (card) ())
(defclass permanent (mtg-object)
        ((tapped   :initarg :tapped :initform nil)
         (facedown :initarg :facedown :initform nil)))

(defclass snow () ())
(defclass creature (card permanent)
        ((power     :initarg :power)
         (toughness :initarg :toughness)
	 (subtype   :initarg :subtype)
	 (sick      :initform t)
	 (damage    :initform 0)))

(defun print-card (card)
  (format t "Name:      ~a~%" (slot-value card 'name))
  (format t "Subtype:   ~a~%" (slot-value card 'subtype))
  (format t "CMC:       ~a~%" (slot-value card 'cmc))
  (format t "Power:     ~a~%" (slot-value card 'power))
  (format t "Toughness: ~a~%" (slot-value card 'toughness))
  (format t "Flavor:    ~a~%" (slot-value card 'flavor)))

(defclass attachable (mtg-object)
        ((attach-target :initarg :attach-target)
         (timestamp     :initarg :timestamp)))

(defclass artifact (permanent) ())
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
(defclass token () ())
(defclass legend () ())
(defclass enchantment-artifact (enchantment artifact) ())
(defclass enchantment-creature (enchantment creature) ())
(defclass artifact-enchantment-creature (artifact-enchantment creature) ())
(defclass planeswalker (card) ())
;        (loyalty)) 

(defclass player ()
  ((name)
   (life :initarg :life :initform 20)
   (hand :initform (make-instance 'hand))))

;(defclass team ()
;        (name)
;        (teammates))

(defclass emblem (mtg-object) ())

(defclass ability           (mtg-object) ())
(defclass triggered-ability (ability) ())
(defclass activated-ability (ability) ())
(defclass loyalty-ability   (activated-ability) ())
(defclass mana-ability      (activated-ability) ())
(defclass static-ability    (ability) ())
(defclass keyword-ability   (ability) ())
(defclass evasion-ability   (ability) ())

(defclass counter () ())

(defclass effect               ()       ())
(defclass one-shot-effect      (effect) ())
(defclass text-changing-effect (effect) ())
(defclass continuous-effect    (effect) ())
(defclass replacement-effect   (continuous-effect) ())
(defclass prevention-effect    (continous-effect) ())

(defclass action () ())
(defclass keyword-actions (action) ())
(defclass special-action (action) ())
(defclass state-based-action (action) ())
(defclass turn-based-action (action) ())

(defun get-controller () nil)
(defun get-owner      () nil)
(defun push-stack     () nil)
(defun resolve-stack  () nil)
(defun stack-empty    () nil)
;(defun draw (player num)
;  nil)

;(defun scry (player num)
;  nil)

(defun win-game (player)
        (print "Game Over")
        (print (slot-value player 'name)))

(defun lose-game (player)
        (print "Game Over")
        (print (slot-value player 'name)))

;(defun gain-life (player num) nil)

;(defun lose-life (player num) nil)
;(defun set-life  (player num) nil)
;(defun gain-poison (player num) nil)
;(defun lose-poison (player num) nil)
;
;(defun exile (perm))
;(defun destroy (perm))

;(defun converted-mana-cost (mtg-obj))
;(defun mulligan (player))
;(defgeneric damage ())

;(defun get-active-player ())
;(defun is-teammate (player1 player2))
;(defun is-opponent (player1 player2))
(defun get-apnap ()) 
;(defun shuffle (player))
(defun tap (perm)
        (setf (slot-value perm 'tapped) t))

(defun untap (perm)
        (setf (slot-value perm 'tapped) nil))

(defun flip-faceup (perm)
        (setf (slot-value perm 'facedown) nil))

(defun flip-facedown (perm)
        (setf (slot-value perm 'facedown) t))

(defun attach (source target)
        (setf (slot-value source 'attach-target) target)
        (setf (slot-value source 'timestamp) (get-universal-time)))

(defun detach (source)
        (setf (slot-value source 'attach-target) nil)
        (setf (slot-value source 'timestamp) nil))

(defun sacrifice ())
(defun proliferate ())
(defun flicker ())
(defun bounce ()) 

(defun set-damage (creature damage)
        (setf (slot-value creature 'damage) damage))

(defun do-damage (creature damage)
        (setf (slot-value creature 'damage) (- (slot-value creature 'damage) damage)))

(defun is-sick (creature)
        (slot-value creature 'sick))

(defun heal (creature)
        (setf (slot-value creature 'damage) 0))

(defun hp (creature)
        (- (slot-value creature 'toughness) (slot-value creature 'damage)))
  
(defun floating ())
;(defun mill (player num))

(defun concede (player)
        (lose-game player))

;(defun tapped-out (player))
;(defun hand-size (player))
;(defun graveyard-size (player))
;(defun is-vanilla (card))
;(defun get-timestamp)
(defun pass-priority ())
;(defun devotion (player type))