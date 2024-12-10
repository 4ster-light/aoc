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

;; Check if a report is safe
(define (safe-report? report)
  (and (monotonic? report)
       (valid-differences? report)))

;; Check if a report is safe with a dampener
(define (safe-report-with-dampener? report)
  ;; Check if the report is safe without removing any level
  (if (safe-report? report)
      #t
      ;; Try removing each level and check if the resulting list is safe
      (for/or ([i (in-range (length report))])
        (let ([modified-report (append
                                (take report i)
                                (drop report (add1 i)))])
          (and (monotonic? modified-report)
               (valid-differences? modified-report))))))

;; Process the input string into reports
(define (parse-reports input-string)
  (map (λ (report-str)
         (map string->number
              (string-split report-str)))
       (filter (λ (s) (not (string=? s "")))
               (string-split input-string "\n"))))

;; Count safe reports with dampener
(define (count-safe-reports-with-dampener reports)
  (length (filter safe-report-with-dampener? reports)))

(define (solve filename)
  (let* ([input-string (file->string filename)]
         [reports (parse-reports input-string)]
         [result (count-safe-reports-with-dampener reports)])
    (displayln result)))

(solve "input.txt")
