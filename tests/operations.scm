; Test the transpose and other operations
(define operations-test-suite (test-suite-wrapper "Operations Suite"))
(define opertests (test operations-test-suite))

;;Todo
; (opertests 
;   (equal? (piece1 'get 'time) "4/4")
;   "Piece Time Signature Defaults To 4/4"
; )