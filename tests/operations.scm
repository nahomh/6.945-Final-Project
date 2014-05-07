; Test the transpose and other operations
(define operations-test-suite (test-suite-wrapper "Operations Suite"))
(define opertests (test operations-test-suite))

;;Todo

(opertests 
  (equal? (create-pitch-string (list #\A #\# 2)) "A##")
  "New pitch string should be A##"
)

(opertests 
  (equal? (create-pitch-string (list #\A #\# 0)) "A")
  "New pitch string should be A"
)

(opertests 
  (equal? (create-pitch-string (list #\C #\# 0)) "C")
  "New pitch string should be C"
)


(opertests 
  (equal? 
  	(let (
  		(note (transpose-note (create-note "C#4" 2) 34))
  		)
  		(get-pitch note)) #\B)
  "transposed note should be B"
)

(opertests 
  (equal? 
  	(let (
  		(note (transpose-note (create-note "C#4" 2) 34))
  		)
  		(get-octave note)) 6)
  "transposed note's octave should be 6"
)


