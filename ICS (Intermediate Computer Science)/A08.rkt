;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 9-20-24-opener) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)

;; A08
;; Nope
"e"
"1"
(define tri(flip-vertical(rotate 180 (triangle/sas 75 90 150 "outline" "black"))))
(define tri2(overlay/align "left" "top" (square 15 "outline" "black")tri))
(define canvas (overlay/align "right" "bottom"  tri2 (rectangle 200 125 "solid" "transparent")))
(define tri3 (place-image (text  "75" 15 "black") 25 87.5 canvas))
(define tri4(place-image (text "150" 15 "black") 125 25 tri3))
(place-image (text "27deg" 15 "black") 145 57 tri4)
"2"
(define os(rotate 45 (square 120 "solid" "orange")))
(define semi(crop 0 0 20 40 (circle 20 "solid" "blue")))
(define t1(place-image semi 10 84.8528137 os))
(place-image semi 10 84.8528137 (flip-horizontal t1))
"3"
(define canvas2 (square 80 "solid" "transparent"))
(define part1(place-image (circle 20 "outline" "black")  30 30 canvas2))
(define part2(place-image (circle 20 "outline" "red")  50 30 part1))
(place-image (circle 20 "outline" "green") 40 50 part2)
"d"
"1"
(define axies (overlay (line 240 0 "black") (line 0 240 "black")))
(define c (circle 80 "outline" "green"))
(define p1 (circle 5 "solid" "yellow"))
(define p2 (circle 1 "solid" "yellow"))
(define point (overlay p2 p1))
(place-image point 170 100 (overlay c axies))
