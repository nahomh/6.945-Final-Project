(define pitch-ops-test-suite (test-suite-wrapper "Pitch Operations Suite"))
(define potest (test pitch-ops-test-suite))

(potest
  (eqv? (get-pitch "ab3") #\A)
  "Get pitch gets first value as uppercase char")

(potest
  (not (eqv? (get-pitch "ab3") #\a))
  "Get pitch does not return lowercase")

(potest
  (eqv? (get-pitch "gdfadb3") #\G)
  "Get pitch gets first value as uppercase char")


(potest
  (= (string-count "abbb" "b") 3)
  "3 b's in abbb")
(potest
  (= (string-count "a###" "#") 3)
  "3 #'s in a###")
(potest
  (= (string-count "a" "#") 0)
  "0 #'s in a")
(potest
  (= (string-count "" "#") 0)
  "0 for null string")


(potest
  (= (length (get-accent "a")) 2)
  "get-accent returns length 2 list")

(potest
  (equal? (car (get-accent "abbb")) "b")
  "get-accent tag should be flat for abbb")

(potest
  (equal? (cadr (get-accent "abbb")) 3)
  "get-accent val should be 3 for abbb")

(potest
  (equal? (cadr (get-accent "a###")) 3)
  "get-accent val should be 3 for abbb")

(potest
  (equal? (cadr (get-accent "ab#")) 0)
  "get-accent val should be 0 for ab#")

(potest
  (equal? (car (get-accent "ab#")) "b")
  "get-accent tag should be b for no accent")

(potest
  (equal? (cadr (get-accent "ab#2")) 0)
  "get-accent val should be 0 for ab#2")

(potest
  (equal? (car (get-accent "ab#2")) "b")
  "get-accent tag should be b for no accent")

(potest
  (equal? (cadr (get-accent "ab##")) 1)
  "get-accent val should be 1 for ab##")

(potest
  (equal? (car (get-accent "ab##")) "#")
  "get-accent tag should be # for ab##")




(potest
  (equal? (str:get-octave-str "ab##") "")
  "get-octave should defualt to ''")

(potest
  (= (get-octave "ab##") 4)
  "get-octave should defualt to 4")

(potest
  (= (get-octave "ab##1") 1)
  "get-octave should be 1 for ab##1")

(potest
  (= (get-octave "ab##123") 123)
  "get-octave should be 123 for ab##123")


(potest
  (= (get-octave "F8") 8)
  "get-octave should be 8 for F8")
; (potest
;   (valid-octave? 6)
;   "6 is valid octave")

; (potest
;   (not (valid-octave? "12/4"))
;   "12/4 is not a valid octave - only numbers")

; (potest
;   (not (valid-octave? 6.5))
;   "6.5 is not valid octave - only integers")
