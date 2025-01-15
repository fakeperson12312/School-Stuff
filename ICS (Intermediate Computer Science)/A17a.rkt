;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A17a) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(define (key-h img k)
  (beside img (overlay (text k 24 "black") (rectangle 30 60 "outline" "black"))))
(define (put img)
  (overlay img (rectangle 400 300 "outline" "black")))
(define (put1 img)
  (overlay/align "middle" "bottom" img (rectangle 400 300 "solid" "sky blue")))
;; lousy typewriter
#;(big-bang (circle 0 "solid" "transparent")
    (on-key key-h)
    (on-draw put))
(scale/xy 6.9 1 pic:book)
(define (distort img k)
  (scale/xy 1.1 1 img))
;; star-strecher
#;(big-bang pic:book
    (on-key distort)
    (on-draw put))


(define (push img)
  (above img (square 10 "solid" "transparent")))
(define (push1 img k)
  (crop 0 0 160 (- (image-height img) 20) img))
#;(big-bang (circle 80 "solid" "yellow")
    (on-tick push 0.5)
    (on-key push1)
    (on-draw put1))


;;other
;; 1
#;(define (aligning width)
    (square (+ (- 500 width) 6) 0 "transparent"))
(define starter (square 10 "solid" "blue"))
(define (move-left img)
  (beside #;(aligning (image-width img)) img (square 6 0 "transparent")))
(define (put2 img)
  (overlay/align "right" "middle" img (rectangle 500 300 "outline" "black")))
#;(big-bang starter
    (to-draw put2)
    (on-tick move-left 0.1))
;; 2
;; Is that not just the sunrise problem before
"3"
(define dh (rectangle 500 300 "solid" "transparent"))
(define (dh1 img)
  (overlay/align "left" "bottom" img dh))
(define (dh2 img)
  (overlay/align "right" "top" img dh))
(define (dh3 img)
  (overlay (dh1 img) (dh2 img)))
(define (move1 img)
  (above (square 6 0 "transparent") img))
(define (move2 img)
  (above img (square 6 0 "transparent")))
#;(define (move img)
    (overlay/align "left" "bottom" (move1 img)))
#;(big-bang starter
    (to-draw dh3)
    (on-tick move 0.1))
;; Doesn't work, I'm not sure how to combine both rectangles into one scene
;; Seperatly, it's right here:
(define (put3 img)
  (overlay/align "left" "bottom" img (rectangle 500 300 "outline" "black")))
(define (put4 img)
  (overlay/align "right" "top" img (rectangle 500 300 "outline" "black")))
#;(big-bang starter
    (to-draw put3)
    (on-tick move2 0.1))
;; and
#;(big-bang starter
    (to-draw put4)
    (on-tick move1 0.1))
"4"
(define push10 (square 30 0 "transparent"))
(define (dh4 img)
  (overlay/align "left" "middle" img(rectangle 400 300 "outline" "black")))
(define s (star 20 "outline" "yellow"))
(define (throwing-star img)
  (beside push10 (rotate 5 img)))
(big-bang s
  (to-draw dh4)
  (on-tick throwing-star 0.1))