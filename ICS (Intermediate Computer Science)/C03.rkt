;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname C03) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)

;; C03
;; Alec

;; 1
;; Keeper: model(number) -> img
;; 2
;; the model is a number, and when the model changes, the text size changes
;; 3
;; multiply the model by -1 then overlay the draw handler with the abs of the model
;; 4
(define (win-screen-draw-handler n)
  (overlay (text "yes" (abs n) "blue")
           (rectangle 400 300 "solid" "pink")))
;; 5
(define (a-ok? n)
  (and (>= (abs n) 5) (<= (abs n) 250)))
;; 6
;; The model is a number, and that function will cause the model to become an image, causing errors
;; 6 (the second #6 (for some reason there are two))
;; (check-expect (amarga-m 50 400 300 "move") 18)
;; 7
;; (check-expect (amarga-m 50 280 150 "move") 50)
;; Jan B
(define (dh n)
  (overlay n (rectangle 300 200 "solid" "orange")))
(define (dist x1 x2 y1 y2)
  (sqrt (+ (expt (- x2 x1) 2) (expt (- y2 y1) 2))))
(define (mh n x y event)
  (cond [(and (> (dist 150 x 100 y) 60) (mouse=? event "button-down") (image=? n (circle 60 "solid" "white")))   (rectangle 120 60 "solid" "white")]
        [(and (<= (dist 150 x 100 y) 60) (mouse=? event "button-down") (image=? n (circle 60 "solid" "white")))   (above (text "GAME OVER" 20 "Purple") n)] 
        [(and (or (or (> x 210) (< x 90)) (or (> y 130) (< y 70))) (mouse=? event "button-down") (image=? n (rectangle 120 60 "solid" "white"))) (above (text "GAME OVER" 20 "Purple") n)]
        [(and (and (<= x 210) (>= x 90)) (and (<= y 130) (>= y 70)) (mouse=? event "button-down") (image=? n (rectangle 120 60 "solid" "white"))) (circle 60 "solid" "white")]
        [else n]))
(big-bang (circle 60 "solid" "white")
  (on-draw dh)
  (on-mouse mh))