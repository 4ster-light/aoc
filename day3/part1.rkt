#lang racket

;; Regular expression to match valid mul() instructions
(define mul-regex
  #rx"mul\\s*\\(\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*\\)")

;; Extract and compute valid multiplication results
(define (extract-mul-results input-string)
  (let loop ([start 0]
             [results '()])
    (let ([match (regexp-match-positions mul-regex input-string start)])
      (if (not match)
          (reverse results)
          (let* ([full-match (car match)]
                 [x-match (cadr match)]
                 [y-match (caddr match)])
            (loop
             (cdr full-match)
             (cons
              (*
               (string->number
                (substring input-string
                           (car x-match)
                           (cdr x-match)))
               (string->number
                (substring input-string
                           (car y-match)
                           (cdr y-match))))
              results)))))))

;; Sum all multiplication results
(define (sum-mul-results results)
  (apply + results))

(define (solve filename)
  (let* ([input-string (file->string filename)]
         [mul-results (extract-mul-results input-string)]
         [total (sum-mul-results mul-results)])
    (displayln total)))

(solve "input.txt")
