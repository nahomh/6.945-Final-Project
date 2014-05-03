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

(define (new-piece #!optional key time)
  ; creates a new piece in the key of "key" with 
  ; the time signature given by "time"
  (define-cell key)
  (eq-put! key 'type 'key)
  (eq-put! key 'data 'c)

  ; key handle string, symbol
  (define-cell time)
  (eq-put! time 'type 'time)
  (eq-put! time 'data '4/4)
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

  ; type checkers
  (define (key? symb)
    (eq? symb 'key))
  (define (time? symb)
    (eq? symb 'time))
  (define (octave? symb)
    (eq? symb 'octave))
  (define (measures? symb)
    (eq? symb 'measures))


  (define no-op (lambda (a) 
    (displaym "No Generic Handler Found For" a) ; debugging
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
  (defhandler get no-op default-object?)


  ; method dispatch
  (define (method-dispatch tag . args)
    (cond 
         ((eq? tag 'get) (apply get args))

         ; ((eq? tag 'get-measures) key)
         ; ((eq? tag 'set-key) key)
         ; ((eq? tag 'set-octave) key)
         ; ((eq? tag 'set-time) key)
         ; ((eq? tag 'set-measures) key)
         ; ((eq? tag 'add) key)
         ; ((eq? tag 'repeat) key)
         (else (displaym "ERROR: \n\t Method Not Found" tag))
    )
  )

  ; ; generic dispatch

  ; ; key operations
  ; (define (update-key! key)
  ;   ; update the key signature with (string) key
  ;   ; validate first
  ;   ; (is-valid-pitch)
  ;   (set! key (string->symbol key))
  ; )
  ; (define key:update!
  ;   (make-generic-operator 1))

  ; (defhandler key:update! 
  ;   update-key! string?)
  ; (defhandler key:update! 
  ;   (lambda (x) (update-key! (symbol->string x))) symbol?)
  ; (defhandler key:update! no-op default-object?)

  ; ; octave operations
  ; ; taken from the key
  ; (define octave:update
  ;   (make-generic-operator 1))
  ; (defhandler octave:update (lambda(x) (set! octave-sig (string->symbol x))) string?)
  ; (defhandler octave:update (lambda(x) (set! octave-sig x)) symbol?)
  ; (defhandler octave:update no-op default-object?)


  ; ; time signature operations
  ; ; "1/4" '1/4 
  ; (define time:update
  ;   (make-generic-operator 1))
  ; (defhandler time:update (lambda(x) (set! time-sig (string->symbol x))) string?)
  ; (defhandler time:update (lambda(x) (set! time-sig x)) symbol?)
  ; (defhandler time:update no-op default-object?)


  ; (key:update! key)
  ; (octave:update key)
  ; (time:update time)
  method-dispatch
)