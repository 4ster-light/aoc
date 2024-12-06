#lang racket

(require racket/file)

;; Parse a single line into two numbers
(define (parse-line line)
  (let ([split-line (string-split line "   ")])
    (list (string->number (first split-line))
          (string->number (second split-line)))))

;; Calculate similarity score
(define (calculate-similarity left right)
  (let ([right-count (make-hash)])
    ;; Count occurrences in the right list
    (for-each (λ (num) (hash-update! right-count num add1 0)) right)
    ;; Calculate the similarity score
    (foldl (λ (num acc) (+ acc (* num (hash-ref right-count num 0)))) 0 left)))

;; Main function that reads file, processes input, and prints solution
(define (main filename)
  (let* ([lines (file->lines filename)]
         [parsed-lines (map parse-line lines)]
         [left (map first parsed-lines)]
         [right (map second parsed-lines)]
         [similarity-score (calculate-similarity left right)])
    (displayln similarity-score)))

;; Run main with input file if this is the main module
(module+ main
  (main "input.txt"))
