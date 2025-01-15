;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B08b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
;; 1
(define (formula x)
  ( - 175 (round(* x 0.44444444444))))
(check-expect (formula 225) 75)
(check-expect (formula 0) 175)

;; 2
(define (form2 x)
   (min 80 (max 160( - 175 (round(* x 0.44444444444))))))

(check-expect (form2 100000) 80)
;; 3
(define (g1 x)
  (+ 10 (round( * 1.2 x))))

(check-expect (g1 200) 250)
;; 4
;; a
(define (good-area r)
  (*( / 355 113) (sqr r)))

;; b
(check-within (good-area 10) ( * 100 pi) 0.2)
(check-within (good-area 100) (* 10000 pi) 0.2)

;; c
(define (bad-area r)
  ( * (/ 355 223) ( sqr r)))

;; d
"(check-within (bad-area 10) (* 100 pi) 0.2)"

;; 5
(define (r x y)
  ( - 255 (round ( * x 0.425))))
(check-expect (r 600 200) 0)
(define (g x y) 0)
(check-expect (g 10 20) 0)
(build3-image 600 150 r g g)

;; 6
(define (g2 x y)
  ( + 75 (round( * x (/ 1 12)))))
(check-expect (g2 600 20)
              125)
(build3-image 600 150 r g2 g)

;; 7
(define (dist x y)
(round (min 255(sqrt (+ (sqr (- 255 x)) (sqr (- 255 y)))))))
(build3-image 510 510 dist dist dist)