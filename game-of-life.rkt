#lang racket

(require "generation.rkt"
         "window.rkt")

(define size 100)
(define generation (create-generation size size))
(define canvas (create-window size size generation))

(define (loop n g)
  (send canvas change-generation g)
  (sleep 0.3)
  (when (> n 0)
    (loop (sub1 n) (next-generation g))))

(loop 300 generation)

