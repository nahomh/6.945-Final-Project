; Logic for chords

; We define the logic for the representation of chords here. 

; Spefication Examples:

; (piece (add-chord A#2 B Cb))
; (piece (add (‘chord a#2 b cb)))
; (piece add chord a#2 b cd) → want
; (chord c e g) → (chord c4 e4 g4 ¼) → TODO:need to figure out naming (major triad vs M3-m3)
; [a..gA..G] → one of A through G
; *[b#] → zero or more flats (b) or sharps (#)
; ?[0...inf] → zero or one numbers from zero to infinity



(define (empty-chord)
 (define-cell chord)
 (eq-put! chord 'type 'notes)
 (eq-put! chord 'data '())
 chord)

;Check if notes is actually a list of notes
(define (create-chord . notes)
  (if (< (length notes) 3)
    "Must have three or more notes in a chord"
    (let ((new-chord (empty-chord)))
      (eq-put! new-chord 'data notes))
    new-chord))


(define (first-inversion chord)
  (let ((notes (sort-notes (eq-get chord 'data))))
    (eq-put! 
      chord
      notes
      'data
      (cons (add (car notes) 1) (cdr notes))))
  chord)



