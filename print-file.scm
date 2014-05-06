(print-chord (inversion 
 (create-chord
  (create-note "A#4" 0.5)
  (create-note "Bbb#b10" 0.5)
  (create-note "G#5" 0.5)
  (create-note "Fbb3" 0.5))
 1))

#\F
10
("b" 2)
note
#\A
4
("#" 1)
note
#\G
5
("#" 1)
note
#\B
10
("b" 2)


(print-chord (inversion 
 (create-chord
  (create-note "A#4" 0.5)
  (create-note "Bbb#b10" 0.5)
  (create-note "G#5" 0.5)
  (create-note "Fbb3" 0.5))
 2))

#\F
3
("b" 2)
note
#\A
11
("#" 1)
note
#\G
5
("#" 1)
note
#\B
10
("b" 2)


