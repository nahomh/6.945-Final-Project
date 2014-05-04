; Logic for notes

; We define the logic for the representation of notes here. 

; Spefication Examples:
; (note a) # defaults to fourth octave and duration ¼ if not set or duration of piece
; (note a) -> note a4 duration of ¼
; (note a6) -> note a6 duration of ¼
; (define (piece (new-piece a 4/6)))
; (piece (add-note (note a))) -> note within piece -> note a4 -> duration of ⅙


;(create-note pitch duration accent)

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



(define (empty-note)
  (define-cell note)
  (eq-put! note 'type 'note)
  (eq-put! note 'pitch #\C)
  (eq-put! note 'duration 0.25)
  (eq-put! note 'octave 4)
  (eq-put! note 'accent (list "b" 0)))


  (define (get-pitch note)
    (eq-get note 'pitch))

 (define (get-duration note)
    (eq-get note 'duration))

 (define (get-octave note)
    (eq-get note 'octave))

 (define (get-accent note)
    (eq-get note 'accent))


(define (create-note pitch-string duration)
  (if (not (valid-pitch? pitch-string))
    "Not a valid pitch expression"
    (let ((new-note (empty-note)))
      (eq-put! new-note 'pitch (get-pitch pitch-string))
      (eq-put! new-note 'duration duration)
      (eq-put! new-note 'accent (get-accent pitch-string))
      (eq-put! new-note 'octave (get-octave-num pitch-string))
      new-note)))

(define note-add
  (make-generic-operator 2))

(define (print-note note)
  (pp (eq-get note 'type))
  (pp (eq-get note 'pitch))
  (pp (eq-get note 'octave))
  (pp (eq-get note 'accent)))

(defhandler note-add
  (lambda (note octave)
    (let ((current-octave (eq-get note 'octave)))
      (eq-put!
        note
        'octave
        (+ octave current-octave)))
    note)
  note? valid-octave?)


(define (compare-notes note1 note2)
  (< (get-cent note1) (get-cent note2)))

(define (sort-notes notes)
  (sort notes compare-notes))


;default case C4--> 0

(define C4 0)
(define semitone 100)

(define (get-ascii note)
	(if (string? note)
		(char->ascii (string-ref note 0)))
	(if (char? note)
		(char->ascii note))
)
; ;check if it matches middle c
; (define (is-middle? pitch octave accent)
; 	(and (char=? pitch #\C) (= octave 4) (= 0 (cadr accent))))

;get added octave count
(define (cent-octave-count octave)
	(* (- octave 4) 1200))
;TODO error check

;get accent-value 
(define (get-accent-count accent)
	(let (
		(semi-count 100)
		(accent-number (cadr accent))
		(accent-type (car accent)))
	(cond ((string=? accent-type "#") (* semi-count 1))
		((string=? accent-type "b") (* semi-count -1)))
	(* semi-count accent-number)))

(define (attach-semitone pitch octave accent)
	(cond 
	((char=? pitch #\C) C4)
	((char=? pitch #\B) (display 1)(- C4 semitone))
	((char=? pitch #\D) (display "d")(+ C4 (* 2 semitone)))
	((char=? pitch #\F)(display "f") (+ C4 (* 5 semitone)))
	((char=? pitch #\A) (display "a")(- C4 (* 3 semitone)))
	((char=? pitch #\E) (display "e")(+ C4 (* 4 semitone)))
	((char=? pitch #\G) (display "G")(+ C4 (* 7 semitone)))))

(define (get-cent note)
	(let ((pitch (eq-get note 'pitch))
		(octave (eq-get note 'octave))
		(accent (eq-get note 'accent))
		(count 0))
	;get the ascii value for the note
	(display (attach-semitone pitch octave accent))
	(display (cent-octave-count octave))
	(display (attach-semitone pitch octave accent))
	(+ (attach-semitone pitch octave accent) (cent-octave-count octave) (get-accent-count accent))))

;TODO
