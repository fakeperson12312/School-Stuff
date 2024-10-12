;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A07) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
;; A07
;; Nope this part is gone
(define (print i)(text i 30 "black"))
(print "1. ")
(define ee (ellipse 300 200 "solid" "grey"))
(define s (star 20 "outline" "black"))
(define p (square 30 "solid" "transparent"))
(define step1 (beside s p))
(define step2 (above s p))
(define step3 (overlay/align "right" "middle"step1 (overlay/align "middle" "bottom" step2 ee)))
step3
(print "2. ")
(define ee2 (ellipse 500 350 "solid" "grey"))
(define sstep1 (beside s p))
(define sstep2 (above s p))
(define sstep3 (overlay/align "right" "middle" step1 (overlay/align "middle" "bottom" step2 ee2)))
sstep3
(print "3. ")
(define r1 (rectangle 100 20 "outline" "black"))
(define r2 (rectangle 20 100 "outline" "black"))
(define s1 (beside/align "top" r2 r1 p))
(define s2 (above/align "left" s1 r1 p))
(define s3 (place-image r2 110 70 s2))
s3
(print "4. ")
(define sq (square 130 "outline" "black"))
(define tri (rotate -22.6 (right-triangle 50 120 "outline" "black")))
(define ss1 (beside tri sq))
(define ss2 (rotate 22.6 ss1))
ss2
(print "5. ")
(define a1 (crop (/ (image-width step3) 2)
                 (/ (image-height step3) 2)
                 (/ (image-width step3) 2)
                 (/ (image-height step3) 2) step3))
(crop 0 0 80 95 a1)