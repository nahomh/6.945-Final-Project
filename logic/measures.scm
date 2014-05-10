(define (empty-measure)
  (define-cell measure)
  (eq-put! measure 'type 'measure)
  (eq-put! measure 'numer-time 4)
  (eq-put! measure 'denom-time 4)
  (eq-put! measure 'duration (make-duration 4 4))
  (eq-put! measure 'notes '()))

(define (prop-notes notes master-cell)
  (if (= (length notes) 1)
    (c:id (eq-get (car notes) 'duration) master-cell)
  
    (c:id
      (reduce 
        (lambda (index previous)
          (if (eq? #f (get-duration previous)) 
              (ce:+ (eq-get index 'duration) previous)
              (ce:+ (eq-get index 'duration) (eq-get previous 'duration))))
        0 notes)
    master-cell)
  )
  (restart-prob-error (handle-measure-propagation (lambda ()(inquire master-cell))))
  (restart-prob-error (handle-measure-propagation (lambda ()(inquire master-cell))))
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
        (old-duration (eq-get measure 'duration))
        (old-notes (map (lambda(note) (copy-note note)) (get-notes measure)))
       )
        ; (displaym "copy-measure:inside")

       (eq-put! new-measure 'numer-time old-numer-time)
       (eq-put! new-measure 'denom-time old-numer-time)
       (eq-put! new-measure 'duration old-duration)
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


(define (restart-prob-error thunk)
  (bind-condition-handler (list condition-type:error)
    (lambda (condition)
      (display condition)
      (newline)
      (newline)
      (pp condition)
      (invoke-restart (find-restart 'measure-propagation) 1 2))
    thunk))

(define (handle-measure-propagation thunk)
  (lambda ()
    (call-with-current-continuation
      (lambda (kappa)
        (with-restart 'measure-propagation "Malcom Measure Propagation"
        (lambda (a b)
          (kappa (make-duration .25)))
        values thunk)))))
