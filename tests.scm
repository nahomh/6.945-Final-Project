(load "load")

(displaym "malcom" 1)
(displaym "malcom" 1 2 3)
(displaym "malcom" 1 "2")
(displaym "malcom" 1)
(displaym "malcom" 1)

(define (test-suite-wrapper name)
  (define num-passed 0)
  (define num-failed 0)
  (define failure-messages '())

  (lambda (sym sym1 message)
    (define (test-suite symbol message) 
      (if (eq? 'pass symbol)
        (set! num-passed (+ num-passed 1))
        (begin ; failure
          ; (displaym "faile" num-failed)
          (set! num-failed (+ num-failed 1))
          (set! failure-messages 
            (append failure-messages 
              (list (string-append "    " message))))
          ; (displaym "after fail" num-failed)
          ; (displaym "after fail" failure-messages)
        )
      )
    )

;   Black       0;30     Dark Gray     1;30
;   Blue        0;34     Light Blue    1;34
;   Green       0;32     Light Green   1;32
;   Cyan        0;36     Light Cyan    1;36
    ;   Red         0;31     Light Red     1;31*sc
;   Purple      0;35     Light Purple  1;35
;   Brown       0;33     Yellow        1;33
;   Light Gray  0;37     White         1;37
    (define (print-tests)
      (display "\033[1;34m") ; change color to blue
      (displaym name)
      (if (> num-failed 0)
        (display "\033[1;31m") ; change color to red
        (display "\033[1;32m") ; change color to green
      )
      (displaym "    passed tests" num-passed)
      (displaym "    failed tests" num-failed)
      (if (= 0 num-failed) 
        #f 
        (apply displaym 
          (append (list "    failure-messages") failure-messages))
      )
      (display "\033[0m") ; change color back to default
    )

    (if (eq? 'run sym)
        (test-suite sym1 message)
        (print-tests)
    )
  )
)

(define (test suite) 
  (lambda (bool message)
    (if bool 
        (suite 'run 'pass message)
        (suite 'run 'fail message))
  )
)

(define my-test-suite (test-suite-wrapper "Example Suite"))
(define ttest (test my-test-suite))
(ttest #f "this should fail")
(ttest #f "this should also fail")
(ttest #f "this should also fail2")
(ttest #t "this should pass")

(define my-test-suite2 (test-suite-wrapper "Example Suite2"))
(define ttest2 (test my-test-suite2))
(ttest2 #t "this should pass")
(ttest2 #t "this should also pass")

; Test the piece generation
(load "piece.scm")
(define piece-test-suite (test-suite-wrapper "Piece Suite"))
(define ptest (test piece-test-suite))

; test default piece values
(define piece1 (new-piece))
(ptest 
  (eq? (piece1 'get 'key) 'c)
  "Piece Key Defaults To C"
)
(ptest 
  (equal? (piece1 'get 'time) "4/4")
  "Piece Time Signature Defaults To 4/4"
)
(ptest 
  (= (piece1 'get 'octave) 4)
  "Piece Octave Defaults To 4"
)

;test pitch regexp

(ptest
  (eq? (valid-pitch? "A-2") #f) "Negative signs detected")

(ptest
  (not (eq? (valid-pitch? "A2") #f)) "Valid pitch accepted")

(ptest
  (eq? (valid-pitch? "Zbb3") #f) "Illegal letters detected")

(ptest
  (eq? (valid-pitch? "ABcb3") #f) "Multiple letters detected")

(ptest
  (not (eq? (valid-pitch? "g#b###532") #f)) "Multiple sharps and flats accepted")

; test different keys and time signatures
(define piece2 (new-piece 'd "2/4"))
(ptest 
  (eq? (piece2 'get 'key) 'd)
  "Piece Key Takes Input Value"
)
(ptest 
  (equal? (piece2 'get 'time) "2/4")
  "Piece Time Signature Takes Input Value"
)
(ptest 
  (= (piece2 'get 'octave) 4)
  "Piece Octave Defaults To 4"
)

; ; test key parsing
; (define piece3 (new-piece 'dbb))
; (define piece4 (new-piece 'd#2))
; (ptest 
;   (eq? (piece3 'get-key-sig) 'dbb)
;   "Piece Key Handles Flats"
; )
; (ptest 
;   (eq? (piece4 'get-key-sig) 'd#)
;   "Piece Key Handels Octaves"
; )
; (ptest 
;   (= (piece4 'get-octave) 2)
;   "Piece Octave Takes Input Value 2"
; )


; print test results
(define nil '())
(define (print-test-suites . suites)
  (for-each (lambda (suite)
    (suite 'print nil nil))
    suites
  )
)
(print-test-suites 
  my-test-suite
  my-test-suite2
  piece-test-suite)