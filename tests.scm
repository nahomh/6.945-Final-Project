(load "load")

(displaym "malcom" 1)
(displaym "malcom" 1 2 3)
(displaym "malcom" 1 "2")
(displaym "malcom" 1)
(displaym "malcom" 1)

(define (test-suite-wrappera)
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
          (set! failure-messages (append failure-messages (list message)))
          ; (displaym "after fail" num-failed)
          ; (displaym "after fail" failure-messages)
        )
      )
    )

    (define (print-tests)
      (displaym "passed tests" num-passed)
      (displaym "failed tests" num-failed)
      (if (= 0 num-failed) 
        #f 
        (begin 
          (display "\033[1;31m") ; change color to red
          (apply displaym (append (list "failure-messages") failure-messages))
          (display "\033[0m")) ; change color back to default
      )
    )

    (if (eq? 'run sym)
        (test-suite sym1 message)
        (print-tests)
    )
  )
)
(define my-test-suite (test-suite-wrappera))

(define (test bool message)
  (if bool 
      (my-test-suite 'run 'pass message)
      (my-test-suite 'run 'fail message))
)

(test #f "this should fail")
(test #f "this should also fail")
(test #f "this should also fail2")
(test #t "this should pass")

(my-test-suite 'print 'a "")
