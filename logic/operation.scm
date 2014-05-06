; Logic for Operations

; We define the logic for operations here. 

; Spefication Examples:
; (transpose (note c) (interval c g)) → (‘note g4)
;piece, note, chord

;interval

(define transpose 
	(make-generic-operator 2))

(define transpose 
	(make-generic-operator 2))


; (defhandler transpose
;   transpose-piece piece? integer?)

;updates the octave and semitones for a given note
(define (update-octave semitones octave)
	; (displaym "update-ocatave-semitones" semitones)
	; (displaym "update-octave-num" octave)
	(let (
		(semitones-count (modulo semitones 12))
		(octave-count (quotient semitones 12))
		)
	(if (> semitones 12) (list semitones-count octave-count) 
		(list semitones 0))
	)
)

;Gets the note given a specfic note-value
(define (get-note note-val)
	; (displaym "get-note-value" note-val)
	; (displaym "note-val" (integer? note-val))
	; (displaym "hash-table-val" (hash-table/get note-values note-val 0))
	(cond
		((= note-val -200) (list #\A "#" 1))
		((= note-val 300) (list #\D "#" 1))
		((= note-val 600) (list #\F "#" 1))
		((= note-val 800) (list #\G "#" 1))
		((= note-val 900) (list #\G "#" 2))
		(else (list (hash-table/get note-values note-val 0) "#" 0)
		))
)

;Creates the correct pitch string given a notelist
(define (create-pitch-string notelist)
	(string (string (car notelist)) (cadr notelist) (number->string (caddr notelist)))
	)

(define (transpose-note note semitones)
	(let (
		(note-value (get-cent note))
		(note-octave (eq-get note 'octave))
		)
		(let (
			(values (update-octave semitones note-octave))
			)
		(let (
			(updated-values (modded-val (+ note-value (* (list-ref values 0) 100))))
			(updated-octave (+ note-octave (list-ref values 1)))
			)
		(let (
			(transposed-note (get-note updated-values))
			)
		; (displaym "new-note" transposed-note)
		; (displaym "new-octave" updated-octave)
		(displaym "new-note" (create-pitch-string transposed-note))
		(create-note (create-pitch-string transposed-note) 4)
		)))
	)
)


(define (transpose-chord chord semitones)
	(let (
		(note-list (eq-get chord 'notes))
		)
	(apply create-chord (map (lambda (note)
		(transpose-note note semitones))
		note-list))
	)
)

; Tests
; (transpose-chord (create-chord (create-note "E5" 2) (create-note "F5" 2) (create-note "G5" 2)) 34)
;
;(transpose-note (create-note "A2" 2) 34)


; (print-chord (transpose-chord (create-chord (create-note "E5" 2) (create-note "F5" 2) (create-note "G5" 2)) 34))

(defhandler transpose
  transpose-note note? integer?)

(defhandler transpose
  transpose-chord chord? integer?)