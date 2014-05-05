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

(defhandler transpose
  transpose-chord chord? integer?)

(defhandler transpose
  transpose-piece piece? integer?)

(define (update-octave semitones octave)
	(if (> semitones 12) (list (modulo semitones 12) (quotient semitones 12)) 
		(semitones)))


; (define (transpose-note note semitones)
; 	(let (
; 		(note-value (get-cent note))
; 		(note-octave (eq-get note 'octave))
; 		(vals (update-octave semitones note-octave))	;(2 1)
; 		)

	


; 		)
