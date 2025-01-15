;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B23) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
;; 1
(define (white-christmas? water? temperature)
  (and water? (< temperature 32)))
(check-expect (white-christmas? true 32) false)
(check-expect (white-christmas? true 31) true)
(check-expect (white-christmas? true 33) false)
(check-expect (white-christmas? false 31) false)

;; 2
;; It'll show ACE when y is true and x is 29
;; It'll show BETA when y is false
;; It'll show CROW when y us true and x is 30 (or beyond)

;; 3
(define (q3 m x y e)
  (cond [(and (string=? e "button-down") (> x 200)) -10]
        [(and (string=? e "button-down") (< x 200)) -20]
        [else m]))

;; Animation
;; Notes for myself: modulo by 100, only num model from 10 to 90
(define (win? model)
  (> model 1000))
(define (lose? model)
  (and (> model 100) (< model 1000)))
(check-expect (lose? 110) true)
(check-expect (lose? 100) false)
(check-expect (win? 1090) true)
(define bg (empty-scene 100 100))
(define (win num) (overlay (above (text "WIN" 15 "black") (text (number->string (modulo num 100)) 15 "black")) bg))
(define (play num)(overlay (above (text "PLAY" 15 "black") (text (number->string (modulo num 100)) 15 "black")) bg))
(define (lose num)(overlay (above (text "LOSE" 15 "black") (text (number->string (modulo num 100)) 15 "black")) bg))
(define (dh model)
  (cond [(win? model) (win model)]
        [(lose? model) (lose model)]
        [else (play model)]))
(define (kh model key)
  (* 10 (+ 1 (random 9))))
(define (should-stop? model)
  (> model 100))
(define (last_one model)
  (cond [(win? model) (win model)]
        [(lose? model) (lose model)]
        [else (play model)]))
(define (mh model x y event)
  (cond [(and (string=? event "button-down") (> x 50)) (+ model 1000)]
        [(and (string=? event "button-down") (<= x 50)) (+ model 100)]
        [else model]))
#;(define (dh1 model)
  (cond [(win? model) (win model)]
        [(lose? model) (lose model)]
        [else model]))
(big-bang (kh 69 69)
  (to-draw dh)
  (on-mouse mh)
  (on-key kh)
  (stop-when should-stop?))