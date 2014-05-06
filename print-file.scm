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


(transpose-note (create-note "A2" 2) 34)
new-note: G#0
;Value: #[entity 86]


(print-chord 
	(transpose-chord 
		(create-chord 
			(create-note "E5" 2) 
			(create-note "F5" 2) 
			(create-note "G5" 2)) 
		34))

#\D
0
("#" 1)
note
#\D
1
("#" 1)
note
#\F
0
("#" 1)
;Unspecified return value

