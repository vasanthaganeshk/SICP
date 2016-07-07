(define-module (agenda)
  #:use-module (queue))

;; Related to each time segment in an agenda

(define (make-segment time queue)
  (cons time queue))

(define (first segments)
  (car segments))

(define (rest segments)
  (cdr segments))

;; Related to agenda

(define (make-agenda)
  (cons 0 `()))

(define (current-time agenda)
  (car agenda))

(define (segments agenda)
  (cdr agenda))

(define (empty-agenda? agenda)
  (null? (segments agenda)))

(define (set-current-time! agenda time)
  (set-car! agenda time))

(define (pop-first-item! agenda)
  (let ([first-item (first (segments agenda))])
    (set-current-time! agenda (car first-item))
    (set-cdr! (first agenda) (rest (segments agenda)))
    first-item))

(define (add-to-agenda! time action agenda)
  (let ([new-seg (make-segment time (insert-queue! (make-queue) action))])
    (cond ((null? (cdr agenda))
	   (set-cdr! (car agenda) new-seg))
	  ((eq? time (caar agenda))
	   (insert-queue! (cdr (first agenda)) action))
	  ((< time (cadr agenda))
	   (set-cdr! (car agenda) new-seg))
	  (else (add-to-agenda! time action (rest agenda))))))
