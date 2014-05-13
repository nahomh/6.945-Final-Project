;This is used for generating musical notes from the system . 
(load "load")
(load "load-amb")
(init)

; (define (displaym label . things) 
;   (define should-display #t)
;   (define (internal)
;     (newline)
;     (display (string label ": "))
;     (if (> (length things) 1)
;       (for-each (lambda (thing)
;         (newline)
;         (display "    ")
;         (display thing)
;         )
;         things
;       )
;       (if (not (null? things)) (display (car things)))
;     )
;   )
;   (if should-display (internal) (display ""))
; )
(define (require p)
  (if (not p) (amb)))

(define (distinct l)
  (cond ((null? l) true)
  ((null? (cdr l)) true)
  ((member (car l) (cdr l)) false)
  (else (distinct (cdr l)))))


(define (parallel-octave? note1 note2)
  (display "val: ")
  (display note1)
  (newline)
  (display "get-cent: ")
  (display (get-cent (create-note note1 .25)))
  (newline)
  (display "get-cent: ")
  (display (get-cent (create-note note2 .25)))
  (newline)
  (newline)

  (= (abs (- 
    (get-cent (create-note note1 .25))
    (get-cent (create-note note2 .25)))) 
  1200))

(define (no-parallel-octaves l)
  (display "parallel")
  (cond ((null? l) true)
  ((null? (cdr l)) true)
  ((parallel-octave? (car l) (cadr l)) false)
  (else (no-parallel-octaves (cdr l)))))

(define amb-notes
  (lambda()
    (amb "c5" "c6" "c4" "e3")))

(define (amb-note-list l)
  (display "anl: ")
  (display l)
  (newline)
  (if (null? l)
    '()
    (append (list (amb-notes)) (amb-note-list (cdr l)))
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
    ; (require (distinct note-amb))
    (require (no-parallel-octaves note-amb))
    note-amb
  ))
)

(gen-notes 5 '(3 0))