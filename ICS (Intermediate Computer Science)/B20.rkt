;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B20) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)

;; 1
(define (dist x1 x2 y1 y2)
  (sqrt ( + (expt (- x2 x1) 2) (expt (- y2 y1) 2))))

(define (one x y)
  (cond [(<= (dist 100 x 200 y) 75)   "red"]
        [else "white"]))
(flip-vertical (build-image 300 300 one))

;; 2
(define (two x y)
  (cond [(<= (dist 100 x 200 y) 75)  "red"]
        [(<= (dist 300 x 200 y) 85) "blue"]
        [else  "white"]))
(flip-vertical (build-image 500 500 two))

;; 3

(define (three x y)
  (cond [(and (<= (dist 225 x 200 y) 75)
              (<= (dist 300 x 200 y) 100))   "purple"]
        [(<= (dist 225 x 200 y) 75)  "red"]
        [(<= (dist 300 x 200 y) 100)   "blue"]
        [else "white"]))
(build-image 500 500 three)

;; 4
(define (four x y)
  (cond [(and (<= (dist 225 x 200 y) 50)
              (<= (dist 300 x 200 y) 75))   "purple"]
        [(<= (dist 225 x 200 y) 50)  "red"]
        [(<= (dist 300 x 200 y) 75)   "blue"]
        [(<= (dist 225 x 200 y) 100)   "pink"]
        [(<= (dist 300 x 200 y) 125)   "light blue"]
        [else "white"]))
(build-image 500 500 four)

;; u said #5 wasn't needed