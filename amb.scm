;This is used for generating musical notes from the system . 
(load "load")
(load "load-amb")
(init)

(define (require p)
  (if (not p) (amb)))

(define (distinct l)
  (cond ((null? l) true)
  ((null? (cdr l)) true)
  ((member (car l) (cdr l)) false)
  (else (distinct (cdr l)))))


(define (parallel-note? note1 note2 cent-val)
  (= (abs (- 
    (get-cent (create-note note1 .25))
    (get-cent (create-note note2 .25)))) 
  cent-val))


(define (no-parallel l cent-val)
  ; (display "parallel")
  (cond ((null? l) true)
  ((null? (cdr l)) true)
  ((parallel-note? (car l) (cadr l) cent-val) false)
  (else (no-parallel (cdr l) cent-val))))

(define (no-parallel-octaves l)
  (no-parallel l 1200))
(define (no-parallel-fifths l)
  (no-parallel l 700))
(define (no-parallel-unisons l)
  (no-parallel l 0))

(define amb-notes
  (lambda()
    ; hack around fact that you can't
    ; call apply amb list....
    ; also only diatonic in alto range atm
    (amb 
      "c2" "d2" "e2" "f2" "g2" "a2" "b2"
      "c3" "d3" "e3" "f3" "g3" "a3" "b3"
      "c4" "d4" "e4" "f4" "g4" "a4" "b4"
      "c5" "d5" "e5" "f5" "g5" "a5" "b5")))

(define (amb-note-list l)
  ; (display "anl: ")
  ; (display l)
  ; (newline)
  (if (null? l)
    '()
    (append (list (amb-notes)) (amb-note-list (cdr l)))
  )
)

(define (amb-dispatch l note-amb)
  (if (null? l)
    #f
    (let ((sym (car l)))
      (cond 
            ((eq? 'no-parallel-octaves sym) 
              (require (no-parallel-octaves note-amb)))
            (else #f)
      )
      (amb-dispatch (cdr l) note-amb)
    )
  )
)

(define (gen-notes num l)
  (let
    ((note-list (iota num)))
    (display note-list)
    (let (
      (note-amb (amb-note-list note-list))
    )
    (display "note-amb: ")
    (display note-amb)
    (newline)
    (require (distinct note-amb))
    (amb-dispatch l note-amb)
    note-amb
  ))
)

