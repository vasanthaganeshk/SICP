(define-module (number-arithmetic)
    #:use-module (table-abstraction)
    #:export (make-number))

(define attach-tag cons)

(define (make-number a)
    (attach-tag `number a))
(define (+number a b)
    (make-number (+ a b)))

(define (-number a b)
    (make-number (- a b)))

(define (*number a b)
    (make-number (* a b)))

(define (/number a b)
    (make-number (/ a b)))

(define (number-init)
    (put (cons `add `number) +number)
    (put (cons `sub `number) -number)
    (put (cons `mul `number) *number)
    (put (cons `div `number) /number))

(number-init)
