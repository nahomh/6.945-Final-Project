; Test the piece generation
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
