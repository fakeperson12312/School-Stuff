;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname C08) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(define start (make-posn (random 401) (random 401)))
(define lose (make-posn 666 666))
(define win (make-posn 6969 6969))
(define back (empty-scene 400 400))
(define (kh m k)
  (cond [(string=? k "r") start]
        [(string=? k "q") (make-posn 666 6969)]
        [(string=? k "w") (make-posn 6969 6969)]
        [(string=? k "i") (make-posn (posn-x m) (+ -3 (posn-y m)))]
        [(string=? k "j") (make-posn (+ -3 (posn-x m)) (posn-y m))]
        [(string=? k "k") (make-posn (posn-x m) (+ 3 (posn-y m)))]
        [(string=? k "l") (make-posn (+ 3 (posn-x m)) (posn-y m))]
        [else m]))
(define (dh m)
  (place-image (square 5 "solid" "darkblue") (posn-x m) (posn-y m) back))
(define (stop? m)
  (cond [(= 666 (posn-x m)) #true]
        [(= 6969 (posn-x m)) #true]
        [else false]))
(define (mod n)
  (modulo n 400))
(define (rand n m)
  (cond [(= n 0) (make-posn (mod (abs (posn-x m))) (mod (abs (+ 3 (posn-y m)))))]
        [(= n 1) (make-posn (mod (abs (posn-x m))) (mod (abs (- 3 (posn-y m)))))]
        [(= n 2) (make-posn (mod (abs (+ 3 (posn-x m)))) (mod (abs (posn-y m))))]
        [(= n 3) (make-posn (mod (abs (- 3 (posn-x m)))) (mod (abs (posn-y m))))]
        [(= n 4) (make-posn (mod (abs (+ 3 (posn-x m)))) (mod (abs (+ 3 (posn-y m)))))]
        [(= n 5) (make-posn (mod (abs (+ 3 (posn-x m)))) (mod (abs (- 3 (posn-y m)))))]
        [(= n 6) (make-posn (mod (abs (- 3 (posn-x m)))) (mod (abs (+ 3 (posn-y m)))))]
        [(= n 7) (make-posn (mod (abs (- 3 (posn-x m)))) (mod (abs (- 3 (posn-y m)))))]
        [else m]))
#;(define (th m)
  (cond [(and (< (posn-x m) 395) (> (posn-x m) 5) (> (posn-y m) 5) (< (posn-x m) 395)) (rand (random 8) m)]
        [(>= (posn-x m) 395)]))
(define (th m)
  (rand (random 8) m))
(define (mh m x y e)
  (cond [(and (> 5 (abs (- y (posn-y m))))
              (> 5 (abs (- x (posn-x m))))
              (mouse=? e "button-down"))
         (make-posn 6969 6969)]
        [else m]))
(define (stoppe m)
  (cond [(= (posn-x m) 6969) (overlay (text "u won" 20 "blue") (square 400 "solid" "green"))]
        [else (overlay (text "u lost" 20 "black") (square 400 "solid" "red"))]))
(big-bang start
  (on-draw dh)
  (on-key kh)
  (stop-when stop? stoppe)
  (on-mouse mh)
  (on-tick th 0.01))
