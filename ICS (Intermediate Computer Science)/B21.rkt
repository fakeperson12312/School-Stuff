;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B21) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)

;; 1
#;(define (mess-1 in-bed? alarm-time clock-time)
  (cond [(boolean=? in-bed? true)
         (cond [(< clock-time alarm-time)
                "sleep"]
               [else
                "wake up"])]
        [(boolean=? in-bed? false)
         "wake up"]))
;; into
(define (mess-1 in-bed? alarm-time clock-time)
  (cond [(and (boolean=? in-bed? true) (< clock-time alarm-time)) "sleep"]
        [else "wake up"]))

;; 2
#;(define (ice-danger? temp precipitation? salt?)
  (and (boolean=? true precipitation?)
       (boolean=? false salt?)
       (not (>= temp 32))))
;; into
(define (ice-danger? temp precipitation? salt?)
  (and (boolean=? true precipitation? (not salt?))
       (< temp 32)))

;; 3/15.5.1
(define (carpet-price num)
  (cond [(>= num 500) (* 0.8 5 num)]
        [(>= num 100) (* 0.9 5 num)]
        [else (* 5 num)]))
(check-expect (carpet-price 100) 450)
(check-expect (carpet-price 500) 2000)
(check-expect (carpet-price 10) 50)

;; 4/15.5.2
(define (digital-thermometer num)
  (cond [(< num 99) (text (number->string num) 10 "green")]
        [(>= num 101) (text (number->string num) 10 "red")]
        [else (text (number->string num) 10 "yellow")]))
(check-expect (digital-thermometer 99) (text (number->string 99) 10 "yellow"))
(check-expect (digital-thermometer 101) (text (number->string 101) 10 "red"))
(check-expect (digital-thermometer 98) (text (number->string 98) 10 "green"))

;; 5/15.5.4
(define (who-won a b c)
  (cond [(and (> a b) (> a c)) "a"]
        [(and (> b a) (> b c)) "b"]
        [(and (> c b) (> c a)) "c"]
        [else "tie"]))
(check-expect (who-won 10 9 8) "a")
(check-expect (who-won 8 10 9) "b")
(check-expect (who-won 8 9 10) "c")
(check-expect (who-won 10 9 10) "tie")
(check-expect (who-won 10 10 8) "tie")
(check-expect (who-won 10 11 11) "tie")
(check-expect (who-won 8 8 8) "tie")

;; 6
(define x1 250)
(define y1 325)
(define x2 175)
(define y2 175)
(define x3 325)
(define y3 175)
(define (dist x1 x2 y1 y2)
  (sqrt ( + (expt (- x2 x1) 2) (expt (- y2 y1) 2))))
(define (six x y)
  (cond [(and (< (dist x1 x y1 y) 150) (< (dist x2 x y2 y) 150) (< (dist x3 x y3 y) 150)) "white"]
        [(and (< (dist x1 x y1 y) 150) (< (dist x2 x y2 y) 150)) (make-color 255 255 0)]
        [(and (< (dist x3 x y3 y) 150) (< (dist x2 x y2 y) 150)) (make-color 0 255 255)]
        [(and (< (dist x1 x y1 y) 150) (< (dist x3 x y3 y) 150)) (make-color 255 0 255)]
        [(< (dist x1 x y1 y) 150) "red"]
        [(< (dist x2 x y3 y) 150) "green"]
        [(< (dist x3 x y3 y) 150) "blue"]
        [else "black"]))
(build-image 500 500 six)