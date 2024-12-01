#lang racket

(require racket/file)

(define (calculate-similarity left right)
  (define right-count (make-hash))
  ;; Count occurrences in the right list
  (for-each (λ (num) (hash-update! right-count num add1 0)) right)
  ;; For each number in left list, multiply by its count in right list
  (foldl (λ (num acc) (+ acc (* num (hash-ref right-count num 0)))) 0 left))

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
  (define input-file "input.txt")
  (define-values (left right) (read-lists input-file))
  (define similarity-score (calculate-similarity left right))
  (displayln similarity-score))

(main)
