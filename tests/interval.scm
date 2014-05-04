(define interval-test-suite (test-suite-wrapper "Interval Operations Suite"))
(define intest (test interval-test-suite))
; ()


(intest
  (string=? (interval (create-note "F4" 2) (create-note "G4" 2)) "M2")
  "should return M2 due to semitone value of 2")

(intest
  (string=? (interval (create-note "F4" 2) (create-note "C4" 2)) "P4")
  "should return P4 due to semitone value of 2")

(intest
  (string=? (interval (create-note "F4" 2) (create-note "A4" 2)) "m6")
  "should return m6 due to semitone value of 8")


(intest
  (string=? (interval (create-note "E4" 2) (create-note "A2" 2)) "P5")
  "should return P5 due to semitone value of 31")


