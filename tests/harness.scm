
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
;   Red         0;31     Light Red     1;31
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