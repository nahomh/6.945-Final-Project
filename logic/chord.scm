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
 (eq-put! chord 'type 'chord)
 (eq-put! chord 'notes '())
 chord)

;Check if notes is actually a list of notes
(define (create-chord . notes)
  (cond 
    ((< (length notes) 3)
      "Must have three or more notes in a chord")
    ((not (valid-notes? notes))
      "The set of notes passed in aren't valid")
    (else
      (let ((new-chord (empty-chord)))
        (eq-put! new-chord 'notes notes)
      new-chord))))

(define (print-chord chord)
  (for-each
   (lambda (note)
     (print-note note))
   (eq-get chord 'notes)))

(define (inversion chord order)
  (let* ((new-chord (empty-chord)) (notes (sort-notes (eq-get chord 'notes))) (last-note (list-ref notes (- (length notes) 1))))
    (eq-put! 
      new-chord
      'notes
      (append (list-head notes (- order 1)) (list (increase-octave (list-ref notes (- order 1)) last-note)) (list-tail notes order)))
  new-chord))


