;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname C04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
;; Part 1

;; 1
;; the model data type is an image because that's what it starts with

;; 2
;; the tick handler makes the image 1/10 smaller every whatever the default time is for every tick

;; 3
;; the user will see an image of the author to the left getting smaller and smaller while on the right side there's gonna be a constant pic:bloch

;; 4
;; the program will stop when the image of the model gets too small, smaller than 1/10 of the original one

;; 5
;; bucket-getter?: number -> string

;; 6
;; one smaller than 5, one bigger than 5 and smaller than 10, one inbetween 10 and 11
;; one bigger than 11 and smaller than 20, one equal to 20, one bigger than 20, one smaller than 5
;; that covers all the cases
;; example: (check-expect (bucket-getter? 6) "Absolutely not")

;; 7
;; Any check-expects smaller than 5 or equal to 20, and to optimize it, there should be an else statement to cover all remaining possibilities
;; the (< points 20) should become (<= points 20) and (> points 10) should become (>= points 11)

;; 8
;; the tick handler should have a 2 behind it so the model changes every 2 seconds, and random 3 will never return 3, it should be random 4
;; also there's a parentheses missing for the tickh1 function and random-number is only going to run once, it should be a function not a variable

;; Part 2
;; Image Model

(define (dh1 model)
  (place-image model (/ (image-width model) 2) (/ (image-height model) 2) (square 500 "outline" "transparent")))
(define (kh1 model key)
  (cond [(string=? key "r") pic:bloch]
        [else model]))
(define (th1 model)
  (rotate -45 (scale 2 model)))

(big-bang pic:bloch
  (on-draw dh1)
  (on-key kh1)
  (on-tick th1 2))
"nvm i dont need to do this"
;; String Model
#;(define (dh2 str)
  (cond []))
#;(define (kh2 str)
  ())
#;(define (mh2 str x y event)
  ())
#;(define (stopw str)
  ())
#;(define (stopped str)
  ())
#;(big-bang ""
  (on-draw dh2)
  (on-key kh2)
  (on-mouse mh2)
  (stop-when stopw stopped))
