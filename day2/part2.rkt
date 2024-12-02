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

(define (safe-report-with-dampener? report)
  ;; Check if the report is safe without removing any level
  (when (safe-report? report) #t)

  ;; Try removing each level and check if the resulting list is safe
  (for/or ([i (in-range (length report))])
    (let ([modified-report (append
                            (take report i)
                            (drop report (add1 i)))])
      (and (monotonic? modified-report)
           (valid-differences? modified-report)))))

;; Read input from file and split into reports
(define (process-input-file filename)
  (let* ((input-string (file->string filename))
         (reports (map (λ (report-str)
                         (map string->number
                              (string-split report-str)))
                       (filter (λ (s) (not (string=? s "")))
                               (string-split input-string "\n")))))

    ;; Count safe reports
    (length (filter safe-report-with-dampener? reports))))

(define (main)
  (displayln (process-input-file "input.txt")))

(main)
