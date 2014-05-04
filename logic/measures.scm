(define (empty-measure)
  (define-cell measure)
  (eq-put! measure 'type 'measure)
  (eq-put! measure 'numer-time 4)
  (eq-put! measure 'denom-time 4)
  (eq-put! measure 'duration (make-duration 4 4))
  (eq-put! measure 'notes '()))

(define (prop-notes notes master-cell)
  ; (displaym "notes" notes)
  ; (for-each (lambda (note) (displaym "note" (get-pitch note))) notes)
  (c:id
    (reduce 
      (lambda (index previous)
        ; (displaym "index" (inquire index))
        ; (displaym "get-duration" (eq-get index 'duration))
        ; (displaym "previous" (inquire previous))
        ; (displaym "previous-p" (get-pitch previous))
        ; (displaym "previous-t" (eq-get previous 'type))
        ; (displaym "previous-i" (inquire previous))
        ; (displaym "get-duration" (eq-get previous 'duration))

        (if (eq? #f (get-duration previous)) 
            (ce:+ (eq-get index 'duration) previous)
            (ce:+ (eq-get index 'duration) (eq-get previous 'duration))))
      0 notes)
  master-cell)
  ; (displaym "master" master-cell)
  ; (displaym "master-val" (inquire master-cell))
  master-cell
)

(define (set-duration measure)
  (let (
        (notes (get-notes measure))
       )
    (eq-put! measure 'duration 
      (prop-notes notes (make-duration (get-numer measure) (get-denom measure))))
    measure
  )
)

(define (copy-measure measure)
  ; (displaym "copy-measure")
  (let (
        (new-measure (empty-measure))
        (old-numer-time (get-numer measure))
        (old-denom-time (get-denom measure))
        (old-notes (map (lambda(note) (copy-note note)) (get-notes measure)))
       )
        ; (displaym "copy-measure:inside")

       (eq-put! new-measure 'numer-time old-numer-time)
       (eq-put! new-measure 'denom-time old-numer-time)
       (eq-put! new-measure 'duration 
        (prop-notes old-notes 
          (make-duration old-numer-time old-denom-time)))
       (eq-put! new-measure 'notes old-notes)
  )
)

(define (add-note-to-measure measure note)
  (let (
        (measure-copy (copy-measure measure))
        (notes (get-notes measure))
       )
       (eq-put! measure-copy 'notes (append notes (list note)))
       (set-duration measure-copy)
  )
)