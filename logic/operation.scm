; Logic for Operations

; We define the logic for operations here. 

; Spefication Examples:
; (transpose (note c) (interval c g)) → (‘note g4)
;piece, note, chord

;interval

(define transpose 
	(make-generic-operator 2))
(defhandler transpose ())


(define transpose 
	(make-generic-operator 2))

(defhandler transpose
  transpose-note note? integer?)

; (defhandler transpose
;   transpose-chord chord? integer?)

; (defhandler transpose
;   transpose-piece piece? integer?)

(define (update-octave semitones octave)
	(displaym "update-ocatave-semitones" semitones)
	(displaym "update-octave-num" octave)
	(let (
		(semitones-count (modulo semitones 12))
		(octave-count (quotient semitones 12))
		)
	(if (> semitones 12) (list semitones-count octave-count) 
		(list semitones 0))
	)
)

(define (get-note note-val)
	(displaym "get-note-value" note-val)
	(displaym "note-val" (integer? note-val))
	(displaym "hash-table-val" (hash-table/get note-values note-val 0))
	(cond
		((= note-val -200) (list #\A "#" 1))
		((= note-val 300) (list #\D "#" 1))
		((= note-val 600) (list #\F "#" 1))
		((= note-val 800) (list #\G "#" 1))
		((= note-val 900) (list #\G "#" 2))
		(else (hash-table/get note-values note-val 0))
		)
)

;;Todo: Need to create the actual note. Update functions with side-cases work. 

(define (transpose-note note semitones)
	(let (
		(note-value (get-cent note))
		(note-octave (eq-get note 'octave))
		)
		(displaym "note-value" note-value)
		(displaym "note-octave" note-octave)
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
		(displaym "values" values)
		(displaym "updated-values" updated-values)
		(displaym "new-note" transposed-note)
		(displaym "new-octave" updated-octave) 
		)))
	)
)
