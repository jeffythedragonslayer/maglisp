(defclass creature (card permanent)
        ((power               :initarg :power               :accessor power)
         (toughness           :initarg :toughness           :accessor toughness)
         (subtype             :initarg :subtype             :accessor subtype)
         (activated-abilities :initarg :activated-abilities :accessor activated-abilities)
         (tap-abilities       :initarg :tap-abilities       :accessor tap-abilities)
         (static-abilities    :initarg :static-abilities    :accessor static-abilities)
         (sick                :initform t                   :accessor sick)
         (damage              :initform 0                   :accessor damage)))

(defun set-damage (creature dmg)
        (setf (damage creature) dmg))

(defun do-damage (creature dmg)
        (setf (damage creature) (- (damage creature) dmg)))

(defun heal (creature)
        (setf (damage creature) 0))

(defun hp (creature)
        (- (toughness creature) (damage creature)))

(defmethod print-object ((obj creature) stream)
        (format stream "Name:    ~a~%"      (name    obj))
        (format stream "Subtype: ~a~%"      (subtype obj))
        (format stream "CMC:     ~a drop~%" (cmc     obj))
        (format stream "P/T:     ~a/~a~%"   (power   obj) (toughness obj))
        (format stream "Flavor:  ~a~%"      (flavor  obj)))

(defparameter *creature-types* '(Advisor Ally Angel Antelope Ape Archer Archon Artificer Assassin Assembly-Worker Atog Aurochs Avatar
                                 Badger Barbarian Basilisk Bat Bear Beast Beeble Berserker Bird Blinkmoth Boar Bringer Brushwagg
                                 Camarid Camel Caribou Carrier Cat Centaur Cephalid Chimera Citizen Cleric Cockatrice Construct Coward Crab Crocodile Cyclops

                                 Efreet Elder Eldrazi Elemental Elephant Elf Elk Eye
                                 Faerie Ferret Fish Flagbearer Fox Frog Fungus
                                 Gargoyle Germ Giant Gnome Goat Goblin God Golem Gorgon Graveborn Gremlin Griffin
                                 Hag Harpy Hellion Hippo Hippogriff Homarid Homunculus Horror Horse Hound Human Hydra Hyena
                                 Illusion Imp Incarnation Insect
                                 Jellyfish Juggernaut
                                 Kavu Kirin Kithkin Knight Kobold Kor Kraken
                                 Lamia Lammasu Leech Leviathan Lhurgoyf Licid Lizard Manticore
                                 Masticore Mercenary Merfolk Metathran Minion Minotaur Monger Mongoose Monk Moonfolk Mutant Myr Mystic
                                 Naga Nautilus Nephilim Nightmare Nightstalker Ninja Noggle Nomad Nymph
                                 Octopus Ogre Ooze Orb Orc Orgg Ouphe Ox Oyster
                                 Pegasus Pentavite Pest Phelddagrif Phoenix Pincher Pirate Plant Praetor Prism
                                 Rabbit Rat Rebel Reflection Rhino Rigger Rogue
                                 Sable Salamander Samurai Sand Saproling Satyr Scarecrow Scorpion Scout Serf Serpent Shade Shaman
                                        Shapeshifter Sheep Siren Skeleton Slith Sliver Slug Snake Soldier Soltari Spawn Specter Spellshaper Sphinx Spider Spike Spirit Splinter Sponge Squid Squirrel Starfish Surrakar Survivor
                                 Tetravite Thalakos Thopter Thrull Treefolk Triskelavite Troll Turtle
                                 Unicorn
                                 Vampire Vedalken Viashino Volver
                                 Wall Warrior Weird Werewolf Whale Wizard Wolf Wolverine Wombat Worm Wraith Wurm
                                 Yeti
                                 Zombie Zubera))

(defparameter *obsolete-creature-types* '(Abomination Aboroth Aesthir Aladdin Albatross Alchemist Ali-Baba Ali-from-Cairo Alligator Ambush-Party Ancestor Anemone Ant Anteater Archaeologist Asp Autocrat Avenger Avizoa
                                          Ball-Lightning Bandit Banshee Barishi Bee Behemoth Being Blinking-Spirit Bodyguard Brother Brownie Bull Bureaucrat Butterfly
                                          Caravan Carnivore Carriage Caterpillar Cavalry Cave-People Cheetah Chicken Child Clamfolk Clone Cobra Constable Cow Crusader
                                          Dandân Dead Dervish Designer Devouring-Deep Dinosaur Dog Donkey Doppelganger Dragonfly Drill-Sergeant
                                          Eater Eel Effigy Egg El-Hajjâj Enchantress Entity Erne Essence Evil-Eye Exorcist Expansion-Symbol
                                          Falcon Fallen Farmer Fiend Flying-Man Folk of An-Havva Force Frostbeast Fungusaur
                                          Gaea's-Avenger Gaea's Liege Gamer Gatekeeper General Ghost Ghoul Gorilla Gorilla-Pack Guardian Gus Gypsy
                                          Harlequin Hell's Caretaker Heretic Hero Hipparion Hippopotamus Hornet Horseman Hunter Infernal-Denizen
                                          Inquisitor Island-Fish
                                          Jackal
                                          Keeper Kelp King
                                          Lady-of-Proper-Etiquette Legend Legionnaire Lemure Leper Lichenthrope Lion Lord Lord of Atlantis Lurker Lycanthrope
                                          Mage Maiden Mammoth Marid Master Medusa Lost-Soul Mana-Bird Mantis Martyr Meerkat Merchant Mime Mindsucker Minor Miracle-Worker Mist Mob Mold-Demon Monkey Mosquito Monster Mummy Murk-Dweller
                                          Nameless-Race Nature-Spirit Narwhal Necrosavant Nekrataal Niall-Silvain Night-Stalker Noble
                                          Paladin Paratrooper Peacekeeper Penguin People-of-the-Woods Phantasm Pig Pigeon Pikemen Pixie-Queen Poison-Snake Poltergeist Pony Preacher Priest Pyknite Python
                                          Rag-Man Raider Ranger Rider Robber Roc Rock-Sled Rooster Rukh
                                          Sage Scavenger Scavenger-Folk Shadow Shark Ship Shyft Sindbad Singing-Tree Sister Smith Sorcerer Sorceress Speaker Sprite Spuzzem Spy Squire Stangg-Twin Strider Swarm
                                          Tactician Tarpan Taskmaster Teddy Thief The-Biggest-Baddest-Nastiest-Scariest-Creature-You'll-Ever-See Thundermare Tiger Titan Toad Tombspawn Tortoise Townsfolk Tracker Twin
                                          Uncle-Istvan Undead
                                          Viper Villain Vulture
                                          Waiter Walking-Dead War-Rider Warthog Wasp Whippoorwill Wight Wiitigo Wildcat Wildebeest Will-O'-The-Wisp Witch Wirefly Wolverine-Pack Wolves-of-the-Hunt Wood Wretched Wyvern))

(defparameter *plane-types* '(Alara Arkhos Azgol Belenon Bolas’sMeditationRealm Dominaria Equilor Ergamon Fabacin Innistrad Iquatana Ir Kaldheim Kamigawa Karsus Kephalai Kinshala Kolbahan Kyneth Lorwyn Luvion Mercadia Mirrodin Moag Mongseng Muraganda New Phyrexia Phyrexia Pyrulea Rabiah Rath Ravnica Regatha Segovia Serra’s Realm Shadowmoor Shandalar Ulgrotha Valla Vryn Wildfire Xerex Zendikar))
