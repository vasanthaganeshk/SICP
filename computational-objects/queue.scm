(define-module (queue)
  #:export (make-queue
	    empty-queue?
	    insert-queue!
	    remove-queue!
	    front-queue))

(define (make-queue)
  (cons `() `()))

(define (empty-queue? queue)
  (null? (front queue)))

(define (insert-queue! obj queue)
  (let ([elem (cons obj `())])
    (cond ((empty-queue? queue)
	   (set-car! queue elem)
	   (set-cdr! queue elem))
	  (else (set-cdr! (cdr queue) elem)
		(set-cdr! queue elem)))))

(define (remove-queue! queue)
  (cond ((eq? (length queue) 1)
	 (error "ERROR: Cannot remove element from an empty queue."))
	((eq? (length queue) 2)
	 (set-car! `())
	 (set-cdr! `()))
	(else (set-car! queue (cdr queue)))))

(define (front-queue queue)
  (cond ((empty-queue? queue)
	 (error "ERROR: No element in the queue"))
	(else (caar queue))))
