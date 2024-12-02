#lang racket

(require racket/file)

(define (calculate-total-distance left right)
  (let* ([sorted-left (sort left <)]
         [sorted-right (sort right <)])
    (foldl + 0 
           (map (λ (pair) (abs (- (car pair) (cdr pair))))
                (map cons sorted-left sorted-right)))))

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
      (let ([total-distance (calculate-total-distance left right)])
        (displayln total-distance)))))

(main)
