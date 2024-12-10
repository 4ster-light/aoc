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

;; Determine if a report is safe
(define (safe-report? report)
  (and (monotonic? report)
       (valid-differences? report)))

;; Process the input string into reports
(define (parse-reports input-string)
  (map (λ (report-str)
         (map string->number
              (string-split report-str)))
       (filter (λ (s) (not (string=? s "")))
               (string-split input-string "\n"))))

;; Count safe reports
(define (count-safe-reports reports)
  (length (filter safe-report? reports)))

;; Entry point
(define (solve filename)
  (let* ([input-string (file->string filename)]
         [reports (parse-reports input-string)]
         [result (count-safe-reports reports)])
    (displayln result)))

(solve "input.txt")
