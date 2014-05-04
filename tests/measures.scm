(define measures-test-suite (test-suite-wrapper "Measures Suite"))
(define mtest (test measures-test-suite))

(mtest
  (measure? (empty-measure))
  "Empty Measure is a measure")

(mtest
  (equal? "4/4" (time-name (empty-measure)))
  "Empty Measure Defaults to 4/4")

(mtest
  (interval-equal? (make-interval 0 (max-duration 4 4)) (get-duration (empty-measure)))
  "Empty Measure Has Duration corresponding to 4/4")


(mtest
  (eq? '() (get-notes (empty-measure)))
  "Empty Measure Has No Notes")


(let* (
      (note1 (create-note "C4" 0.25))
      (note2 (create-note "D4" 0.5))
      (note3 (create-note "E4" 1.25))
      (note4 (create-note "F4" 2.25))
      (note5 (create-note "g4" 1))
      (one-note-measure (add-note-to-measure (empty-measure) note1))
      (two-note-measure (add-note-to-measure one-note-measure note2))
      (three-note-measure (add-note-to-measure two-note-measure note3))
      (four-note-measure (add-note-to-measure three-note-measure note5))
      ; (four1-note-measure (add-note-to-measure three-note-measure note4))
      )
  
  ; testing adding notes
  (mtest
    (equal? (get-notes one-note-measure) (list note1))
    "1 Note is added to measure list")

  (mtest
    (equal? (get-notes two-note-measure) (list note1 note2))
    "2 Notes are added to measure list")

  (mtest
    (equal? (get-notes three-note-measure) (list note1 note2 note3))
    "3 Notes are added to measure list")

  (mtest
    (equal? (get-notes four-note-measure) (list note1 note2 note3 note5))
    "4 Notes are added to measure list")


  ; testing duration propagation
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

  ; (displaym "1note" (get-notes one-note-measure))
  ; (displaym "2note" (get-notes two-note-measure))
  ; (displaym "3note" (get-notes three-note-measure))
  ; (displaym "4note" (get-notes four-note-measure))

  (displaym "1note" (get-duration one-note-measure))
  (displaym "2note" (get-duration two-note-measure))
  (displaym "3note" (get-duration three-note-measure))
  (displaym "4note" (get-duration four-note-measure))
  ; (displaym "4note1" (get-duration four1-note-measure))
)

; (mtest
;   (= (string-count "a###" "#") 3)
;   "3 #'s in a###")
; (mtest
;   (= (string-count "a" "#") 0)
;   "0 #'s in a")
; (mtest
;   (= (string-count "" "#") 0)
;   "0 for null string")