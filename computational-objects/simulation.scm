(define-module (simulation)
  #:use-module (wire)
  #:use-module (agenda)
  #:export (probe))
(define (probe name wire-obj)
  (format #t "~a/nCurrent time: ~a/nNew value: ~a"
	  name
	  (get-current-time agenda)
	  (get-signal wire-obj)))
