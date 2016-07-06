(define-module (agenda)
  #:use-module (queue)
  #:export (make-agenda
	    current-time
	    empty-agenda?
	    add-to-agenda!
	    first-item
	    remove-first-item))
(define (make-time-segment time 

(define (make-agenda)
  (cons 0 null))

(define (current-time agenda)
  (car agenda))

(define (empty-agenda? agenda)
  (null? (cdr agenda)))

(define (add-to-agenda! time proc agenda)
  (cond ((
