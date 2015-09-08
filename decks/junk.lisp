(defparameter *accursed-spirit*
        (make-card :types '(creature)
                   :name "Accursed Spirit"
                   :cmc  4
                   :subtype 'spirit
                   :power 3
                   :toughness 2
                   :flavor "Many have heard the slither of dragging armor and the soft squelch of its voice. But only its victims ever meet its icy gaze."))

(defparameter *counterspell* 
        (make-card :types '(instant)
                   :name "Counterspell"
                   :cmc 2
                   :text "Counter target spell"))

(defparameter *acorn-harvest*
        (make-card :types '(sorcery)
                   :name "Acorn Harvest"
                   :cmc 4
                   :colors '(green)
                   :text "Put two 1/1 green Squirrel creature tokens onto the battlefield."))

(defparameter *augury-owl*
        (make-card :types '(creature)
                   :name "Augury Owl"
                   :subtype 'bird
                   :power 1
                   :cmc 2
                   :colors '(blue)
                   :toughness 1))

(defparameter *lightning-bolt*
        (make-card :types '(instant)
                   :name "Lightning Bolt"
                   :colors '(red)
                   :text "Lightning Bolt deals 3 damage to target creature or player"))

(defparameter *overrun*
        (make-card :types '(sorcery)
                   :name "Overrun"
                   :colors '(green)
                   :text "Creatures you control get +3/+3 and gain trample until end of turn"))

(defparameter *battle-mastery*
        (make-card :types '(aura)
                   :name "Battle Mastery"
                   :colors '(white)
                   :text "Enchanted creature has double strike."))

(defparameter *relentless-rats*
        (make-card :types '(creature)
                   :name "Relentless Rats"
                   :subtype 'rat
                   :power 1
                   :toughness 1
                   :text "Relentless Rats gets +1/+1 for each other creature on the battlefield named Relentless Rats.  A deck can have any number of cards named Relentless Rats."))
