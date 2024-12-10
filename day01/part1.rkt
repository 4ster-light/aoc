#lang racket

(require racket/file)

(define (parse-line line)
  (let ([split-line (string-split line "   ")])
    (list (string->number (first split-line))
          (string->number (second split-line)))))

(define (calculate-total-distance left right)
  (foldl + 0
         (map (λ (pair) (abs (- (car pair) (cdr pair))))
              (map cons
                   (sort left <)
                   (sort right <)))))

(define (solve filename)
  (let* ([lines (file->lines filename)]
         [parsed-lines (map parse-line lines)]
         [left (map first parsed-lines)]
         [right (map second parsed-lines)]
         [total-distance (calculate-total-distance left right)])
    (displayln total-distance)))

(solve "input.txt")
