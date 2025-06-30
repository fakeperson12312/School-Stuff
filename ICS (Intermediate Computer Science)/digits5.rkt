;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname digits5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(define (transl8 n)
  (help2 (help1 n) 1))
  #;(cond
    [(= n 0) 0]
    [else (help2 (help1 n) 1)]);;)

(define (help1 n)
  (cond
    [(= n 0) 0]
    [else (+ (* 10 (help1 (quotient n 10))) 
             (cond
               [(= (remainder n 10) 8) 0]
               [else (remainder n 10)]))]))

(define (help2 n p)
  (cond
    [(= n 0 n) 0]
    [else (+ (* (remainder n 10)
                p)
             (help2 (quotient n 10)
                    (* p 10)))]))


 (check-expect (transl8 8) 0)
 (check-expect (transl8 128) 120)
 (check-expect (transl8 847) 47)
 (check-expect (transl8 68687) 60607)

(define (i88 n)
  (remake (remove1 n) 1))
  #;(cond
    [(= n 0) 0]
    [else (remake (remove1 n) 1)]);;)

(define (remove1 n)
  (cond
    [(= n 0 n) 0]
    [(= (remainder n 10) 8) (remove1 (quotient n 10))]
    [else (+ (* 10 (remove1 (quotient n 10))) (remainder n 10))]))

(define (remake n place)
  (cond
    [(= n 0) 0]
    [else (+ (* (remainder n 10) place) (remake (quotient n 10) (* place 10)))]))
 (check-expect (i88 128) 12)
 (check-expect (i88 847) 47)
 (check-expect (i88 81838) 13)
 (check-expect (i88 8474850826) 4745026)