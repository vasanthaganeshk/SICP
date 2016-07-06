(define-module (wire)
  #:export (make-wire
	    get-signal
	    set-signal!
	    add-action-proc!))

(define (make-wire)
  (let ([signal 0]
	[action-procs `()])

    (define (set-signal! input)
      (set-signal! signal input))

    (define (accept-action-proc! proc)
      (set! action-procs (cons proc action-procs))
      (proc))

    (define (dispatch msg)
      (cond ((eq? msg `get-signal) signal)
	    ((eq? msg `set-signal!) set-signal!)
	    ((eq? msg `add-action-proc!) accept-action-proc!)
	    (else "ERROR: Bad message to Dispatch")))))


(define (get-signal wire)
  (wire `get-signal))

(define (set-signal! wire new-val)
  ((wire `set-signal!) new-val))

(define (add-action-proc! wire proc)
  ((wire `add-action-proc!) proc))

