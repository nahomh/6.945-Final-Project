;;; -*- Mode:Scheme -*- 
(define (displaym label . things) 
  (define (internal)
    (newline)
    (display (string label ": "))
    (display things)
    (newline)
  )
  (if #t (display "") (internal))
)

(declare (usual-integrations))

;;; Self-evaluating entities

(define (self-evaluating? exp)
  (or (number? exp)
      (eq? exp #t)
      (eq? exp #f)
      (string? exp)))	; Our prompt (viz., "EVAL==> ") is a string.

;;; Variables

(define (variable? exp) (symbol? exp))

(define (same-variable? var1 var2) (eq? var1 var2))  ;; Nice abstraction

;;; Special forms (in general)

(define (tagged-list? exp tag)
  (and (pair? exp)
       (eq? (car exp) tag)))

;;; Quotations

(define (quoted? exp) (tagged-list? exp 'quote))

(define (text-of-quotation quot) (cadr quot))

;;; Assignment--- SET!

(define (assignment? exp) (tagged-list? exp 'set!))
(define (permanent-assignment? exp) (tagged-list? exp 'set!!))

(define (assignment-variable assn) (cadr  assn))
(define (assignment-value    assn) (caddr assn))

;;; Definitions

(define (definition? exp) (tagged-list? exp 'define))

(define (definition-variable defn)
  (if (variable? (cadr defn))			;;   (DEFINE  foo      ...)
      (cadr  defn)
      (caadr defn)))				;;   (DEFINE (foo ...) ...)

(define (definition-value defn)
  (if (variable? (cadr defn))			;;   (DEFINE  foo        ...)
      (caddr defn)
      (cons 'lambda				;;   (DEFINE (foo p...) b...)
            (cons (cdadr defn)			;; = (DEFINE  foo
                  (cddr  defn)))))		;;     (LAMBDA (p...) b...))

;;; LAMBDA expressions

(define (lambda? exp) (tagged-list? exp 'lambda))
(define (lambda-parameters lambda-exp) (cadr lambda-exp))
(define (lambda-body lambda-exp)
  (let ((full-body (cddr lambda-exp)))
    (sequence->begin full-body)))


(define declaration? pair?)

(define (parameter-name var-decl)
  (if (pair? var-decl)
      (car var-decl)
      var-decl))

(define (lazy? var-decl)
  (and (pair? var-decl)
       (memq 'lazy (cdr var-decl))
       (not (memq 'memo (cdr var-decl)))))

(define (lazy-memo? var-decl)
  (and (pair? var-decl)
       (memq 'lazy (cdr var-decl))
       (memq 'memo (cdr var-decl))))

(define (sequence->begin seq)
  (cond ((null? seq) seq)
	((null? (cdr seq)) (car seq))
	((begin? (car seq)) seq)
	(else (make-begin seq))))

(define (make-begin exp) (cons 'begin exp))

;;; If conditionals

(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))

(define (if-consequent exp) (caddr exp))

(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'the-unspecified-value))

(define (make-if pred conseq alternative)
  (list 'IF pred conseq alternative))


;;; COND Conditionals

(define (cond? exp) (tagged-list? exp 'cond))

(define (clauses cndl) (cdr cndl))
(define (no-clauses? clauses) (null? clauses))
(define (first-clause clauses) (car clauses))
(define (rest-clauses clauses) (cdr clauses))
(define (else-clause? clause) (eq? (predicate clause) 'else))

(define (predicate clause) (car clause))

(define (actions clause)
  (sequence->begin (cdr clause)))

(define (cond->if cond-exp)
  (define (expand clauses)
    (cond ((no-clauses? clauses)
	   (list 'error "COND: no values matched"))
	  ((else-clause? (car clauses))
	   (if (no-clauses? (cdr clauses))
	       (actions (car clauses))
	       (error "else clause isn't last -- INTERP" exp)))
	  (else
	   (make-if (predicate (car clauses))
		    (actions (car clauses))
		    (expand (cdr clauses))))))
  (expand (clauses cond-exp)))


;;; BEGIN expressions (a.k.a. sequences)

(define (begin? exp) (tagged-list? exp 'begin))
(define (begin-actions begin-exp) (cdr begin-exp))

(define (last-exp? seq) (null? (cdr seq)))
(define (first-exp seq) (car seq))
(define (rest-exps seq) (cdr seq))
(define no-more-exps? null?)		; for non-tail-recursive vers.

;;; LET expressions

(define (let? exp) (tagged-list? exp 'let))
(define (let-bound-variables let-exp)
  (map car (cadr let-exp)))
(define (let-values let-exp) (map cadr (cadr let-exp)))
(define (let-body let-exp) (sequence->begin (cddr let-exp)))
(define (let->combination let-exp)
  (let ((names (let-bound-variables let-exp))
	(values (let-values let-exp))
	(body (let-body let-exp)))
    (cons (list 'LAMBDA names body)
	  values)))

;;; INFIX expressions
; best way to do encapsulation?
; tell me about scheme environments
;; operator defs
(define (infix-get-parens exp i first-paren open-parens)
  ; (displaym "infix-get-exp" exp)
  ; (displaym "infix-get-len" (string-length exp))
  ; (displaym "infix-get-i" i)
  ; (displaym "infix-get-fp" first-paren)
  ; (displaym "infix-get-op" open-parens)
  (cond
    ((>= i (string-length exp))
      -1)
    ((char=? (string-ref exp i) #\()
      (infix-get-parens exp (+ i 1) (if (eq? first-paren -1) i first-paren) (+ open-parens 1)))
    ((char=? (string-ref exp i) #\))
      (if (eq? open-parens 1)
        (list first-paren i)
        (infix-get-parens exp (+ i 1) first-paren (- open-parens 1))))
    (else
      (infix-get-parens exp (+ i 1) first-paren open-parens))))

;; presidence rules
(define p:hash-table (make-equal-hash-table))
(define (p:hash-table-put key value)
 (hash-table/put! p:hash-table key value))
(define (p:hash-table-get key)
 (hash-table/get p:hash-table key #f))
(p:hash-table-put "+" 1)
(p:hash-table-put "-" 1)
(p:hash-table-put "*" 2)
(p:hash-table-put "/" 2)
(p:hash-table-put "^" 3)
(p:hash-table-put "sqrt" 4)

(define (first-higher? operator-str last-operator)
  (if (not (p:hash-table-get last-operator)) #f
    (> (p:hash-table-get operator-str) 
    (p:hash-table-get last-operator))
  )
)

(define (compose-p replace1 parens replace2)
  (displaym "compose-p")
  (displaym "compose-p" replace1)
  (list beg parens end)
)


(define (get-op-forward infix-str)
  (displaym "get-op-forward")
  (define cur-min (string-length infix-str))
  (define op "")
  (let (
    (addition (string-search-forward "+" infix-str))
    (subtraction (string-search-forward "-" infix-str))
    (multiplication (string-search-forward "*" infix-str))
    (division (string-search-forward "/" infix-str))
    (exponentiation (string-search-forward "^" infix-str))
    (squareroot (string-search-forward "sqrt" infix-str))) 
    (for-each 
      (lambda(x)
        ; (displaym "x" x)
        ; (displaym "cadr x" (cadr x))
        (if (eq? (car x) #f) #f
        (if (< (car x) cur-min)
          (and (set! cur-min (car x)) (set! op (cadr x)))))
        ; (displaym "op" op)
        ; (displaym "cur-min" cur-min)
      )
      (list (list addition "+") 
            (list subtraction "-")
            (list multiplication "*")
            (list division "/")
            (list exponentiation "^")
            (list squareroot "sqrt"))
    )
    ; (displaym "op" op)
    op
  )
)

(define (get-op-backward infix-str)
  ; (displaym "get-op-backward")
  (define cur-max 0)
  (define op "")
  (let (
    (addition (string-search-forward "+" infix-str))
    (subtraction (string-search-forward "-" infix-str))
    (multiplication (string-search-forward "*" infix-str))
    (division (string-search-forward "/" infix-str))
    (exponentiation (string-search-forward "^" infix-str))
    (squareroot (string-search-forward "sqrt" infix-str))) 
    (for-each 
      (lambda(x)
        ; (displaym "x" x)
        ; (displaym "cadr x" (cadr x))
        (if (eq? (car x) #f) #f
        (if (>= (car x) cur-max)
          (and (set! cur-max (car x)) (set! op (cadr x)))))
        ; (displaym "op" op)
        ; (displaym "cur-max" cur-max)
      )
      (list (list addition "+") 
            (list subtraction "-")
            (list multiplication "*")
            (list division "/")
            (list exponentiation "^")
            (list squareroot "sqrt"))
    )
    ; (displaym "op" op)
    op
  )
)

(define (compose-parens beg parens end)
  (displaym "compose")
  (displaym "compose-paren" parens)
  (displaym "get-op-b" (get-op-backward beg))
  (displaym "get-op-f" (get-op-forward end))
  (displaym "end" end)
  (displaym "beg" beg)
  (displaym "truth" (and (equal? "" end) (equal? "" beg)))
  (cond ((and (equal? "" end) (equal? "" beg)) parens)
        ((equal? "" end) (infix-str->expr beg parens))
        ((equal? "" beg) (infix-str->expr end parens))
        (else 
  (let (
      (first-op (get-op-backward beg))
      (end-op (get-op-forward end))
    )
      (displaym "higher" (first-higher? first-op end-op))
      (if (first-higher? first-op end-op)
        (compose-parens "" (infix-str->expr beg parens) end)
        (compose-parens beg (infix-str->expr end parens) "")
      )
    )
  )
  )
)

(define (recurse-into infix-str symbol index parenl)
  (list symbol (infix-str->expr (string-head infix-str index) parenl)
                 (infix-str->expr (string-tail infix-str (+ index 1)) parenl))
)

(define (infix-str->expr infix-str #!optional parenl)
  (let ((number (string->number infix-str))
        (parens (infix-get-parens infix-str 0 -1 0))
        (addition (string-search-forward "+" infix-str))
        (subtraction (string-search-forward "-" infix-str))
        (multiplication (string-search-forward "*" infix-str))
        (division (string-search-forward "/" infix-str))
        (exponentiation (string-search-forward "^" infix-str))
        (squareroot (string-search-forward "sqrt" infix-str))) 
    (displaym "infix-str" infix-str)
    (displaym "parenl" parenl)
    ; (displaym parens)
    (cond
      ((not (eq? number #f)) number)
      ((list? parens)
        (displaym "parens" parens)
        (let* (
          (i (car parens))
          (j (cadr parens))
          (beg (string-head infix-str i))
          (end (string-tail infix-str (+ j 1)))
          (paren-e (infix-str->expr (substring infix-str (+ i 1) j)))
        )
        (displaym "beginning" beg)
        (displaym "end" end)
            (compose-parens 
                beg
                paren-e
                end
              )
            )
          )
      
      (addition (recurse-into infix-str '+ addition parenl))
      (subtraction (recurse-into infix-str '- subtraction parenl))
      (multiplication (recurse-into infix-str '* multiplication parenl))
      (division (recurse-into infix-str '/ division parenl))
      (exponentiation (recurse-into infix-str 'expt exponentiation parenl))
      (squareroot
        (list 'sqrt (infix-str->expr (string-tail infix-str (+ squareroot 4)) parenl)))
      (else
        (displaym "string->symbol" (string->symbol infix-str))
        (displaym "string->symbol" infix-str)
        (displaym "string->symbol-p" parenl)
        (if (not (eq? #!default parenl)) parenl
        (string->symbol infix-str))
        ))))

(define (infix? exp) (tagged-list? exp 'infix))
(define (infix->val infix-exp)
  (display (infix-str->expr (cadr infix-exp)))
  (infix-str->expr (cadr infix-exp)))
;;; Procedure applications -- NO-ARGS? and LAST-OPERAND? added

(define (application? exp)
  (pair? exp))

(define (no-args? exp)				;; Added for tail recursion
  (and (pair? exp)
       (null? (cdr exp))))

(define (args-application? exp)			;; Changed from 5.2.1
  (and (pair? exp)
       (not (null? (cdr exp)))))


(define (operator app) (car app))
(define (operands app) (cdr app))

(define (last-operand? args)			;; Added for tail recursion
  (null? (cdr args)))

(define (no-operands? args) (null? args))
(define (first-operand args) (car args))
(define (rest-operands args) (cdr args))

;;; Another special form that will be needed later.

(define (amb? exp)
  (and (pair? exp) (eq? (car exp) 'amb)))

(define (amb-alternatives exp) (cdr exp))

