; Logic for Operations

; We define the logic for operations here. 

; Spefication Examples:
; (transpose (note c) (interval c g)) → (‘note g4)
;piece, note, chord

;interval

;(define transpose 
;	(make-generic-operator 2))
;(defhandler transpose ())


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
		(list semitones))
	)
)



; (define (transpose-note note semitones)
; 	(let (
; 		(note-value (get-cent note))
; 		(note-octave (eq-get note 'octave))
; 		)
; 		(displaym "note-value" note-value)
; 		(displaym "note-octave" note-octave)
; 		(displaym "update-octave-function" values)
; 		(let (
; 			(values (update-octave semitones note-octave))
; 			(updated-values (+ note-value (car values)))
; 			)

; 		(displaym "values" values)
; 		(displaym "updated-values" updated-values)
; 		)

; 		; (let(
; 		; 	(vals (update-octave semitones note-octave))
; 		; 	(update-note (+ note-value (car (vals))));(2 1)
; 		; 	)
; 		; (displaym "Updated value:" update-note)
; 		; )
		

; 	)
; )
