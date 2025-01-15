;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A16b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
; calendar-at-mouse : image(old-picture)
; num(x) num(y) mouse-event -> image
; Produces a picture of a calendar, with its top-left corner
; x pixels from the left and y pixels down from the top.
; Assumes x and y are both positive integers.
#;(define white-background (rectangle 500 300 "solid" "white"))
; whatever other examples you’ve come up with
#;(define (calendar-at-mouse old-picture x y mouse-event)
  ; old-picture image (ignored)
  ; x positive integer
  ; y positive integer
  ; mouse-event whatever this is (ignored)
  (place-image pic:calendar x y white-background)
  )
#;(big-bang white-background
    (on-draw show-it)
    (on-mouse calendar-at-mouse))

#;(big-bang (empty-scene 1 1)
    (on-draw show-it 500 300)
    (on-mouse calendar-at-mouse))

; move-right-10 : image -> image
#;(define (move-right-10 picture)
  ; picture image
  (beside (rectangle 10 0 "solid" "white") picture)
  )
; move-right-10-on-mouse :
; image number number mouse-event -> image
; Just like move-right-10, but takes in three
; extra parameters and ignores them.
#;(define (move-right-10-on-mouse picture x y mouse-event)
  ; picture image
  ; x number
  ; y number
  ; mouse-event whatever this is
  (move-right-10 picture)
  )
;; this code above is just code taken from the doctor racket textbook for reference
"0"
(define (draw_handle _) (rectangle 300 200 "outline" "black"))
#;(big-bang (rectangle 300 200 "outline" "black")
  (on-draw show-it))
"1"
(define (key-press sq _)
  (place-image (scale 1.5 sq) 250 250 (square 500 "solid" "transparent")))
#;(big-bang (place-image (square 50 "solid" "blue") 250 250 (square 500 "solid" "transparent"))
  (on-draw show-it)
  (on-key key-press))
"2"
(define (smaller img)
  (place-image (scale 0.9 img) 250 250 (square 500 "solid" "transparent")))

#;(big-bang (place-image (square 50 "solid" "blue") 250 250 (square 500 "solid" "transparent"))
  (on-draw show-it)
  (on-tick smaller 0.3))
"3"
#;(big-bang (place-image (square 50 "solid" "blue") 250 250 (square 500 "solid" "transparent"))
  (on-draw show-it)
  (on-tick smaller 0.3)
  (on-key key-press))
"4"
(define (reset _ -)
  (overlay (scale 2 pic:bloch) (square 500 "solid" "transparent")))
#;(big-bang (scale 2 pic:bloch)
  (on-draw show-it)
  (on-key reset))
"5"
#;(big-bang (overlay (scale 2 pic:bloch) (square 500 "solid" "transparent"))
  (on-draw show-it)
  (on-tick smaller 0.3)
  (on-key reset))
"6"
(define (print_t img txt)
  (overlay (text txt 60 "black") (square 500 "solid" "transparent")))
#;(big-bang (overlay (text "Type Something" 60 "black") (square 500 "solid" "transparent"))
  (on-draw show-it)
  (on-key print_t))
"7"
(define shape (above (circle 10 "outline" "black") (square 20 "outline" "black")))
#;(define (double img _)
  (overlay (beside img img) (square 500 "solid" "transparent")))
(define (double img ticks)
  (beside img img))
(define (draw-image img)
  (place-image img 150 100 (empty-scene 300 200)))
#;(big-bang (square 10 "outline" "blue")
  (to-draw draw-image)
  (on-key double))
#;(big-bang draw_handle
  (to-draw draw_handle)
  (on-key double))

"8"
(define (move_right img)
  (beside (square 6 0 "transparent")
          img))
#;(big-bang (square 10 "outline" "blue")
  (on-draw draw-image)
  (on-tick move_right 0.2))
"9"
"Check Comments for #9"
#;(big-bang (square 20 "outline" "blue")
  (on-draw draw-image)
  (on-tick move_right 0.2)
  (on-key double))
;; It doesn't work
;; I heard about using lists to solve it, but idk what else to do except trying to remove the extra space but that's gonna alter the movement,
;; except if i add it back somehow. 