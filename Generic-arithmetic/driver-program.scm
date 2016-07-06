(use-modules (complex-arithmetic)
             (rational-arithmetic)
             (number-arithmetic)
             (polynomial-arithmetic)
             (generic-operators))


;; Driver program
(define a (make-complex (make-rect 2 1)))
(define b (make-complex (make-rect 23 12)))

(display (add a b))
(newline)

(define a (make-rational 2 4))
(define b (make-rational 2 3))

(display (div a b))
(newline)

(define a (make-number 12))
(define b (make-number 5))
(define c (make-number 0))

(display (mul a b))
(newline)

(define i (make-poly (cons `x (list (cons a a)))))
(display (div i i))
(newline)
