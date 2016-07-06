(define front car)
(define rear cdr)

(define (make-queue)
  (cons null null))

(define (empty-queue? queue)
  (null? (front queue)))

(define (add-to-queue! obj queue)
  (cond ((empty-queue? queue)
	 (set-car! queue obj
