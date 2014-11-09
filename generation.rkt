#lang racket

(define (create-generation width height)
  (for/list ([i (make-list height 0)])
            (map (λ (_) (random 2)) (make-list width 0))))

(define (next-cell-state neighborhood)
  (define sum (for/sum ([i neighborhood]) i))
  (cond [(= 3 sum) 1]
        [(= 4 sum) (list-ref neighborhood 4)]
        [else 0]))

(define (extract-neighborhood generation #:x [x 0] #:y [y 0])
  (define line1 (if (= y 0)
                  (extract-3-cells (list-ref generation (sub1 (length generation))) x)
                  (extract-3-cells (list-ref generation (sub1 y)) x)))
  (define line2 (extract-3-cells (list-ref generation y) x))
  (define line3 (if (= y (sub1 (length generation)))
                  (extract-3-cells (list-ref generation 0) x)
                  (extract-3-cells (list-ref generation (add1 y)) x)))
  (append line1 line2 line3))

(define (extract-3-cells line x)
  (define (cell index) (list-ref line index))
  (define high-limit (sub1 (length line)))
  (define (cells a b c) (list (cell a) (cell b) (cell c)))
  (cond [(= x 0) (cells high-limit x (add1 x))]
        [(= x high-limit) (cells (sub1 x) x 0)]
        [else (cells (sub1 x) x (add1 x))]))

(define (next-generation current)
  (for/list ([y (length current)])
    (for/list ([x (length (first current))])
      (define neighborhood (extract-neighborhood current #:x x #:y y))
      (next-cell-state neighborhood))))

(provide create-generation
         next-cell-state
         extract-neighborhood
         next-generation)
