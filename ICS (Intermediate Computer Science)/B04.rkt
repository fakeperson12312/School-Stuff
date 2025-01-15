;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B04) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
"1"
(define (sq a)
  (* a a))
(define (hippo a b)
  (sqrt (+ (sq a) (sq b))))
(check-expect (hippo 3 4) 5)
(check-expect (hippo 7 24) 25)
"2"
(define (sl x1 y1 x2 y2)
  (/ (- x1 x2) (- y1 y2)))
"3"
(define (di x1 y1 x2 y2)
  (sqrt (+ (sq (- x1 x2)) (sq (- y1 y2)))))
"4"