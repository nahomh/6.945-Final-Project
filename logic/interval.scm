;representation for intervals in music


;intervals

;create a new interval with the starting note, ending note.

;make the associations

(define interval-names
	(make-eq-hash-table))

(define (interval-associations)
	(hash-table/put! interval-names 0 "P1")
	(hash-table/put! interval-names 1 "m2")
	(hash-table/put! interval-names 2 "M2")
	(hash-table/put! interval-names 3 "m3")
	(hash-table/put! interval-names 4 "M3")
	(hash-table/put! interval-names 5 "P4")
	(hash-table/put! interval-names 7 "P5")
	(hash-table/put! interval-names 8 "m6")
	(hash-table/put! interval-names 9 "M6")
	(hash-table/put! interval-names 10 "m7")
	(hash-table/put! interval-names 11 "M7")
	(hash-table/put! interval-names 12 "P8")
	)
	
	






(define (interval #!optional start-note end-note)
	(define-cell interval)



	(eq-put start-note 'type 'note)
	(eq-put start-note 'data ')
