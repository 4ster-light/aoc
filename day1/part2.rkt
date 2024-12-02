#lang racket

(require racket/file)

(define (calculate-similarity left right)
  (let ([right-count (make-hash)])
    ;; Count occurrences in the right list
    (for-each (λ (num) (hash-update! right-count num add1 0)) right)
    ;; Calculate the similarity score
    (foldl (λ (num acc) (+ acc (* num (hash-ref right-count num 0)))) 0 left)))

(define (read-lists filename)
  (let ([lines (file->lines filename)])
    (let ([parsed-lines (map (λ (line)
                               (let ([split-line (string-split line "   ")])
                                 (list (string->number (first split-line))
                                       (string->number (second split-line)))))
                             lines)])
      (values (map first parsed-lines) (map second parsed-lines)))))

(define (main)
  (let* ([input-file "input.txt"])
    (let-values ([(left right) (read-lists input-file)])
      (let ([similarity-score (calculate-similarity left right)])
        (displayln similarity-score)))))

(main)
