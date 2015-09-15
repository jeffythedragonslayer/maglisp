 ;704.5a If a player has 0 or less life, he or she loses the game.
(defun zero-life-die ()
        (mapcar (lambda (x)
                        (unless (plusp (get-player-life x))
                                (lose-game x)
                                (return-from zero-life-die t)))
                *all-players*)
        nil)

;704.5b If a player attempted to draw a card from a library with no cards in it since the last time state-based actions were checked, he or she loses the game.
(defun draw-empty-library-die ()
        (mapcar (lambda (x)
                        (when (get-player-emptydraw x)
                              (lose-game x)
                              (return-from draw-empty-library-die t)))
                *all-players*)
        nil)

;704.5c If a player has ten or more poison counters, he or she loses the game. Ignore this rule in Two-Headed Giant games; see rule 704.5u instead.
(defun poison-die ()
        (mapcar (lambda (x) 
                        (when (> (get-player-poison x) 10) 
                              (lose-game x)
                              (return-from poison-die t)))
                *all-players*)
        nil)


(defun phased-token-die              () nil) ;704.5d If a token is phased out, or is in a zone other than the battlefield, it ceases to exist.  
(defun spell-copy-die                () nil) ;704.5e If a copy of a spell is in a zone other than the stack, it ceases to exist.
                                                ; If a copy of a card is in any zone other than the stack or the battlefield, it ceases to exist.

;704.5f If a creature has toughness 0 or less, it’s put into its owner’s graveyard. Regeneration can’t replace this event.  
(defun creature-zero-toughness-die ()
        (mapcar (lambda (x)
                        (when (and (creature? x)
                                   (<= (get-card-toughness x) 0))
                              (destroy x)))
                *battlefield*)
        nil)


;704.5g If a creature has toughness greater than 0, and the total damage marked on it is greater than or equal to its toughness, 
; that creature has been dealt lethal damage and is destroyed. Regeneration can replace this event.  
(defun creature-lethal-damage-die ()
        (mapcar (lambda (x)
                        (when (and (creature? x)
                                   (<= (hp x) 0))
                              (destroy x)))
                *battlefield*)
        nil)

;704.5h If a creature has toughness greater than 0, and it’s been dealt damage by a source with deathtouch since the last time state-based actions were checked,
;that creature is destroyed. Regeneration can replace this event.
(defun creature-deathtouch-die ()
        (mapcar (lambda (x)
                        (when (deathtouched? x)
                              (destroy x))
                              (format t "~a died from deathtouch~%" (get-card-name x))
                              (return-from creature-deathtouch-die t))
                *battlefield*)
        nil)

(defun planeswalker-zero-loyalty-die () ;704.5i If a planeswalker has loyalty 0, it’s put into its owner’s graveyard.
        (mapcar (lambda (x)
                        (when (and (planeswalker? x) (<= (get-planeswalker-loyalty x) 0))
                              (destroy x)
                              (return-from planeswalker-zero-loyalty-die t)))
                *battlefield*)
        nil)

(defun planeswalker-uniqueness-rule  () nil) ;704.5j If a player controls two or more planeswalkers that share a planeswalker type,
                                                ; that player chooses one of them, and the rest are put into their owners’ graveyards. This is called the “planeswalker uniqueness rule.”
(defun legend-rule                   () nil) ;704.5k If a player controls two or more legendary permanents with the same name,
                                                ; that player chooses one of them, and the rest are put into their owners’ graveyards. This is called the “legend rule.” 
(defun too-many-counters             () nil) 
(defun world-rule                    () nil) ;704.5m If two or more permanents have the supertype world,
                                                ; all except the one that has had the world supertype for the shortest amount of time are put into their owners’ graveyards.
                                                ; In the event of a tie for the shortest amount of time, all are put into their owners’ graveyards. This is called the “world rule.” 
(defun illegal-aura-die              () nil) ;704.5n If an Aura is attached to an illegal object or player, or is not attached to an object or player, that Aura is put into its owner’s graveyard.  
(defun illegal-equipment-die         () nil) ;704.5p If an Equipment or Fortification is attached to an illegal permanent, it becomes unattached from that permanent. It remains on the battlefield.  
(defun illegal-creature-attachment   () nil) ;704.5q If a creature is attached to an object or player, it becomes unattached and remains on the battlefield. Similarly,
                                                ; if a permanent that’s neither an Aura, an Equipment, nor a Fortification is attached to an object or player,
                                                ; it becomes unattached and remains on the battlefield.  
(defun up-down-counters-cancel       () nil) ;704.5r If a permanent has both a +1/+1 counter and a -1/-1 counter on it, N +1/+1 and N -1/-1 counters are removed from it,
                                                ; where N is the smaller of the number of +1/+1 and -1/-1 counters on it.  
(defun illegal-counters              () nil) ;704.5s If a permanent with an ability that says it can’t have more than N counters of a certain kind on it
                                                ; has more than N counters of that kind on it, all but N of those counters are removed from it.  


(defparameter *state-based-actions* '(#'zero-life-die
                                      #'draw-empty-library-die
                                      #'poison-die
                                      #'creature-zero-toughness-die
                                      #'creature-lethal-damage-die
                                      #'planeswalker-zero-loyalty-die
                                      #'planeswalker-uniqueness-rule
                                      #'legend-rule
                                      #'world-rule
                                      #'illegal-aura-die
                                      #'illegal-equipment-die
                                      #'too-many-counters))

(defun check-state-based-actions ()
        (mapcar (lambda (x)
                        (when (funcall (eval x))
                              (return-from check-state-based-actions t)))
                *state-based-actions*)
        nil)
