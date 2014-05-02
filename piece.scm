; Symbolic Representation for Music

; This is the main file for the system allowing the user to
; call the enviornment and began to input musical notes and chords. 
(load "load")

; going to use notes in midi, need one value
(define c0midi 0)
(define semitone 100) ; cents
(define wholetone (* 2 semitone))
; define intervals in terms of semitones


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
         ((eq? tag 'get-key) key-sig)
         ((eq? tag 'dot) (m:dot->string))
         ((eq? tag 'eol) (m:eol->string))
         ((eq? tag 'quote) (m:quote->string (car args)))
         ((eq? tag 'char-from) (m:char-from->string (car args)))
         ((eq? tag 'char-not-from) (m:char-not-from->string (car args)))
         ((eq? tag 'seq) (apply m:seq->string args))
         ((eq? tag 'alt) (apply m:alt->string args))
         ((eq? tag 'back-ref) (apply m:back-ref->string args))
         ((eq? tag 'group) (apply m:group->string args))
         ((eq? tag 'repeat) (apply m:repeat->string args))
         (else (displaym "ERROR: \n\t Method Not Found" tag))
    )
  )

  ; generic dispatch

  method-dispatch
)