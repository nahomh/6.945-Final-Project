(define note-test-suite (test-suite-wrapper "Note Test Suite"))
(define ntest (test note-test-suite))

(ntest
  (let ((note (empty-note)))
    (and
      (note? note)
      (eq? (get-pitch note) #\C)
      (= (get-duration note) 0.25)
      (eq? (get-octave note) 4)
      (equal? (get-accent note) (list "b" 0))))
  "Empty note not created correctly")

(ntest
  (let ((note (create-note "Abb23" 0.5)))
    (and
      (note? note)
      (eq? (get-pitch note) #\A)
      (= (get-duration note) 0.5)
      (eq? (get-octave note) 23)
      (equal? (get-accent note) (list "b" 2))))
  "Note 1 not created correctly")

(ntest
  (let ((note (create-note "b#b#b" 0.5)))
    (and
      (note? note)
      (eq? (get-pitch note) #\B)
      (= (get-duration note) 0.5)
      (eq? (get-octave note) 4)
      (equal? (get-accent note) (list "b" 0))))
  "Note 2 not created correctly")

(ntest
  (let ((note (create-note "B#b#543" 1)))
    (and
      (note? note)
      (eq? (get-pitch note) #\B)
      (= (get-duration note) 1)
      (eq? (get-octave note) 543)
      (equal? (get-accent note) (list "#" 1))))
  "Note 3 not created correctly")


