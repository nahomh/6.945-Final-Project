(define (get-pitch pitch-string)
  (string-ref pitch-string 0))

(define (get-accent pitch-string)
  (let* 
    (
     (pitch-substr (string-tail pitch-string 1))
     (num-sharps (string-count pitch-substr #\#)) 
     (num-flats (string-count pitch-substr #\b))
     (difference (- num-sharps num-flats))
    )
    (if (> 0 difference)
      (cons "#" difference)
      (cons "b" difference))))


(define (get-octave pitch-string)
  (let* (
    (last-flat (string-search-backward pitch-string "b"))
    (last-sharp (string-search-backward pitch-string "#")))

    (cond
      ((and (eq? last-flat #f) (eq? last-sharp #f))
        (string-tail pitch-string 1))
      ((eq? last-flat #f)
        (string-tail pitch-string last-sharp))
      ((eq? last-sharp #f)
        (string-tail pitch-string last-flat))
      (else
        (string-tail pitch-string (max last-flat last-sharp))))))

(define (get-octave-num pitch-string)
  (string->number (get-octave pitch-string))
)