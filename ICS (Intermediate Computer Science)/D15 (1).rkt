;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname D15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(require racket/base)
(define (num-list n)
  (for/list ([i (in-range 1 (+ n 1))])
    i))
(check-expect (num-list 5) (list 1 2 3 4 5))

(define (keep-multiples m lst)
  (for/list ([e (in-list lst)] #:when (= 0 (remainder e 7)))
    e))
(check-expect (keep-multiples 7 (list 2 14 22 7 35))
              (list 14 7 35))

(define (proper-divisors m)
  (for/list ([skib (in-range 2 m)] #:when (= 0 (remainder m skib)))
    skib))
(check-expect (proper-divisors 12) (list 2 3 4 6))
(check-expect (proper-divisors 3) (list))

#;(define (bishop x y)
    (for/list ([a (in-range 0 8)]
               [b (in-range 0 8)]
               #:when (and (not (and (= a x) (= b y)))
                           (= (abs (- a x)) (abs (- b y)))))
      (make-posn a b)))

#;(define (bishop x y)
    (for/fold ([ans '()]) ([a (in-range 0 8)])
      (for/fold ([help '()]) ([b (in-range 0 8)]
                              #:when (and (not (and (= a x) (= b y)))
                                          (= (abs (- a x)) (abs (- b y)))))
        (list* (make-posn a b) help))))
(define (bishop x y)
  (append
   (for/list ([i (in-range 1 (+ 1 (min (- 7 x) (- 7 y))))])
     (make-posn (+ x i) (+ y i)))
   (for/list ([i (in-range 1 (+ 1 (min x (- 7 y))))])
     (make-posn (- x i) (+ y i)))
   (for/list ([i (in-range 1 (+ 1 (min (- 7 x) y)))])
     (make-posn (+ x i) (- y i)))
   (for/list ([i (in-range 1 (+ 1 (min x y)))])
     (make-posn (- x i) (- y i)))))

(bishop 2 3)
#;(check-expect
 (bishop 2 3)
 (list (make-posn 0 5) (make-posn 1 4) ;; (make-posn 2 3)
       (make-posn 3 2) (make-posn 4 1) (make-posn 5 0)
       (make-posn 1 2) (make-posn 0 1) (make-posn 3 4)
       (make-posn 4 5) (make-posn 5 6) (make-posn 6 7)))

(require racket/base)
#;(define-struct locker (state next) #:transparent)
(define size 45) ;; side length of one square
(define width 10)
(define height 8)
(define default (square size "solid" "red"))
(define selected (square size "solid" "blue"))
(define (computer->grid p)
  (make-posn (+ (quotient (posn-x p) size) 1)
             (+ 1 (quotient (posn-y p) size))))
#;(define (grid->computer p)
  (make-posn (* size (+ 1/2 (posn-x p)))
             (* size (+ 1/2 (posn-y p)))))
(define (genrow nums)
  (for/fold ([m (square 0 0 "transparent")]) ([cur (in-list nums)] #:when (> cur (+ -1 (* width height -1))))
    (beside m (overlay (text (number->string (abs cur)) (round (+ (/ size 2) -1)) "black") (if (>= cur 0) default selected)))))
(define (gengrid len nums)
  (for/fold ([grid (square 0 0 "transparent")]) ([skib (in-list nums)])
    (above grid (genrow skib))))
(define (make-row start)
  (for/list ([n (in-range start (+ start 10))])
    n))
(define (make-grid rows)
  (for/list ([n (in-range 1 (+ rows 1))])
    (make-row (+ 1 (* 10 (- n 1))))))
#;(define (muh cur step)
  (cond
    [(> cur 100) empty]
    [else (list* cur (muh (+ cur step) step))]))

#;(define (genmul n)
  (muh n n))
(define (genmul n)
  (for/list ([a (in-range 1 (+ 1 (* width height 1)))] #:when (= 0 (remainder a n)))
    a))
(check-expect (genmul 1) (for/list ([a (in-range 1 (+ 1 (* width height 1)))]) a))
(define (in? x lst)
  (cond
    [(empty? lst) false]
    [(= x (first lst)) true]
    [else (in? x (rest lst))]))

#;(for/list ([n (in-list (list 1 1 1 1 1 1 1 1 1 1))]) (list 1 1 1 1 1 1 1 1 1 1))
#;(define defaultgrid (gengrid 10 (for/list ([n (in-list (list 1 1 1 1 1 1 1 1 1 1))]) (list 1 1 1 1 1 1 1 1 1 1))))
(define (findnum p)
  (+ (posn-x p) (* width (- (posn-y p) 1))))
(define (flips grid vals)
  (for/list ([currow (in-list grid)])
    (for/list ([curnum (in-list currow)])
      (if (in? (abs curnum) vals) (* -1 curnum) curnum))))
#;(define defaultgrid (gengrid 10 (make-grid 10)))
(define defaultgrid (reverse (list* (list (+ -1 (* width height -2))) (reverse (make-grid height)))))
(define (mh m x y e)
  (if (mouse=? e "button-down") (flips m (genmul (findnum (computer->grid (make-posn x y))))) m))
(define primes (list 2 3 5 7 11 13 17 19 23 29
 31 37 41 43 47 53 59 61 67
 71 73 79 83 89 97)) ;; i got too lazy
(define (genprime end)
  (for/list ([n (in-range 1 (+ end 1))] #:when (and (empty? (proper-divisors (abs n))) (not (= 1 (abs n)))))
    n))
(define (dh m)
  (gengrid height m))
#;(dh (flips defaultgrid (list 10 20 30)))
(define (kh m k)
  (cond [(string=? k "c") defaultgrid]
        [(string=? k "p") (flips m (genprime (* width height)))]
        [(string=? k "r") (reverse (list* (list (+ -1 (* width height -1))) (rest (reverse m))))]
        [else m]))
(define (tick m)
  (if (and (< (first (first (reverse m))) (* width height -1)) (> (first (first (reverse m))) (+ (* width height -2) -1))) (flips (reverse (list* (list (- (first (first (reverse m))) 1)) (rest (reverse m)))) (genmul (abs (+ (* width height) (first (first (reverse m))))))) m))
(big-bang defaultgrid
  (on-mouse mh)
  (on-draw dh)
  (on-key kh)
  (on-tick tick 0.3))