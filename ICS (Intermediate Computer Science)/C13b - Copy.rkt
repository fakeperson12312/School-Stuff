;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname C13b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(define (mult-13? n)
  (cond [(= (modulo n 13) 0) #true]
        [else #false]))

;; tg check expects
;;(check-expect (tg 1234) 3) 1 + 1 + 1 
;; (check-expect (tg 180) 15) 7 + 8 

;; (ced) Count how many odd digits a number has.
#;(define (odd? n)
  (cond [(= (modulo n 2) 1) #true]
        [else #false]))
;; bruh already a function named "odd?"
(define (ced n)
  (cond [(and (< n 10) (odd? n)) 1]
        [(< n 10) 0]
        [(odd? n) (+ 1 (ced (quotient n 10)))]
        [else (ced (quotient n 10))]))
(check-expect (ced 32) 1)
(check-expect (ced 33) 2)
(check-expect (ced 43) 1)
(check-expect (ced 123) 2)
(check-expect (ced 83) 1)
(check-expect (ced 480) 0)
(check-expect (ced 1254) 2)

;; (c13) How many pairs of consecutive digits are multiples of 13. The pairs of digits can overlap. Write examples and then write the function.
;; 13 -> 1
;; 265 -> 2
;; 131313 -> 3


(define (13? n) ;; simplified name
  (cond [(= (modulo n 13) 0) #true]
        [else #false]))
(define (num-digits num)
  (cond [(< num 10) 1]
        [else (+ 1 (num-digits (/ (- num (remainder num 10)) 10)))]))
(define (c13 n)
  (cond [(> 2 (num-digits n)) 0]
        [(13? (remainder n 100)) (+ 1 (c13 (quotient n 10)))]
        [else (c13 (quotient n 10))]))
(check-expect (c13 13) 1)
(check-expect (c13 265) 2)
(check-expect (c13 131313) 3)