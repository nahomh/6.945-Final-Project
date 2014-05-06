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


(get-scale "Bb" major-tones)
Value: ("Bb" "C" "D" "Eb" "F" "G" "A")

(get-scale "G#" locrian-tones)
Value: ("G#" "A" "B" "C#" "D" "E" "F#")

(get-scale "Ebb" dorian-tones)
Value: ("Ebb" "Fb" "Gbb" "Abb" "Bbb" "Cb" "Dbb")

(get-scale "F" minor-tones)
Value: ("F" "G" "Ab" "Bb" "C" "Db" "Eb")

(get-scale "C" lydian-tones)
Value: ("C" "D" "E" "F#" "G" "A" "B")


(define (convert-note note-str piece)
  (let ((newnote (hash-table/get (piece 'get 'table) (get-value note-str) "null")))
    (if (not (equal? newnote "null"))
      newnote
      note-str)))

(define (fill-cent-notes-table)
  (for-each
    (lambda (note)
      (hash-table/put! cent-notes-table (get-value note) note))
    (get-scale (get-key piece) major-tones))
)

(convert-note "D#" piece5)
Value: "Eb"

(convert-note "A#" piece5)
Value: "Bb"

(convert-note "F#" piece5)
Value: "F#"




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

