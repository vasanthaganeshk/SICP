(define-module (polynomial-arithmetic)
    #:use-module (table-abstraction)
    #:use-module (generic-operators)
    #:export     (make-poly))

(define contents cdr)
(define first-term car)
(define degree car)
(define coeff cdr)
(define make-term cons)
(define attach-tag cons)

(define (make-poly obj)
    (cons `poly obj))

(define (+polynomial a b)
    (cond ((null? a) b)
          ((null? b) a)
          ((> (degree (first-term a)) (degree (first-term b))) (cons (first-term a) (+polynomial (cdr a) b)))
          ((< (degree (first-term a)) (degree (first-term b))) (cons (first-term b) (+polynomial a (cdr b))))
          ((eq? (degree (first-term a)) (degree (first-term b))) (cons (make-term (degree (first-term a)) (add (coeff (first-term a)) (coeff (first-term b))))
                                                                       (+polynomial (contents a) (contents b))))))

(define (-polynomial a b)
    (cond ((null? a) b)
          ((null? b) a)
          ((> (degree (first-term a)) (degree (first-term b))) (cons (first-term a) (-polynomial (cdr a) b)))
          ((< (degree (first-term a)) (degree (first-term b))) (cons (first-term b) (-polynomial a (cdr b))))
          ((eq? (degree (first-term a)) (degree (first-term b))) (cons (make-term (degree (first-term a)) (sub (coeff (first-term a)) (coeff (first-term b))))
                                                                       (-polynomial (contents a) (contents b))))))

(define (+p a b)
   (if (eq? (first-term a) (first-term b))
       (+polynomial (contents a) (contents b))
       (error "ERROR: Both objects are not of the same term thus addition cannot be performed")))

(define (-p a b)
    (if (eq? (first-term a) (first-term b))
        (-polynomial (contents a) (contents b))
        (error "ERROR: Both objects are not of the same term thus subtraction cannot be performed")))

(define (*monomial x y)
    (cons (add (degree x) (degree y))
          (mul (coeff x) (coeff y))))

(define (*polynomial a b)
    (cond ((null? a) `())
          (else (+polynomial (map (lambda (x) (*monomial (car a) x)) b)
                             (*polynomial (cdr a) b)))))

(define (*p a b)
    (if (eq? (first-term a) (first-term b))
        (*polynomial (contents a) (contents b))
        (error "ERROR: Both objects are not of the same term thus multiplication cannot be performed")))

(define (/monomial x y)
    (cons (sub (degree x) (degree y))
          (mul (coeff x) (coeff y))))

(define (/polynomial quotient dividend divisor)
    (let ([deg-dividend (degree (first-term dividend))]
          [deg-divisor (degree (first-term divisor))])
        (cond ((eq? (cons (make-number 0) (make-number 0)) dividend) quotient)
              ((< deg-dividend deg-divisor) #f)
              ((>= deg-dividend deg-divisor)
               (let ([quo-term (/monomial (first-term dividend) (first-term divisor))])
                 (/polynomial (cons quo-term quotient)
                              (-polynomial dividend (*polynomial quo-term divisor))
                              divisor))))))

(define (/p dividend divisor)
  (if (eq? (first-term dividend) (first-term divisor))
      (/polynomial `() dividend divisor)
      (error "The polynomials to be dividedd are not of the same term")))


(define (poly-init)
    (define (+poly a b) (attach-tag `poly (+p a b)))
    (define (-poly a b) (attach-tag `poly (-p a b)))
    (define (*poly a b) (attach-tag `poly (*p a b)))
    (define (/poly a b) (attach-tag `poly (/p a b)))

    (put (cons `add `poly) +poly)
    (put (cons `sub `poly) -poly)
    (put (cons `mul `poly) *poly)
    (put (cons `div `poly) /poly))

(poly-init)
