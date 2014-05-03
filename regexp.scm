(define (rexp-letter) 
  (rexp-alternatives "a" "b" "c" "d" "e" "f" "g" "A" "B" "C" "D" "E" "F" "G"))


(define 
  (rexp-sharp-or-flat)
   (rexp* (rexp-alternatives "b" "#")))


(define (rexp-octave) 
  (rexp* 
    (rexp-alternatives "0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))

(define (rexp-pitch) 
  (rexp-sequence 
    (rexp-string-start) 
    (rexp-letter) 
    (rexp-sharp-or-flat) 
    (rexp-octave) 
    (rexp-string-end)))

