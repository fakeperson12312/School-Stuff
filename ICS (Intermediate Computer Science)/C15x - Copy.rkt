;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname C15x) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(define-struct pic (p b))
(define (random-posn x y)
  (make-posn (random x) (random y)))
(define (mh m x y e)
  (cond
    [(mouse=? e "button-down") (make-pic (make-posn x y) (place-image (circle 10 "solid" "blue") x y (pic-b m)))]
    [else (make-pic (make-posn x y) (pic-b m)) ]))
(define (dh m)
  (place-image (circle 10 "solid" "blue") (posn-x (pic-p m)) (posn-y (pic-p m)) (pic-b m)))
(big-bang (make-pic (random-posn 400 300) (rectangle 400 300 "outline" "white"))
  (on-draw dh)
  (on-mouse mh))