#lang racket

;; Check if the report is strictly increasing or strictly decreasing
(define (monotonic? lst)
  (or (apply <= lst)
      (apply >= lst)))

;; Check if adjacent differences are between 1 and 3
(define (valid-differences? lst)
  (for/and ([a (in-list lst)]
            [b (in-list (rest lst))])
    (let ([diff (abs (- b a))])
      (and (>= diff 1)
           (<= diff 3)))))

(define (safe-report? report)
  (and (monotonic? report)
       (valid-differences? report)))

;; Read input from file and split into reports
(define (process-input-file filename)
  (let* ((input-string (file->string filename))
         (reports (map (λ (report-str)
                         (map string->number
                              (string-split report-str)))
                       (filter (λ (s) (not (string=? s "")))
                               (string-split input-string "\n")))))

    ;; Count safe reports
    (length (filter safe-report? reports))))

(define (main)
  (displayln (process-input-file "input.txt")))

(main)
