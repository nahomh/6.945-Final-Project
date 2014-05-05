(define (make-duration duration)
  (define-cell duration-cell)
  (eq-put! duration-cell 'type 'duration)
  (add-content duration-cell duration)
  duration-cell
)

(define empty-duration 
  (lambda ()
    (make-duration 0)))