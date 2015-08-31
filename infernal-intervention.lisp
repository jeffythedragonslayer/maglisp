(load "card.lisp")

(defparameter *carrion-crow* (make-instance 'creature
					    :cmc 3
					    :subtype 'zombiebird
					    :power 2
					    :toughness 2
					    :static-abilities 'flying
					    :text "Carrion Crow enters the battlefield tapped."))

(defparameter *gargoyle-sentinel* (make-instance 'artifact-creature
						:cmc 3
						:subtype 'gargoyle
						:power 3
		 				:toughness 5
						:static-abilities 'defender
						:tap-abilities "hi"))

(defparameter *goblin-roughrider* (make-instance 'creature
						 :cmc 3
						 :subtype 'goblin-knight
						 :power 3
						 :toughness 2
						 :flavor "Astride the bucking creature, Gribble hurtled down the mountainside while his Grotag brethren cheered. It was at that moment that the legend of the Skrill Tamer was born."))

(defparameter *gravedigger* (make-instance 'creature
					   :cmc 4
					   :subtype 'zombie
					   :power 2
					   :toughness 2
					   :text "When Gravedigger enters the battlefield, you may return target creature card from your graveyard to your hand."
					   :flavor "A full coffin is like a full coffer—both are attractive to thieves."))

(defparameter *indulgent-tormentor* (make-instance 'creature
						   :cmc 5
						   :subtype 'demon
						   :power 5
						   :toughness 3
						   :static-abilities '(flying)
						   :text "At the beginning of your upkeep, draw a card unless target opponent sacrifices a creature or pays 3 life."
						   :flavor "The promise of anguish is payment enough for services rendered."))

(defparameter *nightfire-giant* (make-instance 'creature
					       :cmc 5
					       :subtype 'zombie-giant
					       :power 4
					       :toughness 3
					       :text "Nightfire Giant gets +1/+1 as long as you control a Mountain"
					       :activated-abilities '((5 Nightfire Giant deals 2 damage to target creature or player.))
					       :flavor "Nightfire turns the greatest weakness of the undead into formidable strength."))

(defparameter *thundering-giant* (make-instance 'creature
						:cmc 5
						:subtype 'giant
						:power 4
						:toughness 3
						:static-abilities '(haste)
						:flavor "The giant was felt a few seconds before he was seen."))

(defparameter *torch-fiend* (make-instance 'creature
					   :cmc 2
					   :subtype 'devil
					   :power 2
					   :toughness 1
					   :activated-abilities "Sacrifice Torch Fiend: Destroy target artifact."
					   :flavor "Devils redecorate every room with fire."))

(defparameter *typhoid-rats* (make-instance 'creature
					   :cmc 1
					   :subtype 'rat
					   :power 1
					   :toughness 1
					   :static-abilities '(deathtouch)
					   :flavor "When Tasigur sent his ambassadors to the Abzan outpost, the true envoys were not the naga but the infectious rats they carried with them."))

(defparameter *wall-of-fire* (make-instance 'creature
					    :cmc 3
					    :subtype 'wall
					    :power 0
					    :toughness 5
					    :static-abilities 'defender
					    :activated-abilities "Wall of Fire gets +1/+0 until end of turn."
					    :flavor "Mercy is for those who keep their distance."))

(defparameter *zof-shade* (make-instance 'creature
					 :cmc 4
					 :subtype 'shade
					 :power 2
					 :toughness 2
					 :activated-abilities '((3 "Zof Shade gets +2/+2 until end of turn."))
					 :flavor "Shades are drawn to places of power, often rooting themselves in a single area to feed."))

(defparameter *blastfire-bolt* (make-instance 'instant
					      :cmc 6
					      :text "Blastfire Bolt deals 5 damage to target creature. Destroy all Equipment attached to that creature."
					      :flavor "Encase yourself in the most elaborate armor, and cower behind the heaviest shield. I would hate for you to feel helpless."))

(defparameter *burning-anger* (make-instance 'aura
					     :cmc 5
					     :text "Enchanted creature has \"This creature deals damage equal to its power to target creature or player.\""))

(defparameter *caustic-tar* (make-instance 'aura
					   :cmc 6
					   :text "Enchanted land has \"Target player loses 3 life.\""
					   :flavor "A forest fire can rejuvenate the land, but the tar's vile consumption leaves the land forever ruined."))

(defparameter *clear-a-path* (make-instance 'sorcery
					    :cmc 1
					    :text "Destroy target creature with defender."
					    :flavor "Why do guards always look surprised when we bash them?\" asked Ruric.  \"I think they expect a bribe,\" said Thar."))

(defparameter *cone-of-flame* (make-instance 'sorcery
					     :cmc 5
					     :text "Cone of Flame deals 1 damage to target creature or player, 2 damage to another target creature or player, and 3 damage to a third target creature or player."))

(defparameter *festergloom* (make-instance 'sorcery
					   :cmc 3
					   :text "Nonblack creatures get -1/-1 until end of turn."
					   :flavor "The death of a scout can be as informative as a safe return."))

(defparameter *flesh-to-dust* (make-instance 'instant
					     :cmc 5
					     :text "Destroy target creature. It can't be regenerated."
					     :flavor "\"Another day. Another avenging angel. Another clump of feathers to toss in the trash.\" —Liliana Vess"))

(defparameter *heat-ray* (make-instance 'instant
					:cmc 1
					:text "Heat Ray deals X damage to target creature."
					:flavor "\"There was clearly a scream. I'm not sure if there was a mouth.\" —Sachir, Akoum Expeditionary House"))

(defparameter *lightning-strike* (make-instance 'instant
						:cmc 2
						:text "Lightning Strike deals 3 damage to target creature or player."
						:flavor "To wield lightning is to tame chaos."))

(defparameter *profane-memento* (make-instance 'artifact
					       :cmc 1
					       :text "Whenever a creature card is put into an opponent's graveyard from anywhere, you gain 1 life."
					       :flavor "\"An angel's skull is left too plain by death. I made a few aesthetic modifications.\" —Dommique, blood artist"))

(defparameter *stab-wound* (make-instance 'aura
					  :cmc 3
					  :text "Enchanted creature gets -2/-2.  At the beginning of the upkeep of enchanted creature's controller, that player loses 2 life."))


(defparameter *infernal-intervention* '((13 *mountain*)
					(13 *swamp*) 
					(3  *typhoid-Rats*) 
					(2  *carrion-Crow*)
					(2  *gargoyle-sentinel*)
					(2  *goblin-roughrider*)
					(2  *nightfire-giant*)
					(2  *torch-fiend*) 
					(1  *gravedigger*)
					(1  *thundering-giant*)
					(1  *indulgent-tormentor*)
					(1  *wall-of-fire*)
					(1  *zof-shade*) 
					(2  *heat-ray*)
					(2  *lightning-strike*)
					(2  *profane-memento*)
					(2  *blastfire-bolt*)
					(2  *flesh-to-dust*) 
					(1  *burning-anger*)
					(1  *caustic-tar*)
					(1  *clear-a-path*)
					(1  *cone-of-flame*)
					(1  *festergloom*)
					(1  *stab-wound*)))
