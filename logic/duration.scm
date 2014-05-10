(define (cell-max-duration cell)
  (max-duration (get-numer cell) (get-denom cell))
)

(define (max-duration numer-time denom-time)
  (* numer-time (/ 4 denom-time))
)


(define (make-duration duration #!optional denom-time)
  (if (not (default-object? denom-time))
    (max-duration duration denom-time)
    duration
  )
)
