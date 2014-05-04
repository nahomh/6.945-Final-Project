(define note-test-suite (test-suite-wrapper "Note Test Suite"))
(define ntest (test note-test-suite))

(ntest
  (let ((note (empty-note)))
    (and
      (eq? (eq-get note 'type) 'note)
      (eq? (eq-get note 'pitch) #\C)
      (= (eq-get note 'duration) 0.25)
      (eq? (eq-get note 'octave) 4)
      (equal? (eq-get note 'accent) (list "b" 0))))
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


