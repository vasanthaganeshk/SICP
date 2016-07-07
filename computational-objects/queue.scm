(define-module (queue)
  #:export (make-queue
	    empty-queue?
	    insert-queue!
	    remove-queue!
	    front-queue))

(define (make-queue)
  (cons `() `()))

(define (empty-queue? queue)
  (null? (car queue)))

(define (insert-queue! queue obj)
  (let ([elem (cons obj `())])
    (cond ((empty-queue? queue)
	   (set-car! queue elem)
	   (set-cdr! queue elem))
	  (else (set-cdr! (cdr queue) elem)
		(set-cdr! queue elem)))))

(define (front-queue queue)
  (cond ((empty-queue? queue)
	 (error "No element in the queue"))
	(caar queue)))

(define (remove-queue! queue)
  (cond ((empty-queue? queue)
	 (error "Cannot Remove from an empty queue"))
	(else (set-car! queue (cdr (car queue))))))
