;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname C28) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(require "posn-utils.rkt")
(define-struct parcel (x y lis))
(define (dist p d)
  (+ (abs (- (posn-x p)
             (posn-x d)))
     (abs (- (posn-y p)
             (posn-y d)))))

(define sq-len 15)

(define (in? p lis)
  (cond [(empty? lis)
         false]
        [else (or (posn=? p (first lis))
                  (in? p (rest lis)))]))

(define (colour num)
  (cond [(= num 0) "Red"]
        [(= num 1) "Orange"]
        [(= num 2) "Yellow"]
        [(= num 3) "Green"]
        [(= num 4) "Blue"]
        [(= num 5) "Dark Blue"]
        [(= num 6) "Violet"]
        [(= num 7) "Dark Green"]
        [(= num 8) "Gold"]
        [(= num 9) "Azure"]
        [else "Aqua"]))

(define (mh m x y e)
  (cond [(and (string=? e "button-down") (not (in? (make-posn (quotient x sq-len) (quotient y sq-len)) (parcel-lis m)))) (make-parcel (parcel-x m) (parcel-y m) (append (parcel-lis m) (list (make-posn (quotient x sq-len) (quotient y sq-len)))))]
        [else m]))

(define (closest1 p lis num)
  (cond [(empty? lis) empty]
        [else (list* (make-posn (dist p (first lis)) num) (closest1 p (rest lis) (+ num 1)))]))

(define (smaller-posn p1 p2)
  (cond [(< (posn-x p1) (posn-x p2)) p1]
        [else p2]))

(define (closest2 p lis)
  (cond [(empty? (rest lis)) (first lis)]
        [else (smaller-posn (first lis) (closest2 p (rest lis)))]))

(define (ds p lis)
  (cond [(empty? lis) (square sq-len "solid" "black")]
        [else (overlay (text (number->string (posn-x (closest2 p (closest1 p lis 0)))) 10 "black") (square sq-len "solid" (colour (posn-y (closest2 p (closest1 p lis 0))))))]))

(define (dh-row x y m)
  (cond [(= x (parcel-x m)) (ds (make-posn x y) (parcel-lis m))]
        [else (beside (ds (make-posn x y) (parcel-lis m)) (dh-row (add1 x) y m))]))

(define (join-row y m)
  (cond [(= y (parcel-y m)) (dh-row 0 y m)]
        [else (above (dh-row 0 y m) (join-row (add1 y) m))]))

(define (dh m)
  (join-row 0 m))

(big-bang (make-parcel 20 20 empty)
  (to-draw dh)
  (on-mouse mh))