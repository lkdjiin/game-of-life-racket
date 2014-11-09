#lang racket

(require rackunit
         "generation.rkt")

(test-case "create-generation"
  (check-pred list? (create-generation 3 4)
            "It returns a list")

  (check-equal? (length (create-generation 3 4)) 4
              "It builds a list with the right height")

  (check-equal? (length (first (create-generation 3 4))) 3
              "It builds a list with the right width")

  (let ([cell (first (first (create-generation 3 4)))])
    (check-true (or (= cell 0) (= cell 1))
                "It populates generation with 0s or 1s"))

  ((λ ()
   (random-seed 1)
   (check-equal? (create-generation 2 3) '((1 1) (0 1) (1 1))
                 "It populates generation uniformly"))))

(test-case "next-cell-state"
  (check-equal? (next-cell-state '(1 1 1 0 0 0 0 0 0)) 1)
  (check-equal? (next-cell-state '(1 0 0 1 0 0 1 0 0)) 1)

  (check-equal? (next-cell-state '(1 0 0 1 1 0 1 0 0)) 1)
  (check-equal? (next-cell-state '(1 0 0 1 0 0 1 0 1)) 0)

  (check-equal? (next-cell-state '(1 1 1 1 1 1 1 1 1)) 0)
  (check-equal? (next-cell-state '(0 0 0 0 0 0 0 0 0)) 0))

(test-case "extract-neighborhood"
  (let ([game '((1 0 1 0)
                (0 1 0 1)
                (1 0 0 1))])

    (check-equal? (extract-neighborhood game #:x 1 #:y 1) '(1 0 1 0 1 0 1 0 0))
    (check-equal? (extract-neighborhood game #:x 2 #:y 1) '(0 1 0 1 0 1 0 0 1))
 
    (check-equal? (extract-neighborhood game #:x 1 #:y 0) '(1 0 0 1 0 1 0 1 0))
    (check-equal? (extract-neighborhood game #:x 2 #:y 2) '(1 0 1 0 0 1 0 1 0))

    (check-equal? (extract-neighborhood game #:x 0 #:y 1) '(0 1 0 1 0 1 1 1 0))
    (check-equal? (extract-neighborhood game #:x 3 #:y 1) '(1 0 1 0 1 0 0 1 1))))

#;(test-case "next-generation"
  (let ([game '((1 0 1 0)
                (0 1 0 1)
                (1 0 0 1))])

    (check-equal? (next-generation game) '((0 1 1 0) (1 1 0 1) (0 0 1 0)))))

