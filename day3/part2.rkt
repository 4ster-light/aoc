#lang racket

;; Regular expressions to match valid mul(), do(), and don't() instructions
(define mul-regex #rx"mul\\s*\\(\\s*([0-9]+)\\s*,\\s*([0-9]+)\\s*\\)")
(define do-regex #rx"do\\(\\)")
(define dont-regex #rx"don't\\(\\)")

;; Extract and compute valid multiplication results, handling do() and don't()
(define (extract-enabled-mul-results input-string)
  (let loop ([start 0]
             [enabled? #t]  ; Initially, mul() instructions are enabled
             [results '()]) ; Initialize results as a list
    (let* ([mul-match (regexp-match-positions mul-regex input-string start)]
           [do-match (regexp-match-positions do-regex input-string start)]
           [dont-match (regexp-match-positions dont-regex input-string start)]
           [next-pos
            (cond
              [(and mul-match do-match dont-match)
               (min (car (car mul-match))
                    (car (car do-match))
                    (car (car dont-match)))]
              [(and mul-match do-match)
               (min (car (car mul-match)) (car (car do-match)))]
              [(and mul-match dont-match)
               (min (car (car mul-match)) (car (car dont-match)))]
              [mul-match (car (car mul-match))]
              [do-match (car (car do-match))]
              [dont-match (car (car dont-match))]
              [else #f])])
      (cond
        [(not next-pos) (reverse results)]

        ;; Handle do()
        [(and do-match (= next-pos (car (car do-match))))
         (loop (cdr (car do-match)) #t results)]

        ;; Handle don't()
        [(and dont-match (= next-pos (car (car dont-match))))
         (loop (cdr (car dont-match)) #f results)]

        ;; Handle mul()
        [(and mul-match (= next-pos (car (car mul-match))))
         (let* ([full-match (car mul-match)]
                [x-match (cadr mul-match)]
                [y-match (caddr mul-match)]
                [x (string->number
                    (substring input-string (car x-match) (cdr x-match)))]
                [y (string->number
                    (substring input-string (car y-match) (cdr y-match)))])
           (loop (cdr full-match)
                 enabled?
                 (if enabled? (cons (* x y) results) results)))]

        ;; No matching instruction
        [else (loop (add1 next-pos) enabled? results)]))))

;; Sum all enabled multiplication results
(define (sum-enabled-mul-results results)
  (apply + results))

(define (solve filename)
  (let* ([input-string (file->string filename)]
         [mul-results (extract-enabled-mul-results input-string)]
         [total (if (null? mul-results) 0 (sum-enabled-mul-results mul-results))])
    (displayln total)))

(solve "input.txt")
