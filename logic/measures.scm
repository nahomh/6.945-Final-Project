(define (empty-measure)
  (define-cell measure)
  (eq-put! measure 'type 'measure)
  (eq-put! measure 'numer-time 4)
  (eq-put! measure 'denom-time 4)
  (eq-put! measure 'duration 0)
  (eq-put! measure 'notes '()))


