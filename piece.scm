; Symbolic Representation for Music

; This is the main file for the system allowing the user to
; call the enviornment and began to input musical notes and chords. 
(load "load")

; going to use notes in midi, need one value
(define c0midi 0)
(define semitone 100) ; cents
(define wholetone (* 2 semitone))
; define intervals in terms of semitones


; other methods
; outside of new-piece function
; interval
; chord
; measure
; transpose
; invert -> chords
; note
; valid-pitch?
; valid-octave?
; valid-time?
; measure?
; chord?
; interval?
; note?

; note data structure -> '(note a# 5 0.25)
; note operatiosn car-caddr -> get-pitch etc...
; 

(define (valid-pitch? pitch-str)
  ; use regex we developed
  #f
)

(define (new-piece #!optional key-sig time-sig)
  ; creates a new piece in the key of "key" with 
  ; the time signature given by "time"
  (define-cell key)
  (eq-put! key 'type 'key)
  (eq-put! key 'data 'c)

  ; key handle string, symbol
  (define-cell time)
  (eq-put! time 'type 'time)
  (eq-put! time 'data "4/4")
  ; generic time 
  ; defaults to 4/4
  ; (define time "")
  ; (update-time time)
  ; should handle integer, string, symbol
  (define-cell octave)
  (eq-put! octave 'type 'octave)
  (eq-put! octave 'data 4)

  (define-cell measures) 
  (eq-put! measures 'type 'measures)
  (eq-put! measures 'data '())
  ; assume for now only one time sig
  ; change to tagged list later if multiple time sig
  ; '(
  ;    (4/4 note1 note2 note3 note4)
  ;    (4/4 note1 note2 note3 note4)
  ;    (2/4 note1 note2)
  ;    (3/4 note1 note2)
  ;  )
  ; if want to get measure do list->vector first

  ; type checkers for cells
  (define (key? symb)
    (eq? symb 'key))
  (define (time? symb)
    (eq? symb 'time))
  (define (octave? symb)
    (eq? symb 'octave))
  (define (measures? symb)
    (eq? symb 'measures))

  ; type checkers for cell data
  ; TODO make more strict
  (define (key-type? data)
    ; only symbols and strings
    (displaym "key-type" data)
    (or (symbol? data) (string? data)))

  (define (time-type? data)
    ; only strings
    ; with the proper structure
    (string? data))
  (define (octave-type? data)
    ; numbers or symbols and strings
    ; that can become numbers
    (or (symbol? data) (string? data) (number? data)))
  (define (measures-type? data)
    ; only lists of measures
    (or (list? data)))


  (define no-op (lambda (label . args) 
    (displaym "No Generic Handler Found For" label args) ; debugging
    #f))
  ; generics
  (define (get-data cell)
    (eq-get cell 'data))
  (define get
    (make-generic-operator 1))

  (defhandler get 
    (lambda(x) (get-data key)) key?)
  (defhandler get 
    (lambda(x) (get-data time)) time?)
  (defhandler get 
    (lambda(x) (get-data octave)) octave?)
  (defhandler get 
    (lambda(x) (get-data measures)) measures?)
  (defhandler get 
    (lambda(x)
      (no-op "Get" x)) default-object?)


  (define (coerce type value)
    value ; TODO -- this
  )
  (define (set-data cell type value)
    (let  (
            (coerced-val (coerce type value))
          )
          (displaym "set-data cell" cell)
          (displaym "set-data type" type)
          (displaym "set-data coerced" coerced-val)
          (if (not (eqv? #f coerced-val))
            (eq-put! cell 'data coerced-val)
            (displaym "Invalid Value for " type value))))
  
  (define set
    (make-generic-operator 2))
  (defhandler set 
    (lambda(type val) 
      (set-data key type val)) key? key-type?)
  (defhandler set 
    (lambda(type val) 
      (set-data time type val)) time? time-type?)
  (defhandler set 
    (lambda(type val) 
      (set-data octave type val)) octave? octave-type?)
  (defhandler set 
    (lambda(type val) 
      (set-data measures type val)) measures? measures-type?)
  (defhandler set 
    (lambda(type val)
      (no-op "Set" type val)) any? default-object?)


  ; method dispatch
  (define (method-dispatch tag . args)
    (cond 
         ((eq? tag 'get) (apply get args))
         ((eq? tag 'set) (apply set args))
         ; ((eq? tag 'add) (apply add args))
         (else (displaym "ERROR: \n\t Method Not Found" tag))
    )
  )


  (set 'key key-sig)
  ; (displaym "Before" (get 'time))
  (set 'time time-sig)
  ; (displaym "After" (get 'time))
  ; (octave:update key)
  ; (time:update time)
  method-dispatch
)