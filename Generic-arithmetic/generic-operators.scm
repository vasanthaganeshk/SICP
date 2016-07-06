(define-module (generic-operators)
    #:use-module (table-abstraction)
    #:export     (add
                  sub
                  mul
                  div))

(define attach-tag cons)
(define type car)
(define contents cdr)

(define (operate-general op obj-x obj-y)
  (if (eq? (type obj-x) (type obj-y))
      (let ([proc (contents (get (cons op (type obj-x))))])
          (if (not (null? proc)) (proc (contents obj-x) (contents obj-y))
              (error "ERROR: No such operation is defined")))
      (error "ERROR: The types do not match for the operation to occur")))

      ;; Generic operations
(define (add obj-x obj-y)
  (operate-general 'add obj-x obj-y))

(define (sub obj-x obj-y)
  (operate-general 'sub obj-x obj-y))

(define (mul obj-x obj-y)
  (operate-general 'mul obj-x obj-y))

(define (div obj-x obj-y)
  (operate-general 'div obj-x obj-y))
