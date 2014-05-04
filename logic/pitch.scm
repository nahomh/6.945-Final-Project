(define (string-count str pattern)
  (if (equal? str "")
    0
    (length (string-search-all pattern str))))


(define (str:get-pitch pitch-string)
  (string-ref (string-upcase pitch-string) 0))

(define (str:get-accent pitch-string)
  (let* 
    (
     (pitch-substr (string-tail pitch-string 1))
     (num-sharps (string-count pitch-substr "#")) 
     (num-flats (string-count pitch-substr "b"))
     (difference (- num-sharps num-flats))
    )
    (if (> difference 0)
      (list "#" (abs difference))
      (list "b" (abs difference)))))


(define (str:get-octave-str pitch-string)
  (let* (
    (last-flat (string-search-backward "b" pitch-string))
    (last-sharp (string-search-backward "#" pitch-string)))
    ; (displaym "last-flat" last-flat)
    ; (displaym "last-sharp" last-sharp)
    (cond
      ((and (eq? last-flat #f) (eq? last-sharp #f))
        (string-tail pitch-string 1))
      ((eq? last-flat #f)
        (string-tail pitch-string last-sharp))
      ((eq? last-sharp #f)
        (string-tail pitch-string last-flat))
      (else
        (string-tail pitch-string (max last-flat last-sharp))))))

(define (str:get-octave pitch-string)
  (let ((octave-str (str:get-octave-str pitch-string)))
    (if (equal? "" octave-str) 
      4 (string->number octave-str)))
)