(define-module (rational-arithmetic)
    #:use-module (table-abstraction)
    #:export     (make-rational))

(define attach-tag cons)
(define numerator car)
(define denominator cdr)

(define (make-rational a b)
    (attach-tag `rational (cons a b)))

(define (+rat a b)
    (make-rational (+ (* (numerator a) (denominator b))
                      (* (numerator b) (denominator a)))
                   (* (denominator a) (denominator b))))

(define (-rat a b)
   (make-rational (- (* (numerator a) (denominator b))
                     (* (numerator b) (denominator a)))
                  (* (denominator a) (denominator b))))

(define (*rat a b)
    (make-rational (* (numerator a) (numerator b))
                   (* (denominator a) (denominator b))))

(define (/rat a b)
    (make-rational (* (numerator a) (denominator b))
                   (* (denominator a) (numerator b))))

(define (rational-init)
    (put (cons `add `rational) +rat)
    (put (cons `sub `rational) -rat)
    (put (cons `mul `rational) *rat)
    (put (cons `div `rational) /rat))

(rational-init)
