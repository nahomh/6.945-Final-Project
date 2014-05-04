(cd "..")
(load "load")
(load "piece")
(cd "tests")
(load "harness")
(load "examples")
(load "chord")
(load "harness")
(load "note-ops")
(load "note")
(load "piece")
(load "pitch-ops")
(load "validation")

; print test results
(define nil '())
(define (print-test-suites . suites)
  (for-each (lambda (suite)
    (suite 'print nil nil))
    suites
  )
)
(print-test-suites 
  chord-test-suite
  my-test-suite
  my-test-suite2
  note-test-suite
  piece-test-suite
  pitch-ops-test-suite
  valid-pitch-test-suite
  valid-octave-test-suite
  valid-time-test-suite)