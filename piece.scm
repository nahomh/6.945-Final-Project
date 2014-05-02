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
; invert
; note
; is-valid-pitch
; is-valid-octave
; is-valid-time-sig
; measure?
; chord?
; interval?
; note?

(define (is-valid-pitch pitch-str)
  ; use regex we developed
)

(define (new-piece #!optional key time)
  ; creates a new piece in the key of "key" with 
  ; the time signature given by "time"
  (define key-sig 'c)
  ; key handle string, symbol
  (define time-sig '4/4)
  ; generic time-sig 
  ; defaults to 4/4
  ; (define time-sig "")
  ; (update-time-sig time)
  ; should handle integer, string, symbol
  (define octave 4)
  (define measures '()) 
  ; assume for now only one time sig
  ; change to tagged list later if multiple time sig
  ; '(
  ;    (4/4 note1 note2 note3 note4)
  ;    (4/4 note1 note2 note3 note4)
  ;    (2/4 note1 note2)
  ;    (3/4 note1 note2)
  ;  )
  ; if want to get measure do list->vector first

  ; method dispatch
  (define (method-dispatch tag . args)
    (cond 
         ((eq? tag 'get-key-sig) key-sig)
         ((eq? tag 'get-time-sig) time-sig)
         ((eq? tag 'get-octave) octave)

         ((eq? tag 'set-key-sig) key-sig)
         ((eq? tag 'set-octave) key-sig)
         ((eq? tag 'set-time-sig) key-sig)
         ((eq? tag 'get-measures) key-sig)
         ((eq? tag 'set-measures) key-sig)
         ((eq? tag 'add) key-sig)
         ((eq? tag 'repeat) key-sig)
         (else (displaym "ERROR: \n\t Method Not Found" tag))
    )
  )

  ; generic dispatch
  (define no-op (lambda (a) #f))

  ; key operations
  (define (update-key key)
    ; update the key signature with (string) key
    ; validate first
    ; (is-valid-pitch)
    (set! key-sig (string->symbol key))
  )
  (define key:update
    (make-generic-operator 1))

  (defhandler key:update 
    update-key string?)
  (defhandler key:update 
    (lambda (x) (update-key (symbol->string x))) symbol?)
  (defhandler key:update no-op default-object?)

  ; octave operations
  ; taken from the key
  (define octave:update
    (make-generic-operator 1))
  (defhandler octave:update (lambda(x) (set! octave-sig (string->symbol x))) string?)
  (defhandler octave:update (lambda(x) (set! octave-sig x)) symbol?)
  (defhandler octave:update no-op default-object?)


  ; time signature operations
  ; "1/4" '1/4 
  (define time-sig:update
    (make-generic-operator 1))
  (defhandler time-sig:update (lambda(x) (set! time-sig-sig (string->symbol x))) string?)
  (defhandler time-sig:update (lambda(x) (set! time-sig-sig x)) symbol?)
  (defhandler time-sig:update no-op default-object?)


  (key:update key)
  ; (octave:update key)
  ; (time-sig:update time)
  method-dispatch
)