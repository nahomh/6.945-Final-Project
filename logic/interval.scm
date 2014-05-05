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

(interval-associations)


(define (interval start-note end-note)
	(let (
		(start-note-cent (get-cent start-note))
		(end-note-cent (get-cent end-note))
		)
		(let (
			(semi-tone-difference (/ (- start-note-cent end-note-cent) 100))
			)
		(displaym "semi" semi-tone-difference)
		(if (> (abs semi-tone-difference) 12)
			(hash-table/get interval-names (modulo (abs semi-tone-difference) 12) 0)
			(hash-table/get interval-names (abs semi-tone-difference) 0)
		)
	)
)
	)