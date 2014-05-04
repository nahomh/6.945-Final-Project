(define get-pitch
    (make-generic-operator 1))

(defhandler get-pitch 
  str:get-pitch string?)
(defhandler get-pitch 
  (lambda(cell)
    (eq-get cell 'pitch)) cell?)

; get the accent
(define get-accent
    (make-generic-operator 1))

(defhandler get-accent 
  str:get-accent string?)
(defhandler get-accent 
  (lambda(cell)
    (eq-get cell 'accent)) cell?)

; get the octave
(define get-octave
  (make-generic-operator 1))

(defhandler get-octave 
  str:get-octave string?)
(defhandler get-octave 
  (lambda(cell)
    (eq-get cell 'octave)) cell?)

; get the duration
(define get-duration
  (make-generic-operator 1))

(defhandler get-duration 
  (lambda(cell)
    (eq-get cell 'duration)) cell?)
