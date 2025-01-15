;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
;; Imma use 3.14 for pi instead of "pi"

;; 7.7.2
(define (rect-perimeter width height)
  (+ width width height height))
(check-expect (rect-perimeter 1 2) 6)
(check-expect (rect-perimeter 50 12) (* 2 62))
;; 7.7.3
(define (circle-perimeter radius)
  (* 2 3.14 radius))
(check-expect (circle-perimeter 1) (* 2 3.14))
;; 7.7.4
(define (area-of-circle radius)
  (* 3.14 radius radius))
(check-expect (area-of-circle 1) 3.14)
;; 7.75
;; is there not a solution in the book already
(define (area-of-ring in_radius out_radius)
  (area-of-circle (- out_radius in_radius)))
(check-expect (area-of-ring 1 2) 3.14)

;; B05/ex7b
;; 7.1.4
;; are we doing prefix notation or smth
"7.1.4"
"(+ 3 (* 5 2))"
;; 7.1.5
"7.1.5"
"(* (+ 1 2) (+ 3 4))"
;; 7.1.6
"7.1.6"
"(sqrt (+ 4 5))"
;; 7.1.7
"7.1.7"
"(add1 5) -> 6"
"(sub1 5) -> 4"
"(+ 5 1) -> 6"
"(- 5 1) -> 4"
;; 7.1.8
"7.1.8"
"7-24/8*(4+6)"
"(- 7 (* (/ 24 8) (+ 4 6))) -> -23"
;; (- 7 (* (/ 24 8) (+ 4 6)))