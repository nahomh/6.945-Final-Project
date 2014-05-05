(define duration-test-suite (test-suite-wrapper "Duration Test Suite"))
(define dtest (test duration-test-suite))

(dtest
  (= (max-duration 4 4) 4)
  "4/4 has max duration of 4")

(dtest
  (= (max-duration 2 4) 2)
  "2/4 has max duration of 2")

(dtest
  (= (max-duration 0 4) 0)
  "0/4 has max duration of 0")

(dtest
  (= (max-duration 6 8) 3)
  "6/8 has max duration of 3")

(dtest
  (= (max-duration 12 4) 12)
  "12/4 has max duration of 12")

(dtest
  (= (max-duration 8 2) 16)
  "8/2 has max duration of 16")

(dtest
  (= (max-duration 16 1) 64)
  "16/1 has max duration of 64")

