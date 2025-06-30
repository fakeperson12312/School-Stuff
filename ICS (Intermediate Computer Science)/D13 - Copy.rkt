;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname D13) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(require racket/base)
(define me (list 10 20 30 40))
(define (sum lst)
  (for/fold ([y 0]) ([n (in-list lst)]) (+ n y)))
(sum me)
(define (mul lst)
  (for/fold ([y 1]) ([n (in-list lst)]) (* n y)))
(mul me)
(define (rad lis)
  (for/fold ([circ empty]) ([r (in-list lis)]) (list* (circle r "outline" "black") circ)))
(rad me)
(define (ovo lst)
  (for/fold ([n (square 0 0 "transparent")]) ([img (in-list lst)]) (overlay img n)))
(ovo (rad me))
(define rands (for/list ([x (in-range 1 51)]) (make-posn (random 400) (random 300))))
;; Place a size 10 star at each of those positions on a 400x300 scene.
(define (stars lst)
  (for/fold ([skibidi (empty-scene 400 300)]) ([p (in-list lst)]) (place-image (star 10 "solid" "yellow") (posn-x p) (posn-y p) skibidi)))
(stars rands)

;; part 2
(define pos (for/list ([x (in-range 10)]) (make-posn (random 400) (random 300))))
(define (hit-one? where lst)
  (for/fold ([meth #f]) ([p (in-list lst)]) (or (and (= (posn-x where) (posn-x p)) (= (posn-y where) (posn-y p))) meth)))
(hit-one? (make-posn 1 1) pos)

#;(define (eliminate where lst)
  (cond [(empty? lst) empty]
        [(equal? (first lst) where) (eliminate where (rest lst))]
        [else (list* (first lst) (eliminate where (rest lst)))]))
(define (eliminate where lst)
  (reverse (for/fold ([meth empty]) ([p (in-list lst)]) (if (and (= (posn-x where) (posn-x p)) (= (posn-y where) (posn-y p))) meth (list* p meth)))))
(define test (list (make-posn 0 0) (make-posn 0 1) (make-posn 1 0) (make-posn 1 1) (make-posn 0 0) (make-posn 0 1) (make-posn 1 0) (make-posn 1 1)))
#;(eliminate (make-posn 0 0) test)
(eliminate (make-posn 0 0) pos)
(define (total-posn lst)
  (for/fold ([meth (make-posn 0 0)]) ([p (in-list lst)]) (make-posn (+ (posn-x p) (posn-x meth)) (+ (posn-y p) (posn-y meth)))))
(total-posn test)