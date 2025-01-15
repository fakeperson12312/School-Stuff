;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#;(enable picturing-programs) 
#;(require-picturing programs)
;; lol that was the memes from one time
(require picturing-programs)

(define f 20)
;; kh1: model key -> model
;; mh1: model num num event -> model
(define starter (overlay (text "A" f "black") (circle f "solid" "yellow") (rectangle 1000 600 "outline" "black")))
#;(define (dh1 img)
    (rectangle 500 300 "outline" "black") #;(rectangle 500 300 "outline" "transparent"))
(define (kh1 model key)
  (overlay (text "A" f "black") (circle f "solid" "yellow") (rectangle 1000 600 0 "transparent")))
(define (mh1 model x y event)
  (overlay (text "A" (max 20 (min 255 (quotient (+ x y) 6))) "black") (circle (max 20 (min 255 (quotient (+ x y) 6))) "solid" "yellow") (rectangle 1000 600 0 "transparent")))
;; BELOW IS THE BIG BANG FUNCTION
#;(big-bang starter
    (on-draw show-it)
    (on-key kh1)
    (on-mouse mh1))

;; inner: model -> model
(define (inner img k)
  (overlay (scale 0.9 img) img))
;; corners: model -> model
(define (corners img) (overlay/align "left" "bottom" img (overlay/align "left" "top" img (overlay/align "right" "top" img (overlay/align "right" "bottom" img (rectangle 300 200 "solid" "white"))))))
;; BELOW IS THE BIG BANG FUNCTION
#;(big-bang (circle 50 "outline" "black")
    (on-key inner)
    (on-draw corners))
#;(define cars (rectangle 30 10 "outline" "black"))
#;(define (movec mouse)
  (beside(square mouse 0 "solid" "transparent") cars))
#;(define truck (flip-horizontal (beside (rectangle 20 10 "outline" "black") (square 10 "outline" "black"))))
#;(define (movet mouse)
  (beside truck (square mouse 0 "solid" "transparent")))
#;(define start_3 (empty-scene 500 300))
#;(define (spacey key x)
  (overlay/align "left" "middle"
                 (above cars (rectangle 0 10 "solid" "transparent"))
                 (overlay/align "right" "middle"
                                (above (rectangle 0 10 "solid" "transparent") truck)
                                (rectangle 500 300 "outline" "transparent"))))
#;(define (mousey model x y event)
  (+ x 20))

#;(define (move x)
    (+ x 1))
#;(define (blue-squares x)
    (overlay/align "left" "bottom"
                   (above (square 20 "solid" "blue")
                          (rectangle 0 x "solid" "transparent"))
                   (overlay/align "right" "top"
                                  (above
                                   (rectangle 0 x "solid" "transparent")
                                   (square 20 "solid" "blue"))
                                  (empty-scene 300 200))))
#;(define (crash x)
  (overlay/align "left" "middle"
                 (beside (rectangle x 0 "solid" "transparent") cars)
                 (overlay/align "right" "middle"
                                (beside truck (rectangle x 0 "solid" "transparent"))
                                (rectangle 500 300 "outline" "transparent"))))

#;(big-bang 0 
    (to-draw blue-squares)
    (on-tick move 0.1))
;; BELOW IS THE BIG BANG FUNCTION
#;(big-bang 0
  #;(on-draw crash)
  (to-draw crash)
  #;(on-draw )
  (on-key spacey)
  (on-mouse mousey))


(define c (rectangle 100 50 "solid" "blue"))
(define t (beside (rectangle 25 50 "solid" "red")
                  (square 5 "solid" "transparent")
                  (rectangle 100 50 "solid" "red")))
(define (cars img)
  (overlay/align "right" "top" (beside img (rectangle (image-width c) (image-height c) "solid" "transparent"))
                                       c))
(define (train img)
  (overlay/align "left" "bottom" t (beside (rectangle (image-width t) (image-height t) "solid" "transparent")
                                              img)))
                                           
(define (dh1 img)
  (overlay/align "left" "middle"
                 (cars img)
                 (overlay/align "right" "middle"
                                (train img)
                                (rectangle 400 300
                                           "outline"
                                           "black"))))
;; key handler model key -> model
(define (kh2 img key)
  (above img (square 150 "solid" "transparent")))            
;; mouse handler: model x y event -> model
(define push (square 3 "solid" "transparent"))
(define (mh2 img x y event)
  (beside img push))
;; BELOW IS THE BIG BANG FUNCTION
#;(big-bang push
  (on-mouse mh2)
  (to-draw dh1)
  (on-key kh2))
(define mountain (beside (rotate -90 (triangle/sas 100 90 300 "solid" "green"))
                         (flip-horizontal (rotate -90 (triangle/sas 100 90 300 "solid" "green")))))

(above/align "left"
             (beside (rectangle 90 30 "solid" "transparent")
                            (text "Mountain Top" 30 "black"))
             mountain)

(define sun(circle 60 "solid" "orange"))
(define sky(rectangle 300 100 "solid" "skyblue"))
(define psc(above (rectangle 0 60 "solid" "transparent") (crop-bottom sun 20)))
(above psc sky)