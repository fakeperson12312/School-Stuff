;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A11a) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
#|
(define (myp img)
  (overlay (text "G" 24 "black") (overlay img (circle (image-height img) "outline" "blue"))))
(myp (rectangle 50 120 "solid" "green"))
;; myp: img -> img
(define (jail img)
  (beside/align "bottom" (rectangle (image-width img) (* 2 (image-height img)) "outline" "black") (above img (rectangle (image-width img)10 "outline" "black")) (rectangle (image-width img) (* 2 (image-height img)) "outline" "black")))
(jail pic:stick-figure)
|#
(define (pusher img)
  (above (beside (rectangle 15 (image-height img) "solid" "green") img) (rectangle (+ 15 (image-width img)) 15 "solid" "green")))
(pusher pic:stick-figure)
(pusher pic:bloch)
;; pusher: img -> img
(define (alternator img1 img2)
  (above (beside img1 (rectangle 20 (image-height img1) "solid" "transparent") img2 (rectangle 20 (image-height img1) "solid" "transparent") img1) (rectangle (image-width img1) 10 "solid" "transparent") (beside img2 (rectangle 20 (image-height img1) "solid" "transparent") img1 (rectangle 20 (image-height img1) "solid" "transparent") img2)))
#;(define (alternator img1 img2)
  (define empty (rectangle 20 (image-height img1) "solid" "transparent"))
  (above (beside img1 empty img2 empty img1) (beside img2 empty img1 empty img2)))

(alternator (triangle 50 "outline" "black") (circle 25 "outline" "black"))
(alternator pic:stick-figure pic:bloch)
;; alternator: img img -> img
(define (bee-p img color position)
  (overlay/align "middle" position (circle 10 "solid" color) img))
(bee-p (rectangle 200 50 "outline" "black") "blue" "bottom")
(bee-p (circle 50 "solid" "green") "red" "top")
;; bee-p: img color str -> img