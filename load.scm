; Load file


;load all the necessary files for different operations
(load-option 'regular-expression)
(load "ghelper.scm")
(load "generics.scm")
(load "amb.scm")
(load "util")
(load "propagator/load")
(load "propagator/ui")

; load all the logic files for the enviornment
(load "logic/regexp.scm")
(load "logic/validation.scm")
(load "logic/duration.scm")
(load "logic/pitch.scm")
(load "logic/cell-ops.scm")
(load "logic/note.scm")
(load "logic/chord.scm")
(load "logic/interval.scm")
(load "logic/operation.scm")
(load "logic/measures.scm")
(load "logic/piece.scm")

