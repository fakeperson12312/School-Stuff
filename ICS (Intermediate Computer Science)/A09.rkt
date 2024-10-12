;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A09) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)

;; smth
;; Nope
"1"
(define (leffy img)
  (overlay/align "left" "middle" (text "LEFT" 15 "orange") img))
(define test-rect (rectangle 150 50 "outline" "black"))
(leffy test-rect)
"2"
(define (wall img)
  (beside img (rectangle 10 (image-height img) "solid" "transparent") (rectangle (image-width img) (image-height img) "outline" "purple")))
(wall (circle 25 "outline" "black"))
"3"
(define (simple-snake width img)
  (above/align "right" img (rectangle width 20 "outline" "black")))
(simple-snake 100 (circle 10 "solid" "yellow"))