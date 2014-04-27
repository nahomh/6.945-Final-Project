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