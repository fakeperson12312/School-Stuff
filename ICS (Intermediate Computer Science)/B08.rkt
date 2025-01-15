;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B08) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
;; A good model might be a number or something to be remembered so that the shaded part can move on and off the screen
;; mh1: model x y event -> model
;; dh1: model -> model
;; kh1: model key -> model
;; assumptions: tri is already defined, it's a num for model's x or y cord
#;(define (kh1 model key)
   0)
;; Countdown
;; The number because everything else is stationary, you just subtract one everytime and use the draw handler to draw the number every second
;; th1: model -> model
;; dh1: model -> model

;; Random Numbers
;; (+ -1 (random 3))
;; (+ -18 (random 36))
;; (* 100 (+ 20 (random 10)))
(define (funcs m)
  (max 10 (+ 10 (random (max 1 (- m 9))))))
(funcs 20)
(funcs 20)
(funcs 20)
(funcs 20)
"asdf"
(funcs 5)
(funcs 5)
(funcs 5)
(funcs 5)
(define (harder _)
  (min 228 (max 81 (* 3 (+ 27 (random 50))))))
"asdf"
(harder 69)
(harder 69)
(harder 69)
(harder 69)
(define (hardest n)
  (min (* 50 n)(max (* -10 n) (+ (- (* 10 n)) (random (+ (* 60 n) 1))))))
"asdf"
(hardest 1)
(hardest 1)
(hardest 1)
(hardest 1)
(hardest 1)
(hardest 1)
(hardest 1)
(hardest 1)
(hardest 1)
(hardest 1)
(hardest 1)
(hardest 1)
(hardest 1)
;; Random vs Nonrandom
(define (circ_rect_rand _)
  (overlay
   (circle (/ (+ 200 (random 101)) 4) "solid" "blue")
   (rectangle (+ 100 (random 301)) (+ 200 (random 101)) "outline" "black"))) ; Rectangle
"asdf"
(circ_rect_rand 50)
(circ_rect_rand 50)

;; Math
(define (func x)
  (sqrt (- 7 (* 3 x))))
(check-expect (func 1) 2)
(define (mth2 x)
  (max 20 (min 200 x)))
(check-expect (mth2 1) 20)
(check-expect (mth2 50) 50)
(check-expect (mth2 201) 200)
