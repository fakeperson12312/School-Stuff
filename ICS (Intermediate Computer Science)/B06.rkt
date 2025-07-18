;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B06) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
;; i forgot to label this one so gl trying to see through it
(define (at-most-250 x)
  (min x 250))
(check-expect (at-most-250 250) 250)
(check-expect (at-most-250 200) 200)
(check-expect (at-most-250 260) 250)
(define (small-0 x y)
  (abs (min (abs (- x 0)) (abs (- y 0)))))
(check-expect (small-0 50 25) 25)
(check-expect (small-0 50 -25) 25)
(check-expect (small-0 -50 25) 25)
(check-expect (small-0 -50 -25) 25)
(define (stuck-50-150 x)
  (max (min x 150) 50))
(check-expect (stuck-50-150 50) 50)
(check-expect (stuck-50-150 150) 150)
(check-expect (stuck-50-150 70) 70)
(check-expect (stuck-50-150 10) 50)
(check-expect (stuck-50-150 250) 150)
(define (random-a _)
  (- (random 101) 50))
(define (random-b _)
  (* (random 101) 2))
(random-a 69)
(random-a 69)
(random-b 69)
(random-b 69)
(define (dice _)
  (+ (random 5) (random 5) 2))
(dice 69)
(dice 69)
(define (rstar _)
  (star (+ (random 101) 4) "solid" "blue"))
(rstar 69)
(rstar 69)

(define (stars _)
 (star (+ (random 101) 4) "solid" "blue"))
(define (dstar _ a)
  (beside (stars _) (square 6 0 "transparent") (scale 2 (stars _))))
(dstar 69 69)
(define a (+ 3 (random 28)))
(define (challenge x)
  (star-polygon 20 a (remainder 31 a) "solid" "blue"))
(challenge 50)
