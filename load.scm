; Load file


; First load all the logic files for the enviornment
(cd "/logic")
(load "chord.scm")
(load "internal.scm")
(load "note.scm")
(load "operation.scm")

;Then load all the necessary files for different operations
(cd "..")
(load "ghelper.scm")
(load "generics.scm")
(load "amb.scm")
(load "tests.scm")
