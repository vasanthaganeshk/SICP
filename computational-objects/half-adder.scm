;;;; Half adder

(define input-1 (make-wire))
(define input-2 (make-wire))
(define out-sum (make-wire))
(define out-carry (make-wire))

(define (half-adder input-1 input-2 out-sum out-carry)
  (let ([int-wire-grey (make-wire)]
	[int-wire-black (make-wire)])
    (or-gate input-1 input-2 int-wire-grey)
    (and-gate input-1 input-2 out-carry)
    (not-gate out-carry int-wire-black)
    (and-gate int-wire-grey int-wire-black out-sum)))
