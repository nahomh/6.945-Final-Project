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