#lang racket

(define word "XMAS")

(define directions
  '((1 . 0)    ;; Right
    (-1 . 0)   ;; Left
    (0 . 1)    ;; Down
    (0 . -1)   ;; Up
    (1 . 1)    ;; Diagonal down-right
    (-1 . -1)  ;; Diagonal up-left
    (1 . -1)   ;; Diagonal down-left
    (-1 . 1))) ;; Diagonal up-right

(define (in-bounds? grid x y)
  (and (>= x 0)
       (< x (length grid))
       (>= y 0)
       (< y (string-length (list-ref grid x)))))

(define (word-matches? grid x y dx dy)
  (for/and ([i (in-range (string-length word))])
    (let* ([nx (+ x (* i dx))]
           [ny (+ y (* i dy))])
      (and (in-bounds? grid nx ny)
           (equal? (substring (list-ref grid nx) ny (+ ny 1))
                   (substring word i (+ i 1)))))))

(define (count-word grid x y)
  (for/sum ([dir directions])
    (let ([dx (car dir)]
          [dy (cdr dir)])
      (if (word-matches? grid x y dx dy) 1 0))))

(define (count-matches grid)
  (for/sum ([x (in-range (length grid))])
    (for/sum ([y (in-range (string-length (list-ref grid x)))])
      (count-word grid x y))))

(define (solve filename)
  (define grid (for/list ([line (file->lines filename)])
                 (string-trim line)))
  (displayln (count-matches grid)))

(solve "input.txt")
