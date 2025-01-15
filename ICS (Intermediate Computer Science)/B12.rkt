;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
;; 1
;; I'll figure out gradients later

;; 2
(define Q
  (frame (rectangle (* 75 4) (* 4 100) "solid" "yellow")))

(define BG (above (beside Q Q)
                  (beside Q Q)))

(define PT (circle 15 "solid" "cyan"))

(define (f x)
  (* (/ (- x 50) 10) (/ (- x 50) 10)))

(define (draw-h x)
  (place-image PT x (f x) BG))
(define (key-h x key)
  0)
(define (speed model x y event)
  (add1 model))

(define (new_add1 x)
  (remainder (+ x 1) 400))
#;(big-bang -75
  (on-draw draw-h)
  (on-tick new_add1)
  (on-key key-h)
  (on-mouse speed))

;; 3
(define (dh1 y)
  (overlay (rectangle (/ (min 150 (max 20 y)) 3) (min 150 (max 20 y)) "solid" "blue") (empty-scene 200 200)))
(define (mh1 model x y event)
  y)
(define (kh1 model key)
  (- model 5))
#;(big-bang 100
  (on-draw dh1)
  (on-key kh1)
  (on-mouse mh1))

;; 4
(define (mh2 model x y event)
  (rectangle (max 1 x) (max 1 y) "solid" "transparent"))
(define (dh2 model)
  (add-line (empty-scene 200 200) 0 70 (image-width model) (image-height model) "black"))
(big-bang (rectangle 80 90 "solid" "transparent")
  (to-draw dh2)
  (on-mouse mh2))