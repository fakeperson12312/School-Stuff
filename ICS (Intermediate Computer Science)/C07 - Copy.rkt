;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname C07) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(require "posn-util.rkt")

;; C07
;; Alec

;; 20.6.3

(define (dh m)
  (place-image/posn (circle 10 "solid" "blue") m (rectangle 300 200 "solid" "white")))

(define (variable m)
  (make-posn (random 301) (random 201)))

(define (th m)
  (variable m))

;; 20.6.4

(define (mh m x y event)
  (cond [(and (<= (posn-distance m (make-posn x y)) 10)
              (mouse=? event "button-down"))   (make-posn 600 600)]
        [else m]))

(define (win? m)
  (posn=? m (make-posn 600 600)))

(define (draw-done m)
  (overlay (overlay (text "u won" 60 "black")
                    (rectangle 300 200 "solid" "blue"))
           (dh m)))

(big-bang (make-posn 0 0)
  (on-draw dh)
  (on-tick th 1)
  (on-mouse mh)
  (stop-when win? draw-done))