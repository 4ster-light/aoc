#lang racket

(require racket/file)

;; Parse a single line into two numbers
(define (parse-line line)
  (let ([split-line (string-split line "   ")])
    (list (string->number (first split-line))
          (string->number (second split-line)))))

;; Calculate total distance between corresponding elements
(define (calculate-total-distance left right)
  (foldl + 0
         (map (λ (pair) (abs (- (car pair) (cdr pair))))
              (map cons
                   (sort left <)
                   (sort right <)))))

;; Read file, process, and print solution
(define (main filename)
  (let* ([lines (file->lines filename)]
         [parsed-lines (map parse-line lines)]
         [left (map first parsed-lines)]
         [right (map second parsed-lines)]
         [total-distance (calculate-total-distance left right)])
    (displayln total-distance)))

(module+ main
  (main "input.txt"))
