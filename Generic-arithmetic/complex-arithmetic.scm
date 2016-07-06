(define-module (complex-arithmetic)
     #:use-module (table-abstraction)
     #:export     (make-rect
                   make-polar
                   make-complex))

;; Tags
(define attach-tag cons)
(define type car)
(define contents cdr)

;; Complex numbers constructor for rectangular and polar

(define (make-rect obj-x obj-y)
    (attach-tag `rect (cons obj-x obj-y)))
(define (make-polar obj-x obj-y)
    (attach-tag `polar (cons obj-x obj-y)))
(define (make-complex obj)
    (attach-tag `complex obj))

;; complex numbers rect selectors
(define (complex-init-rect)
    (define re-rect car)
    (define im-rect cdr)
    (define (mag-rect a)
        (let ([x (re-rect a)]
              [y (im-rect a)]
              [square (lambda (a) (* a a))])
         (sqrt (+ (square x) (square y)))))
    (define (ang-rect a)
        (let ([x (re-rect a)]
              [y (im-rect a)])
             (atan (/ x y))))
    (put (cons `re `rect) re-rect)
    (put (cons `im `rect) im-rect)
    (put (cons `mag `rect) mag-rect)
    (put (cons `ang `rect) ang-rect))

;; complex numbers polar selectors
(define (complex-init-polar)
    (define mag-polar car)
    (define ang-polar cdr)
    (define (re-polar a)
        (let ([r (mag-polar a)]
              [theta (ang-polar a)])
         (* r (cos theta))))
    (define (im-polar a)
        (let ([r (mag-polar a)]
              [theta (ang-polar a)])
         (* r (sin theta))))
    (put (cons `re `polar) re-polar)
    (put (cons `im `polar) im-polar)
    (put (cons `mag `polar) mag-polar)
    (put (cons `ang `polar) ang-polar))

(define (operate op obj)
    (let ([proc (contents (get (cons op (type obj))))])
        (if (not (null? proc)) (proc (contents obj))
            (error "ERROR: operation cannot be performed on object"))))

(define (re obj)
    (operate `re obj))
(define (im obj)
    (operate `im obj))
(define (mag obj)
    (operate `mag obj))
(define (ang obj)
    (operate `ang obj))

(define (+c obj-x obj-y)
    (make-rect (+ (re obj-x) (re obj-y))
               (+ (im obj-x) (im obj-y))))
(define (-c obj-x obj-y)
    (make-rect (- (re obj-x) (re obj-y))
               (- (im obj-x) (im obj-y))))
(define (*c obj-x obj-y)
    (make-polar (* (mag obj-x) (mag obj-y))
                (+ (ang obj-x) (ang obj-y))))
(define (/c obj-x obj-y)
    (make-polar (* (mag obj-x) (mag obj-y))
                (+ (ang obj-x) (ang obj-y))))

;; Generic selectors
(define (complex-init)
    (define (+complex obj-x obj-y)
        (make-complex (+c obj-x obj-y)))
    (define (-complex obj-x obj-y)
        (make-complex (-c obj-x obj-y)))
    (define (*complex obj-x obj-y)
        (make-complex (*c obj-x obj-y)))
    (define (/complex obj-x obj-y)
        (make-complex (/c obj-x obj-y)))

    (put (cons `add `complex) +complex)
    (put (cons `sub `complex) -complex)
    (put (cons `mul `complex) *complex)
    (put (cons `div `complex) /complex))

;; Driver program
(complex-init-rect)
(complex-init-polar)
(complex-init)
