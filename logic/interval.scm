;representation for intervals in music


;intervals

;create a new interval with the starting note, ending note.
(define (interval #!optional start-note end-note)
	(define-cell start-note)
	(eq-put start-note 'type 'note)
	(eq-put start-note 'data ')
