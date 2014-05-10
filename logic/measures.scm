(define (empty-measure)
  (define-cell measure)
  (eq-put! measure 'type 'measure)
  (eq-put! measure 'numer-time 4)
  (eq-put! measure 'denom-time 4)
  (eq-put! measure 'duration 0)
  (eq-put! measure 'notes '()))

(define (add-duration! measure note)
  ; should only be called if note can fit in measure
  (eq-put! measure 'duration (+ (get-duration measure) (get-duration note)))
)

; (define (set-duration! measure)
;   (let (
;         (notes (get-notes measure))
;        )
;     (eq-put! measure 'duration 
;       (prop-notes notes (make-duration (get-numer measure) (get-denom measure))))
;     measure
;   )
; )

(define (copy-measure measure)
  ; (displaym "copy-measure")
  (let (
        (new-measure (empty-measure))
        (old-numer-time (get-numer measure))
        (old-denom-time (get-denom measure))
        (old-duration (get-duration measure))
        (old-notes (map (lambda(note) (copy-note note)) (get-notes measure)))
       )
        ; (displaym "copy-measure:inside")

       (eq-put! new-measure 'numer-time old-numer-time)
       (eq-put! new-measure 'denom-time old-numer-time)
       (eq-put! new-measure 'duration old-duration)
       (eq-put! new-measure 'notes old-notes)
  )
)

(define (note-fits? measure-copy note)
  (<=
    (+ (get-duration note) (get-duration measure-copy)) 
    (cell-max-duration measure-copy)
  )
)

(define (add-note-to-measure measure note)
  (let (
        (measure-copy (copy-measure measure))
       )
       (add-note-to-measure! measure-copy note)
  )
)

(define (listify thing)
  (list? thing) thing (list thing))

(define (add-note-and-split measure note)
  ; should only come here if note is longer than
  ; remaining duration in a measure
  (if (note-fits? measure note)
    (list (add-note-to-measure! measure note))
    (let* (
          (remaining-duration (- (cell-max-duration measure) (get-duration measure)))
          (extending-note-duration (- (get-duration note) remaining-duration))
          (note-copy (copy-note note))
          (measure-copy (copy-measure measure))
        )
        (modify-duration! note remaining-duration)
        (displaym "note duration" remaining-duration)
        (displaym "note duration ext" extending-note-duration)
        (modify-duration! note-copy extending-note-duration)
        (modify-duration! measure-copy 0)
        (eq-put! measure-copy 'notes '())
        (displaym "add-note-to-measure" measure-copy note-copy)
        (append 
          (list (add-note-to-measure! measure note))
          (add-note-and-split measure-copy note-copy))
  ))
)

(define (add-note-to-measure! measure note)
  (let (
        (notes (get-notes measure))
       )
       (displaym "note-fits" (note-fits? measure note))
       (if  (note-fits? measure note)
            (begin
              (eq-put! measure 'notes (append notes (list note)))
              (add-duration! measure note))
            (begin
              (add-note-and-split measure note))
       )
  )
)