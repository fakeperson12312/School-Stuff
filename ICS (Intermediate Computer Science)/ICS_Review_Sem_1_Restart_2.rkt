;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ICS_Review_Sem_1_Restart_2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)

;; 1
(define (choose-color n)
  (cond [(= n 0) "black"]
        [(= n 1) "white"]
        [else "pink"]))
(define (point-color x y)
  (cond [(and (< x 60) (> x 0) (< y 50) (> y 0)) "yellow" ]
        [(and (> x 60) (< x 200) (< y 50) (> y 0)) "blue"]
        [(and (< x 60) (> x 0) (> y 50) (< y 150)) "green"]
        [(and (> x 60) (< x 200) (> y 50) (< y 150)) (choose-color (random 3))]
        [else "black"]))
(check-expect (point-color 100 20) "blue")

;; 2
(define (can-write? sharp? cm-left)
  (cond [(and sharp? (>= cm-left 5)) true]
        [(>= cm-left 8) true]
        [else false]))
(check-expect (can-write? true 4) false)
(check-expect (can-write? true 5) true)
(check-expect (can-write? false 8) true)

;; 3
(define (hit-rect? x y)
  (and (>= x 100) (<= x 310) (>= y 20) (<= y 150)))
(check-expect (hit-rect? (* 2 69) 69) true)
(check-expect (hit-rect? 69 (* 3 69)) false)

;; 4
(define (even-odd? n)
  (= (modulo n 2) 0))
(define (mh model x y event)
  (cond [(mouse=? "button-down" event) (add1 model)]
        [else model]))
(define (kh model key)
  (cond [(string=? key "r") (+ 10 (random 91))]
        [(string=? key "x") (* -1 model)]))
(define (dh r)
  (cond [(even-odd? (abs r)) (overlay (circle 10 "solid" "blue") (circle (abs r) "solid" "orange") (square 250 0 "transparent"))]
        [else (overlay (circle (abs r) "solid" "orange") (square 250 0 "transparent"))]))
(define (end-screen r)
  (above (text "Done" 20 "blue") (dh r)))
(define (stop? r)
  (cond [(< r 0) true]
        [else false]))
(big-bang 10
  (on-mouse mh)
  (to-draw dh)
  (on-key kh)
  (stop-when stop? end-screen))