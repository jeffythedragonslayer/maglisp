(defparameter *soulmender* (make-instance 'creature
					  :cmc 1
					  :subtype 'human-cleric
					  :power 1
					  :toughness 1
					  :activated-abilities "You gain 1 life"
					  :flavor "\"Healing is more art than magic. Well, there is still quite a bit of magic.\""))

(defparameter *ajanis-pridemate* (make-instance 'creature
						:cmc 2
						:subtype 'cat-soldier
						:power 2
						:toughness 2
						:triggered-abilities "Whenever you gain life, you may put a +1/+1 counter on Ajani's Pridemate."
						:flavor "\"When one of us prospers, the pride prospers.\" —Jazal Goldmane"))

(defparameter *kinsbaile-skirmisher* (make-instance 'creature
						    :cmc 2
						    :subtype 'kithkin-soldier
						    :power 2
						    :toughness 2
						    :triggered-abilities "When Kinsbaile Skirmisher enters the battlefield, target creature gets +1/+1 until end of turn."
						    :flavor "If a boggart even dares breathe near one of my kin, I'll know. And I'll not be happy.")) 

(defparameter *sungrace-pegasus* (make-instance 'creature
						:cmc 2
						:subtype 'pegasus
						:power 1
						:toughness 2
						:static-abilities '(flying lifelink)
						:flavor "The sacred feathers of the pegasus are said to have healing powers."))

(defparameter *wall-of-essence* (make-instance 'creature
					       :cmc 2
					       :subtype 'wall
					       :power 0
					       :toughness 4
					       :static-abilities '(defender)
					       :triggered-abilities "Whenever Wall of Essence is dealt combat damage, you gain that much life."
					       :flavor "The ceiling and the floor fell in love, but only the wall knew.  —Dal saying"))

(defparameter *child-of-night* (make-instance 'creature
					      :cmc 2
					      :subtype 'vampire
					      :static-abilities '(lifelink)
					      :flavor "Sins that would be too gruesome in the light of day are made more pleasing in the dark of night."))

(defparameter *wall-of-limbs* (make-instance 'creature
					     :cmc 3
					     :subtype 'zombie-wall
					     :static-abilities '(defender)
					     :power 0
					     :toughness 3
					     :triggered-abilities "Whenever you gain life, put a +1/+1 counter on Wall of Limbs."
					     :activated-abilities "Sacrifice Wall of Limbs: Target player loses X life, where X is Wall of Limbs's power."))

(defparameter *witchs-familiar* (make-instance 'creature
					       :cmc 3
					       :subtype 'frog
					       :power 2
					       :toughness 3
					       :flavor "Some bog witches practice the strange art of batrachomancy, reading portents in the number, size, and color of warts on a toad's hide."))

(defparameter *geist-of-the-moors* (make-instance 'creature
						  :cmc 3
						  :subtype 'spirit
						  :power 3
						  :toughness 1
						  :static-abilities '(flying)
						  :flavor "\"The battle is won. There's work to be done. / The Blessed Sleep must wait. / A fiend is about. It stalks the devout. / I'll save them from my fate.\" —\"The Good Geist's Vow\""))

(defparameter *accursed-spirit* (make-instance 'creature
					       :cmc 4
					       :subtype 'spirit
					       :power 3
					       :toughness 2
					       :static-abilities '(intimidate)
					       :flavor "Many have heard the slither of dragging armor and the soft squelch of its voice. But only its victims ever meet its icy gaze."))

(defparameter *tireless-missionaries* (make-instance 'creature
						     :cmc 5
						     :subtype 'human-cleric
						     :power 2
						     :toughness 3
						     :triggered-abilities "When Tireless Missionaries enters the battlefield, you gain 3 life."
						     :flavor "If they succeed in their holy work, their order will vanish into welcome obscurity, for there will be no more souls to redeem."))

(defparameter *shadowcloak-vampire* (make-instance 'creature
						   :cmc 5
						   :subtype 'vampire
						   :power 4
						   :toughness 3
						   :static-abilities '("Pay 2 life: Shadowcloak Vampire gains flying until end of turn. \(It can't be blocked except by creatures with flying or reach.")
						   :flavor "My favorite guilty pleasure? Are there innocent ones?"))

(defparameter *blood-host* (make-instance 'creature
					 :cmc 5
					 :subtype 'vapmire
					 :power 3
					 :toughness 3
					 :activated-abilities '(2 "Sacrifice another creature: Put a +1/+1 counter on Blood Host and you gain 2 life.")
					 :flavor "It would be ill-mannered to decline his invitation. It would be ill-advised to accept it."))

(defparameter *resolute-archangel* (make-instance 'creature
						  :cmc 7
						  :subtype 'angel
						  :static-abilities '(flying)
						  :triggered-abilities "When Resolute Archangel enters the battlefield, if your life total is less than your starting life total, it becomes equal to your starting life total."
						  :power 4
						  :toughness 4))

(defparameter *sign-in-blood* (make-instance 'sorcery
					     :cmc 2
					     :text "Target player draws two cards and loses 2 life."
					     :flavor "Little agonies pave the way to greater power."))

(defparameter *solemn-offering* (make-instance 'sorcery
					       :cmc 3
					       :text "Destroy target artifact or enchantment. You gain 4 life."
					       :flavor "\"You will be reimbursed for your donation.\"
					       \"The reimbursement is spiritual.\"
					       —Temple signs"))

(defparameter *mass-calcify* (make-instance 'sorcery
					    :cmc 7
					    :text "Destroy all nonwhite creatures."
					    :flavor "The dead serve as their own tombstones."))

(defparameter *ulcerate* (make-instance 'instant
					:cmc 1
					:text "Target creature gets -3/-3 until end of turn. You lose 3 life."
					:flavor "\"If it were merely lethal, that would be sufficient. The art, however, is in maximizing the suffering it causes.\" —Liliana Vess"))

(defparameter *pillar-of-light* (make-instance 'instant
					       :cmc 3
					       :text "Exile target creature with toughness 4 or greater."
					       :flavor "\"The vaulted ceiling of our faith rests upon such pillars.\" —Darugand, banisher priest"))

(defparameter *staff-of-the-death-magus* (make-instance 'artifact
							:cmc 3
							:text "Whenever you cast a black spell or a Swamp enters the battlefield under your control, you gain 1 life."
							:flavor "A symbol of ambition in ruthless times."))

(defparameter *staff-of-the-sun-magus* (make-instance 'artifact
						      :cmc 3
						      :text "Whenever you cast a white spell or a Plains enters the battlefield under your control, you gain 1 life."
						      :flavor "A symbol of conviction in uncertain times."))

(defparameter *crippling-blight* (make-instance 'aura
						:cmc 1
						:text "Enchanted creature gets -1/-1 and can't block."
						:flavor "\"Still alive? No matter. I'll leave you as a warning to others who would oppose me.\" —Vish Kal, Blood Arbiter"))

(defparameter *divine-favor* (make-instance 'aura
					    :cmc 2
					    :text "Enchanted creature gets +1/+3."
					    :triggered-abilities "When Divine Favor enters the battlefield, you gain 3 life."))

(defparameter *first-response* (make-instance 'enchantment
					     :cmc 4
					     :text "At the beginning of each upkeep, if you lost life last turn, put a 1/1 white Soldier creature token onto the battlefield."
					     :flavor "\"There's never a good time for a disaster or an attack. That's why we're here.\" —Oren, militia captain"))

(defparameter *price-of-glory* '((3  *soulmender*)
				 (2  *ajanis-pridemate*)
				 (1  *kinsbaile-skirmisher*)
				 (2  *sungrace-pegasus*)
				 (1  *wall-of-essence*)
				 (2  *child-of-night*)
				 (2  *wall-of-limbs*)
				 (2  *witchs-familiar*)
				 (1  *geist-of-the-moors*)
				 (1  *accursed-spirit*)
				 (1  *tireless-missionaries*)
				 (2  *shadowcloak-vampire*)
				 (1  *blood-host*)
				 (1  *resolute-archangel*)
				 (3  *sign-in-blood*)
				 (1  *solemn-offering*)
				 (1  *mass-calcify*)
				 (2  *ulcerate*)
				 (1  *pillar-of-Light*)
				 (1  *staff-of-the-death-magus*)
				 (1  *staff-of-the-sun-magus*)
				 (1  *crippling-blight*)
				 (1  *divine-favor*)
				 (1  *first-response*) 
				 (12 *plains*)
				 (13 *swamp*)))
