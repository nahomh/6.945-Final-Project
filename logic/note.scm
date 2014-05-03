; Logic for notes

; We define the logic for the representation of notes here. 

; Spefication Examples:
; (note a) # defaults to fourth octave and duration ¼ if not set or duration of piece
; (note a) -> note a4 duration of ¼
; (note a6) -> note a6 duration of ¼
; (define (piece (new-piece a 4/6)))
; (piece (add-note (note a))) -> note within piece -> note a4 -> duration of ⅙


; (note a ¼)
; (note a 0.25)
; (note a# 0.25)
; (note a# ¼)
; (note a4 0.25)

; Adding a note to a piece
; (piece (add-note (note a)))

; (piece (add-notes a# bb c## d4 ab3 Cb2 d# ebb))
; first letter = note
; second/third/fourth… = flat/sharp
; last = octave


;default case C4--> 0

(define C4 0)
(define semitone 100)

(define (get-ascii note)
	(if (string? note)
		(char->ascii (string-ref note 0)))
	(if (char? note)
		(char->ascii note))
)
;check if it matches middle c
(define (is-middle? pitch octave accent)
	(and (char=? pitch #\C) (= octave 4)) (= 0 (cadr accent)))

;get added octave count
(define (cent-octave-count octave)
	(* (- octave 4) 1200))
;TODO error check

;get accent-value 
(define (get-accent-count accent)
	(let ((semi-count 100)
		(accent-number (cadr accent))
		(accent-type (car accent)))
	(cond ((string=? accent-type "#") (* semi-count 1))
		((string=? accent-type "b") (* semi-count -1)))
	(* semi-count accent-number))


(define (get-cent note)
	(let (pitch (eq-get! note 'pitch))
		(octave (eq-get! note 'octave))
		(accent (eq-get! note 'accent))
		(count 0))
	;get the ascii value for the note
	(if (is-middle? pitch octave accent) C4)
	(cond ((char=? pitch #\B) (- count semitone))
		((char=? pitch #\D) (- count (* 2 semitone)))
		((char=? pitch #\A) (- count (* 3 semitone)))
		((char=? pitch #\E) (- count (* 4 semitone)))
		((char=? pitch #F) (- count (* 5 semitone)))
		((char=? pitch #G) (- count (* 7 semitone))))
	(+ count (cent-octave-count octave))
	(+ count (get-accent-count accent)))



