(define (max-duration numer-time denom-time)
  (* numer-time (/ 4 denom-time))
)


(define (make-duration duration #!optional denom-time)
  (define-cell duration-cell)
  (eq-put! duration-cell 'type 'duration)
  (if (not (default-object? denom-time))
    (begin
      (add-content duration-cell 
        (make-interval 0 (max-duration duration denom-time)))
      duration-cell
    )
    (begin
      (add-content duration-cell duration)
      duration-cell
    )
  )
)