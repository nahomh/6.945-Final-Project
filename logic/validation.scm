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


(define (note? note)
  (if (cell? note)
    (eq? 'note (eq-get note 'type))
    #f))

(define valid-notes? notes
  (define (iterator note-list)
    (if (pair? note-list)
      (if (note? (car note-list))
        (iterator (cdr note-list))
        #f)
      #t))
  (iterator notes))