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
  (equal? (piece1 'get 'key) "C")
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

; test different keys and time signatures
(define piece2 (new-piece 'd "2/4"))
(ptest 
  (equal? (piece2 'get 'key) "D")
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

; test key parsing
(define piece3 (new-piece 'dbb))
(define piece4 (new-piece 'd#2))
(ptest 
  (equal? (piece3 'get 'key) "Dbb")
  "Piece Key Handles Flats"
)
(ptest 
  (equal? (piece4 'get 'key) "D#")
  "Piece Key Handles Octaves"
)
(ptest 
  (= (piece4 'get 'octave) 2)
  "Piece Octave Takes Input Value 2"
)

;test pitch regexp

(define valid-pitch-test-suite (test-suite-wrapper "Valid Pitch Suite"))
(define vtest (test valid-pitch-test-suite))

(vtest
  (not (valid-pitch? "A-2")) 
  "Negative signs detected")

(vtest
  (valid-pitch? "A2") 
  "Valid pitch accepted")

(vtest
  (not (valid-pitch? "Zbb3")) 
  "Illegal letters detected")

(vtest
  (not (valid-pitch? "ABcb3")) 
  "Multiple letters detected")

(vtest
  (valid-pitch? "g#b###532")
  "Multiple sharps and flats accepted")

;test time regexp

(define valid-time-test-suite (test-suite-wrapper "Valid Time Suite"))
(define vttest (test valid-time-test-suite))

(vttest
  (valid-time? "4/4")
  "4/4 is valid time signature")

(vttest
  (valid-time? "2/4")
  "2/4 is valid time signature")

(vttest
  (valid-time? "6/8")
  "6/8 is valid time signature")

(vttest
  (valid-time? "12/4")
  "12/4 is valid time signature")

(vttest
  (valid-time? "4/44")
  "4/44 is valid time signature")

(vttest
  (not (valid-time? "432r"))
  "432r is valid time signature")

(vttest
  (not (valid-time? "4.3/44"))
  "4.3/44 is valid time signature")

(vttest
  (not (valid-time? "4/4.4"))
  "4/4.4 is valid time signature")

(define note-test-suite (test-suite-wrapper "Note Test Suite"))
(define ntest (test note-test-suite))

(ntest
  (let ((note (empty-note)))
    (and
      (eq? (eq-get note 'type) 'note)
      (eq? (eq-get note 'pitch) #\C)
      (= (eq-get note 'duration) 0.25)
      (eq? (eq-get note 'octave) 4)
      (equal? (eq-get note 'accent) '())))
  "Empty note not created correctly")

(ntest
  (let ((note (create-note "Abb23" 0.5)))
    (and
      (eq? (eq-get note 'type) 'note)
      (eq? (eq-get note 'pitch) #\A)
      (= (eq-get note 'duration) 0.5)
      (eq? (eq-get note 'octave) 23)
      (equal? (eq-get note 'accent) (list "b" 2))))
  "Note 1 not created correctly")

(ntest
  (let ((note (create-note "b#b#b" 0.5)))
    (and
      (eq? (eq-get note 'type) 'note)
      (eq? (eq-get note 'pitch) #\B)
      (= (eq-get note 'duration) 0.5)
      (eq? (eq-get note 'octave) 4)
      (equal? (eq-get note 'accent) (list "b" 0))))
  "Note 2 not created correctly")

(ntest
  (let ((note (create-note "B#b#543" 1)))
    (and
      (eq? (eq-get note 'type) 'note)
      (eq? (eq-get note 'pitch) #\B)
      (= (eq-get note 'duration) 1)
      (eq? (eq-get note 'octave) 543)
      (equal? (eq-get note 'accent) (list "#" 1))))
  "Note 3 not created correctly")

(define chord-test-suite (test-suite-wrapper "Chord Test Suite"))
(define ctest (test chord-test-suite))

(define (note-list)
  `((create-note "Abb23" 0.5) 
    (create-note "b#b#b" 0.5)   
    (create-note "B#b#543" 0.5)))


(ctest
  (let ((chord (empty-chord)))
    (eq? (eq-get chord 'type) 'chord)
    (eq? (eq-get chord 'data) '()))
  "Empty note create correctly")

(ctest
  (let (
    (chord (create-chord 
      (create-note "Abb23" 0.5) 
      (create-note "b#b#b" 0.5) 
      (create-note "B#b#543" 0.5))))
    (= (length (eq-get chord 'data)) 3))
  "Correct length of notes")

(ctest
  (let (
    (chord (create-chord 
      (create-note "Abb23" 0.5) 
      (create-note "b#b#b" 0.5) )))
    (eq? chord "Must have three or more notes in a chord"))
  "This should fail: Requires 3 or more notes correctly")


(ctest
  (let (
    (chord (create-chord 
      (create-note "Abb23" 0.5) 
      (create-note "b#b#b" 0.5) 
      'b)))
    (eq? chord "The set of notes passed in aren't valid"))
  "This should fail: Ensures all notes in chord are valid notes")

; valid octave tests
(define valid-octave-test-suite (test-suite-wrapper "Valid Octave Suite"))
(define votest (test valid-octave-test-suite))

(votest
  (valid-octave? 0)
  "0 is valid octave")

(votest
  (valid-octave? 3)
  "3 is valid octave")

(votest
  (valid-octave? 6)
  "6 is valid octave")

(votest
  (not (valid-octave? "12/4"))
  "12/4 is not a valid octave - only numbers")

(votest
  (not (valid-octave? 6.5))
  "6.5 is not valid octave - only integers")


(define pitch-ops-test-suite (test-suite-wrapper "Pitch Operations Suite"))
(define potest (test pitch-ops-test-suite))

(potest
  (eqv? (get-pitch "ab3") #\A)
  "Get pitch gets first value as uppercase char")

(potest
  (not (eqv? (get-pitch "ab3") #\a))
  "Get pitch does not return lowercase")

(potest
  (eqv? (get-pitch "gdfadb3") #\G)
  "Get pitch gets first value as uppercase char")


(potest
  (= (string-count "abbb" "b") 3)
  "3 b's in abbb")
(potest
  (= (string-count "a###" "#") 3)
  "3 #'s in a###")
(potest
  (= (string-count "a" "#") 0)
  "0 #'s in a")
(potest
  (= (string-count "" "#") 0)
  "0 for null string")


(potest
  (= (length (get-accent "a")) 2)
  "get-accent returns length 2 list")

(potest
  (equal? (car (get-accent "abbb")) "b")
  "get-accent tag should be flat for abbb")

(potest
  (equal? (cadr (get-accent "abbb")) 3)
  "get-accent val should be 3 for abbb")

(potest
  (equal? (cadr (get-accent "a###")) 3)
  "get-accent val should be 3 for abbb")

(potest
  (equal? (cadr (get-accent "ab#")) 0)
  "get-accent val should be 0 for ab#")

(potest
  (equal? (car (get-accent "ab#")) "b")
  "get-accent tag should be b for no accent")

(potest
  (equal? (cadr (get-accent "ab#2")) 0)
  "get-accent val should be 0 for ab#2")

(potest
  (equal? (car (get-accent "ab#2")) "b")
  "get-accent tag should be b for no accent")

(potest
  (equal? (cadr (get-accent "ab##")) 1)
  "get-accent val should be 1 for ab##")

(potest
  (equal? (car (get-accent "ab##")) "#")
  "get-accent tag should be # for ab##")




(potest
  (equal? (get-octave "ab##") "")
  "get-octave should defualt to ''")

(potest
  (= (get-octave-num "ab##") 4)
  "get-octave should defualt to 4")

(potest
  (= (get-octave-num "ab##1") 1)
  "get-octave should be 1 for ab##1")

(potest
  (= (get-octave-num "ab##123") 123)
  "get-octave should be 123 for ab##123")

; (potest
;   (valid-octave? 6)
;   "6 is valid octave")

; (potest
;   (not (valid-octave? "12/4"))
;   "12/4 is not a valid octave - only numbers")

; (potest
;   (not (valid-octave? 6.5))
;   "6.5 is not valid octave - only integers")



(define note-test-suite (test-suite-wrapper "Note Operations Suite"))
(define notest (test note-test-suite))

(notest
  (eq? (is-middle? #\C 4 '("#" 0)) #t)
    "is-middle should return true for C4 with 0 sharp/flats")



; print test results
(define nil '())
(define (print-test-suites . suites)
  (for-each (lambda (suite)
    (suite 'print nil nil))
    suites
  )
)
(print-test-suites 
  chord-test-suite
  my-test-suite
  my-test-suite2
  note-test-suite
  piece-test-suite
  valid-pitch-test-suite
  valid-octave-test-suite
  valid-time-test-suite
  pitch-ops-test-suite
  note-test-suite)
