(define measures-test-suite (test-suite-wrapper "Measures Suite"))
(define mtest (test measures-test-suite))
(run)
(mtest
  (measure? (empty-measure))
  "Empty Measure is a measure")

(mtest
  (equal? "4/4" (time-name (empty-measure)))
  "Empty Measure Defaults to 4/4")

(mtest
  (= 0 (get-duration (empty-measure)))
  "Empty Measure Has Duration Of Zero")

(mtest
  (eq? '() (get-notes (empty-measure)))
  "Empty Measure Has No Notes")

; (mtest
;   (= (string-count "abbb" "b") 3)
;   "Empty Measure Has Type Measure")

; (mtest
;   (= (string-count "a###" "#") 3)
;   "3 #'s in a###")
; (mtest
;   (= (string-count "a" "#") 0)
;   "0 #'s in a")
; (mtest
;   (= (string-count "" "#") 0)
;   "0 for null string")