;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B16) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)


;; 1
(define (add10 x)
  (+ x 10))
(define (stop x)
  (or (< x 0) (>= x 150)))
(define (reset10 model x y event)
  10)
(define (stopkey model key) -10)
(define (cir x)
  (overlay (circle x "solid" "red") (square 300 "solid" "white")))

#;(big-bang 10
  (on-tick add10 1)
  (on-key stopkey)
  (on-mouse reset10)
  (on-draw cir)
  (stop-when stop))

;; 2
(define (progbar x) (overlay/align "left" "middle" (rectangle (max 0 x) 200 "solid" "blue") (rectangle 1000 200 "outline" "black")))
(define (growidth model x y event)
  x)
(define (stop1 x) (>= x 1000))
(define (done x) (cond [(> x 990) (overlay (text "DONE" 50 "red") (rectangle (max 1000 x) 200 "solid" "blue"))]))
(define (sub100 x key)
  (cond [(string=? key "a") (max 0 (- x 100))] 
        ([string=? key "q"] 1001)
        (else x)))

#;(big-bang 0
  (on-draw progbar)
  (on-mouse growidth)
  (on-key sub100)
  (stop-when stop1 done))

;; Typewriter
;; im not sure if its extra credit