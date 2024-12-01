#lang racket

(require racket/file)

(define (calculate-total-distance left right)
  (define sorted-left (sort left <))
  (define sorted-right (sort right <))
  ;; Calculate the total distance
  (foldl + 0 (map (λ (pair) (abs (- (car pair) (cdr pair))))
                  (map cons sorted-left sorted-right))))

(define (read-lists filename)
  (define lines (file->lines filename))
  ;; Split each line into left and right numbers
  (define parsed-lines
    (map (λ (line)
           ;; Split the line by three spaces
           (let ([split-line (string-split line "   ")])
             (list (string->number (first split-line))
                   (string->number (second split-line)))))
         lines))
  ;; Separate the numbers into two lists
  (define left (map first parsed-lines))
  (define right (map second parsed-lines))
  (values left right))

(define (main)
  (define input-file "input.txt") ;; Specify the input file
  (define-values (left right) (read-lists input-file))
  (define total-distance (calculate-total-distance left right))
  (displayln total-distance))

(main)
