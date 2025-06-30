;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname digits3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(define (ism? n)
  (cond [(= 0 (remainder n 19)) #true]
        [(= 0 (remainder 5698296 n)) #true]
        [else #false]))
(check-expect (ism? 38) #true)
(check-expect (ism? 2) #true)
(check-expect (ism? 37) #true)
(check-expect (ism? 89) #false)

;; ASK ABT WHAT IF ITS NOT DIVISIBLE
(define (twentyish n)
  (cond [(= n 0) 0] 
        [(= 0 (remainder n 10)) (twentyish (quotient n 10))]
        [else (+ (/ 20 (remainder n 10)) (twentyish (quotient n 10)))]))
(check-expect (twentyish 14) 25)
(check-expect (twentyish 145) 29)
(check-expect (twentyish 145210) 59)

;; number 3
;; for (mess 15)
;; first it checks if its smaller than 20, and it is. So it returns 5
;; for (mess 23)
;; checking if it's smaller than 20, it's not so it continues.
;; checking if 23/5's remainder is 3, and it is. so then it returns (mess 21) next, which then becomes 1 + (mess 17) which becomes 1+6 or 7
;; for (mess 41)
;; first two conds fail, so the else executes. It adds 1 to (mess 37), and (mess 37) is 35+2, which isn't a remainder of 3.
;; so it becomes 2 plus (mess 33) which has a remainder of 3 when divided by 5.
;; then it becomes 33 minus 5 which is 28, then it becomes 28 again, looping and breaking eventually. 

(define c (circle 20 "solid" "orange"))
(define s (square 40 "solid" "blue"))
(define t (triangle 48 "solid" "green"))
(define st (star 40 "solid" "purple"))
(define s2 (square 40 "solid" "yellow"))
(define pusher (rectangle 0.5 0 0 "transparent"))
(define blank (rectangle 0 0 0 "transparent"))
(define (numimg n)
  (cond [(= n 0) blank]
        [(= (remainder n 10) 0) (beside/align "middle" (numimg (quotient n 10)) pusher c)]
        [(= (remainder n 10) 1) (beside/align "middle" (numimg (quotient n 10)) pusher s)]
        [(= (remainder n 10) 2) (beside/align "middle" (numimg (quotient n 10)) pusher t)]
        [(= (remainder n 10) 3) (beside/align "middle" (numimg (quotient n 10)) pusher st)]
        [else (beside/align "middle" (numimg (quotient n 10)) pusher s2)]))
(numimg 12035532)
(numimg 01234)
(numimg 43210)
(numimg 432105559)

(define (2dg n)
    (cond [(< n 10) 0]
          [else (+ (remainder n 100) (2dg (quotient n 100)))]))

(check-expect (2dg 1) 0)
(check-expect (2dg 14) 14)
(check-expect (2dg 142) 42)
(check-expect (2dg 1425) (+ 25 14))
(check-expect (2dg 14258) (+ 58 42))
(check-expect (2dg 142580) (+ 80 25 14))

(define (div3 n)
  (cond [(= (remainder n 3) 0) #true]
        [else #false]))
(define (count-div3 n)
  (cond [(= n 0) 0]
        [(div3 (remainder n 10)) (+ 1 (count-div3 (quotient n 10)))]
        [else (count-div3 (quotient n 10))]))
(check-expect (count-div3 3) 1)
(check-expect (count-div3 6) 1)
(check-expect (count-div3 9) 1)
(check-expect (count-div3 1234567890) 4) ;; is 0 divisible by 3 again