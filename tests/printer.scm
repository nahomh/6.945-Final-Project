(load "load")
(load "tests/harness")
(load "tests/examples")
(load "tests/chord")
(load "tests/duration")
(load "tests/interval")
(load "tests/measures")
(load "tests/note-ops")
(load "tests/note")
(load "tests/operations")
(load "tests/piece")
(load "tests/pitch-ops")
(load "tests/validation")


; print test results
(define nil '())
(define (print-test-suites . suites)
  (for-each (lambda (suite)
    (suite 'print nil nil))
    suites
  )
)
(print-test-suites 
  my-test-suite
  my-test-suite2
  chord-test-suite
  duration-test-suite
  interval-test-suite
  measures-test-suite
  note-test-suite
  operations-test-suite
  piece-test-suite
  pitch-ops-test-suite
  valid-pitch-test-suite
  valid-octave-test-suite
  valid-time-test-suite
)
