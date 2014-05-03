(define (valid-pitch? pitch-str)
  (let ((valid 
    (re-string-match 
      (rexp-compile (rexp-pitch)) pitch-str)))
    (if (not (eq? valid #f)) #t #f)
  )
)

(define (valid-time? time-str)
  (let ((valid 
    (re-string-match 
      (rexp-compile (rexp-time)) time-str)))
    (if (not (eq? valid #f)) #t #f)
  )
)

(define (valid-octave? num)
  (integer? num))