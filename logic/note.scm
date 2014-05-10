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

(define semitone 100)
(define tone 200)


(define major-tones
  (list tone tone semitone tone tone tone semitone))

(define minor-tones
  (list tone semitone tone tone semitone tone tone))

(define locrian-tones
  (list semitone tone tone semitone tone tone tone))

(define dorian-tones
  (list tone semitone tone tone tone semitone tone))

(define phrygian-tones
  (list semitone tone tone tone semitone tone tone))

(define lydian-tones
  (list tone tone tone semitone tone tone semitone))

(define mixolydian-tones
  (list tone tone semitone tone tone semitone tone))

(define (modded-val val)
  (- (modulo (+ 300 val) 1200) 300))

(define (get-next-pitch pitch)
  (cond
    ((char=? pitch #\C) #\D)
    ((char=? pitch #\B) #\C)
    ((char=? pitch #\D) #\E)
    ((char=? pitch #\F) #\G)
    ((char=? pitch #\A) #\B)
    ((char=? pitch #\E) #\F)
    ((char=? pitch #\G) #\A)))

(define (empty-note)
  (define-cell note)
  (eq-put! note 'type 'note)
  (eq-put! note 'pitch #\ )
  (eq-put! note 'duration (make-duration 0.25))
  (eq-put! note 'octave 0)
  (eq-put! note 'accent (list "b" 0)))

(define (modify-duration! note duration)
  (eq-put! note 'duration duration))


(define (rest)
  (define-cell note)
  (eq-put! note 'type 'note)
  (eq-put! note 'pitch )
  (eq-put! note 'octave 0)
  (eq-put! note 'accent (list "b" 0)))

  
(define (create-note pitch-string duration)
  (if (not (valid-pitch? pitch-string))
    "Not a valid pitch expression"
    (let ((new-note (empty-note)))
      (eq-put! new-note 'pitch (get-pitch pitch-string))
      (eq-put! new-note 'duration (make-duration duration))
      (eq-put! new-note 'accent (get-accent pitch-string))
      (eq-put! new-note 'octave (get-octave pitch-string))
      new-note)))

(define (copy-note note)
  (note-add note 0)
)

(define note-add
  (make-generic-operator 2))

(define (print-note note)
  (pp (eq-get note 'type))
  (pp (eq-get note 'pitch))
  (pp (eq-get note 'octave))
  (pp (eq-get note 'accent)))

(define (show-note note)
  (pp (pitch-str note)))

(defhandler note-add
  (lambda (note octave)
    (let ((current-octave (eq-get note 'octave)) (new-note (empty-note)))
      (eq-put!
        new-note
        'octave
        (+ octave current-octave))
      (eq-put!
        new-note
        'pitch
        (get-pitch note))
      (eq-put!
        new-note
        'duration
        (get-duration note))
      (eq-put!
        new-note
        'accent
        (get-accent note))
    new-note))
  note? valid-octave?)


(define (compare-notes note1 note2)
  (< (get-cent note1) (get-cent note2)))

(define (sort-notes notes)
  (sort notes compare-notes))


;default case C4--> 0

(define C4 0)

(define (get-ascii note)
	(if (string? note)
		(char->ascii (string-ref note 0)))
	(if (char? note)
		(char->ascii note))
)

;get added octave count
(define (cent-octave-count octave)
	(* (- octave 4) 1200))
;TODO error check

;get accent-value 
(define (get-accent-count accent)
	(let (
		(semi-count 0)
		(accent-number (cadr accent))
		(accent-type (car accent)))
	(cond ((string=? accent-type "#") (* (+ semi-count 100) accent-number))
		((string=? accent-type "b") (* (- semi-count 100) accent-number)))))


(define (attach-semitone pitch)
  (cond 
	((char=? pitch #\A) (- C4 (* 3 semitone)))
  ((char=? pitch #\B) (- C4 semitone))
  ((char=? pitch #\C) C4)
  ((char=? pitch #\D) (+ C4 (* 2 semitone)))
	((char=? pitch #\E) (+ C4 (* 4 semitone)))
  ((char=? pitch #\F) (+ C4 (* 5 semitone)))
	((char=? pitch #\G) (+ C4 (* 7 semitone)))))

; (define (pitch-value pitch)
;   (cond 
;   ((char=? pitch #\A) 0)
;   ((char=? pitch #\B) 200)
;   ((char=? pitch #\C) 300)
;   ((char=? pitch #\D) 500)
;   ((char=? pitch #\E) 700)
;   ((char=? pitch #\F) 800)
;   ((char=? pitch #\G) 1000)))

; (define (get-pitch-for-value val)
;   (let ((mod-val  (modulo val octave)))
;     (cond
;       ((= val 0) #\A)
;       ((= val 200) #\B)
;       ((= val 300) #\C)
;       ((= val 500) #\D)
;       ((= val 700) #\E)
;       ((= val 800) #\F)
;       ((= val 1000) #\G))))


(define (get-cent note)
	(let ((pitch (eq-get note 'pitch))
		(octave (eq-get note 'octave))
		(accent (eq-get note 'accent))
		(count 0))
	;get the ascii value for the note
	(display (attach-semitone pitch))
	(display (cent-octave-count octave))
	(display (attach-semitone pitch))
	(+ (attach-semitone pitch) (cent-octave-count octave) (get-accent-count accent))))

(define (increase-octave note1 note2)
  (if (> (attach-semitone (get-pitch note1)) (attach-semitone (get-pitch note2)))
    (note-add note1 (- (get-octave note2) (get-octave note1)))
    (note-add note1 (+ (- (get-octave note2) (get-octave note1)) 1))))


(define (add-accent pitch-char note-value)
  (define (modify-accent pitch pitch-val note-val accent-str accent-val)
    (define (add-to-string pitch-v str)
      (if (= pitch-v note-val)
        str
        (add-to-string (modded-val (+ pitch-v accent-val)) (string-append str accent-str))))
    (add-to-string pitch-val (string pitch)))
  (let* 
    ((mod-note-value (modded-val note-value))
    (pitch-value (modded-val (attach-semitone pitch-char)))
    (diff (modded-val (- mod-note-value pitch-value))))
    (cond
     ((> diff 0)
      (modify-accent pitch-char pitch-value mod-note-value "#" 100))
     ((= pitch-value mod-note-value)
      (string pitch-char))
     (else
      (modify-accent pitch-char pitch-value mod-note-value "b" -100)))))


(define note-values
	(make-eq-hash-table))

(define (set-note-values)
	(hash-table/put! note-values -300 #\A)
	(hash-table/put! note-values -100 #\B)
	(hash-table/put! note-values  0 #\C)
	(hash-table/put! note-values 200 #\D)
	(hash-table/put! note-values 400 #\E)
	(hash-table/put! note-values 500 #\F)
	(hash-table/put! note-values 700 #\G)
	)

(set-note-values)
