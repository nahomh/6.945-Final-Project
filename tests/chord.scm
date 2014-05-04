(define chord-test-suite (test-suite-wrapper "Chord Test Suite"))
(define ctest (test chord-test-suite))

(define (note-list)
  `((create-note "Abb23" 0.5) 
    (create-note "b#b#b" 0.5)   
    (create-note "B#b#543" 0.5)))

(define basic-chord
  (create-chord
    (create-note "C2" 0.5)
    (create-note "D6" 0.5)    
    (create-note "F8" 0.5)))


(define unordered-chord
  (create-chord
    (create-note "D6" 0.5)
    (create-note "B5" 0.5)    
    (create-note "A1" 0.5)))

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

(ctest
  (let* ((new-chord (first-inversion basic-chord)) (first-note (car (get-notes new-chord))))
    (and
      (eq? (get-pitch first-note) #\C)
      (= (get-octave first-note) 3)))
  "Chord inversion not working for basic chord")

(ctest
  (let* ((new-chord (first-inversion unordered-chord)) (first-note (car (get-notes new-chord))))
    (and
      (eq? (get-pitch first-note) #\A)
      (= (get-octave first-note) 2)))
  "Chord inversion not working for basic chord")

