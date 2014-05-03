; Load file


;load all the necessary files for different operations
(load "ghelper.scm")
(load "generics.scm")
(load "amb.scm")
(load "util")
(load-option 'regular-expression)
(load "propagator/load")
(load "propagator/ui")
; load all the logic files for the enviornment
(cd "./logic")
(load "chord.scm")
(load "internal.scm")
(load "note.scm")
(load "operation.scm")
(load "regexp.scm")
(cd "..")


; (load "tests.scm")
