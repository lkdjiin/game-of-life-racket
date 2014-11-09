#lang racket/gui

(define (create-window w h g)
  (define scale 4)

  (define frame (new frame%
                     [label "Game of Life"]
                     [width (* w scale)]
                     [height (* h scale)]))

  (define canvas (new (class canvas%
         (super-new [parent frame] [style '(no-autoclear)])
         (define current-generation g)
         (define dc (send this get-dc))
         (define/public (change-generation g)
           (set! current-generation g)
           (send this refresh-now))
         (define/override (on-paint)
           (displayln "on-paint")
           (send dc set-brush (new brush% [color "black"]))
           (send dc draw-rectangle 0 0 (* w scale) (* h scale))
           (send dc set-brush (new brush% [color "white"]))
           (for ([y (length current-generation)])
             (for ([x (length (first current-generation))])
               (when (= 1 (list-ref (list-ref current-generation y) x))
                 (send dc draw-rectangle (* x scale) (* y scale) scale scale))))))))
  (send frame show #t)
  canvas)

(provide create-window)
