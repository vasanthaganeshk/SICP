(define-module (table-abstraction)
    #:export (get
              put))

;; Table Abstraction
(define dict-proc (make-hash-table))
(define (put key value)
    (hash-create-handle! dict-proc key value))
(define (get key)
    (hash-get-handle dict-proc key))
