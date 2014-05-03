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
  (eq-put! note 'accent '()))


(define (create-note pitch-string duration)
  (if (not (valid-pitch? pitch-string))
    "Not a valid pitch expression"
    (let ((new-note (empty-note)))
      (eq-put! new-note 'pitch (get-pitch pitch-string))
      (eq-put! new-note 'duration duration)
      (eq-put! new-note 'accent (get-accent pitch-string))
      (eq-put! new-note 'octave (get-octave-num pitch-string))
      new-note)))

(define (add note summand)
  (make-generic-operator 2))

(defhandler add
  (lambda (note octave)
    (let ((current-octave (eq-get note 'octave)))
      (eq-put!
        note
        'octave
        'data
        (+ octave current-octave)))
    note)
  note? valid-octave?)

(define (note? note)
  (if (cell? note)
    (eq? 'note (eq-get note 'type))
    #f))


(define (compare-notes note1 note2)
  (< (get-cent note1) (get-cent note2)))

(define (sort-notes notes)
  (sort notes compare-notes))
