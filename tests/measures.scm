(define measures-test-suite (test-suite-wrapper "Measures Suite"))
(define mtest (test measures-test-suite))

(mtest
  (measure? (empty-measure))
  "Empty Measure is a measure")

(mtest
  (equal? "4/4" (time-name (empty-measure)))
  "Empty Measure Defaults to 4/4")

(mtest
  (= 0 (get-duration (empty-measure)))
  "Empty Measure Has No Duration")


(mtest
  (eq? '() (get-notes (empty-measure)))
  "Empty Measure Has No Notes")


(let* (
      (note1 (create-note "C4" 0.25))
      (note2 (create-note "D4" 0.5))
      (note3 (create-note "E4" 1.25))
      (note4 (create-note "F4" 2.25))
      (note5 (create-note "g4" 1))
      (note6 (create-note "c4" 50))
      (one-note-measure (add-note-to-measure (empty-measure) note1))
      (two-note-measure (add-note-to-measure one-note-measure note2))
      (three-note-measure (add-note-to-measure two-note-measure note3))
      (four-note-measure (add-note-to-measure three-note-measure note5))
      (overlap2-measures (add-note-to-measure three-note-measure note4))
      (overlap13-measures (add-note-to-measure three-note-measure note6))
      )
  
  ; ; testing adding notes
  (displaym "one-note" one-note-measure)
  ; need to do this test
  ; need a note-eq? or generic eq? operator
  ; (mtest
  ;   (equal? (get-notes one-note-measure) (list note1))
  ;   "1 Note is added to measure list")

  ; (mtest
  ;   (equal? (get-notes two-note-measure) (list note1 note2))
  ;   "2 Notes are added to measure list")

  ; (mtest
  ;   (equal? (get-notes three-note-measure) (list note1 note2 note3))
  ;   "3 Notes are added to measure list")

  ; (mtest
  ;   (equal? (get-notes four-note-measure) (list note1 note2 note3 note5))
  ;   "4 Notes are added to measure list")
  (mtest
    (= (length (get-notes one-note-measure)) 1)
    "1 Note is added to measure list")

  (mtest
    (= (length (get-notes two-note-measure)) 2)
    "2 Notes are added to measure list")

  (mtest
    (= (length (get-notes three-note-measure)) 3)
    "3 Notes are added to measure list")

  (mtest
    (= (length (get-notes four-note-measure)) 4)
    "4 Notes are added to measure list")


  ; ; testing duration propagation
  (mtest
    (= (get-duration one-note-measure) 0.25)
    "Measure has duration of single note")
  (mtest
    (= (get-duration two-note-measure) 0.75)
    "Measure has duration of 2 notes")
  (mtest
    (= (get-duration three-note-measure) 2)
    "Measure has duration of 3 notes")
  (mtest
    (= (get-duration four-note-measure) 3)
    "Measure has duration of 4 notes")

  (displaym "1note" (get-notes one-note-measure))
  (displaym "2note" (get-notes two-note-measure))
  (displaym "3note" (get-notes three-note-measure))
  (displaym "4note" (get-notes four-note-measure))
  (displaym "4note" (length (get-notes four-note-measure)))
  (displaym "4note1" (get-notes (car overlap2-measures)))
  (displaym "over13" (length overlap13-measures))
  (displaym "over13reg" overlap13-measures)
  (displaym "4note" (map (lambda (note) (pitch-str note)) (get-notes four-note-measure)))
  (displaym "over" (map (lambda (note) (pitch-str note)) (get-notes (car overlap13-measures))))

  ; (displaym "1note" (get-duration one-note-measure))
  ; (displaym "2note" (get-duration two-note-measure))
  ; (displaym "3note" (get-duration three-note-measure))
  ; (displaym "4note" (get-duration four-note-measure))
  ; (displaym "4note1" (get-duration overlap2-measures))

  ; test multiple measures returned when note doesn't fit
  (mtest
    (list? overlap2-measures)
    "Should return a list when note doesn't fit")
  (mtest
    (= (length overlap2-measures) 2)
    "Should return a list of length two when note doesn't fit")
  (mtest
    (= 
      (get-duration (car overlap2-measures))
      (cell-max-duration (car overlap2-measures)))
    "First measure is at maximal duration")
  (mtest
    (=
      (get-duration (cadr overlap2-measures)) 0.25)
    "Second measure should hold overlapping duration of note")
  (mtest
    (list? overlap13-measures)
    "Should return a list when note doesn't fit")
  (mtest
    (= (length overlap13-measures) 13)
    "Should return a list of length 13 when note doesn't fit")
  (mtest
    (= 
      (get-duration (car overlap13-measures))
      (cell-max-duration (car overlap13-measures)))
    "First measure is at maximal duration")
)