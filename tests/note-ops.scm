(define note-test-suite (test-suite-wrapper "Note Operations Suite"))
(define notest (test note-test-suite))


(notest
  (= (cent-octave-count 4) 0)
  "should return 0 because there is no octave shift")

(notest
  (= (cent-octave-count 6) 2400)
  "should return a postive 2400 ")

(notest
  (= (cent-octave-count 2) -2400)
  "should return a negative 2400 ")

(notest
  (= (get-accent-count '("#" 2)) 200)
  "should return 2*semicount or 200")

(notest
  (= (get-accent-count '("b" 2)) -200)
  "should return -2*semicount or -200")

(notest
  (= (get-accent-count '("b" 0)) 0)
  "should return 0")

(notest
  (= (get-cent (create-note "F#4" 2)) 600)
  "should return 600")

(notest
  (= (get-cent (create-note "F##4" 2)) 700)
  "should return 700")
(notest
  (= (get-cent (create-note "F4" 2)) 500)
  "should return 500")
(notest
  (= (get-cent (create-note "Fb4" 2)) 400)
  "should return 400")
(notest
  (= (get-cent (create-note "C4" 2)) 0)
  "should return 0")

