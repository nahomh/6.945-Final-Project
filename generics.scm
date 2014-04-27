;Creating the generic represetnation for musical notes. 


;Constructiong Notes 

; (define (notes:create type . notes)
; 	(generic:notes-construct type notes))

; (define generic:notes-construct
; 	(make-generic-operator 2 'create-notes))

; (defhandler generic:sequence-construct
; 	(lambda (type notes) notes)
; 	(is-exactly list?) list?)