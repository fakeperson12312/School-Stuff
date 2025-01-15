;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B22) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
;1

(define (change x y)
  (* 10 (+ 1 (random 2))))

(define recta(beside (square 150 "solid" "red") (square 150 "solid" "green")))
;2


(define (lose n)
  (cond
    [(= (- n 200) 20) (overlay/align "left" "middle" (text "L" 40 "black") recta)]
        [(= (- n 200)  10) (overlay/align "right" "middle" (text "L" 40 "black") recta )]
        ))



(define (win n)
  (cond
    [(= (- n 100) 10) (overlay/align "left" "middle" (text "W" 40 "black") recta)]
    [(= (- n 100) 20) (overlay/align "right" "middle" (text "W" 40 "black") recta)]
    ))



(define (loseorwin n)
  (cond [(> n 200)
         (lose n)]
        [(> n 100)
         (win n)]
        [else empty-image]))

(define (drawandstop x)
  (overlay (loseorwin x) (overlay (text
                                   (cond
                   [(= (remainder x 20) 0) "Target: green"]
                   [else "Target: red"]) 50 "black") recta )))

;3

(define (redgreen model x)
  (or (and (= model 10)
           (<= x 150))
      (and (= model 20)
           (>= x 150))))

(define (click model x y event)
  (cond [(and (string=? event "button-down") (redgreen model x)) (+ model 100)]
        [(string=? event "button-down") (+ model 200)]
        [else model]
        ))

;4
(define (stop? n)
  (> n 20))

;5

(big-bang (* 10 (+ 1 (random 2)))
  (on-draw drawandstop)
  (on-key change)
  (stop-when stop? drawandstop)
  (on-mouse click))

