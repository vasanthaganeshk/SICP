(define-module (inverter)
  #:use-module (wire)
  #:export (make-inverter))

(define (make-inverter input output)
  (define (invert-in)
    (let ([new-output (logical-not (get-signal input))])
      (after-delay inverter-delay
		   (lambda () (set-signal! output new-output)))))
  (add-action-proc! input invert-in))

(define (logical-not input)
  (cond ((eq? input 0) 1)
	((eq? input 1) 0)
	(else "ERROR: Cannot perform logical-not on the object")))
