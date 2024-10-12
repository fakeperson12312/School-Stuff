;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)

;; A10
;; Nope, u thought

(text "2" 30 "black")
(define (pillar img)
  (above img
         (rectangle
          (image-width img) 150 "solid" "gray")))
;; pillar: image -> image
(pillar (circle 50 "solid" "blue"))


(text "2" 30 "black")
(define txt1 (text "Where's the dot" 40 "black"))
(define txt2 (rotate-ccw (text "Hiding" 12 "red")))
(define pusher (square 10 "solid" "transparent"))
(define (dot-hide int img)
  (above txt1 (overlay/align "left" "middle" txt2 (place-image
   (circle int "solid" "red") 75 125
   (beside
    (above img pusher) pusher)))))
;; dot-hide: int img -> img
(dot-hide 4 (square 200 "outline" "black"))