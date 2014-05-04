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
