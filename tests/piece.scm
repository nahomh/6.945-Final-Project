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

;Test key transposing stuff
(define piece5 (new-piece 'Bb))
(define piece6 (new-piece 'G##))

(ptest
  (= (get-value (piece5 'get 'key)) -200)
  "Correct value of key")

(ptest
  (= (get-value (piece6 'get 'key)) -300)
  "G## is correct!")

(ptest
  (equal? 
    (get-pitch-list-from-key "Bb")
    (list #\B #\C #\D #\E #\F #\G #\A))
  "Correct list of pitches from B")


(ptest
  (equal? 
    (get-pitch-list-from-key "G##")
    (list #\G #\A #\B #\C #\D #\E #\F))
  "Correct list of pitches from B")

(ptest
  (equal?
    (get-scale "Bb" major-tones)
    (list "Bb" "C" "D" "Eb" "F" "G" "A"))
  "Bb major key works")

(ptest
  (equal?
    (get-scale "D" major-tones)
    (list "D" "E" "F#" "G" "A" "B" "C#"))
  "D major key works")

(ptest
  (equal?
    (get-scale "G" major-tones)
    (list "G" "A" "B" "C" "D" "E" "F#"))
  "G major key works")

(ptest
  (equal?
    (get-scale "D" minor-tones)
    (list "D" "E" "F" "G" "A" "Bb" "C"))
  "D minor key works")

(ptest
  (equal?
    (convert-note "D#" piece5)
    "Eb")
  "Converts D# to Eb in Bb key")


(ptest
  (equal?
    (convert-note "F#" piece5)
    "F#")
  "Leaves F# alone in Bb key")


