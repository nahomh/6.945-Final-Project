(define measures-test-suite (test-suite-wrapper "Measures Suite"))
(define mtest (test measures-test-suite))

(mtest
  (eqv? (get-pitch "ab3") #\A)
  "Empty Measure Defaults to 4/4")

(mtest
  (not (eqv? (get-pitch "ab3") #\a))
  "Empty Measure Has Duration Of Zero")

(mtest
  (eqv? (get-pitch "gdfadb3") #\G)
  "Empty Measure Has No Notes")

(mtest
  (= (string-count "abbb" "b") 3)
  "Empty Measure Has Type Measure")

; (mtest
;   (= (string-count "a###" "#") 3)
;   "3 #'s in a###")
; (mtest
;   (= (string-count "a" "#") 0)
;   "0 #'s in a")
; (mtest
;   (= (string-count "" "#") 0)
;   "0 for null string")