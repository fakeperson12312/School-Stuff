;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A05) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
"print 1a"
(define whitespace (text " " 15 "white"))
(define e1 (ellipse 45 35 "solid" "darkgreen"))
(define e2 (ellipse (+ (image-width e1) 30) (+ (image-height e1) 12) "solid" "yellow"))
(define e3 (ellipse (+ (image-width e2) 30) (+ (image-height e2) 12) "solid" "green"))
(define c (circle (image-width e3) "outline" "purple" ))
;e1
;(overlay e1 e2)
;(overlay e1 e2 e3)
(overlay e1 e2 e3 c)
whitespace
"print 1b"
whitespace
(define re (scale 2 (rectangle 30 80 "solid" "blue")))
(define ce (circle (/ (image-width re) 2) "solid" "red"))
(overlay/xy ce 0 30 re)
"Problem 2 in comments"
;;Name: arguments -> output
;; centipede: int number -> image ;a
;; scale-and-blur: image number number number -> image ;b
;; image-rs: number image number -> image ;c
;; bullsye: number number number color color -> image ;d
;; add-words: string string string -> num ;e
;; repeat-word: string int -> string ;f
;; image-product: image int -> int ;g
"Problem 3 also in comments"
#|
(beside green-circle red-triangle)
(beside blue-square red-triangle)
;This is the code that's not going to be ruled out
and it should print out the green circle next to the red triangle,
then a blue square next to a red triangle
|#
"Problem 4"
"a"
(define r (rotate 15 (rectangle 75 5 "solid" "black" )))
(define ci (circle 40 "outline" "blue"))
(overlay r ci)
"b"
(define el (ellipse 25 80 "solid" "pink"))
(define sq (square 40 "solid" "blue"))
(beside/align "bottom" el sq)
(beside/align "top" sq el)
"Problem 5"
(name->color "orange")
(name->color "violet")
(name->color "hotpink")
"Problem 6"
(define troll (scale 0.5(bitmap "trollface.png")))
(above (beside troll troll) (beside troll troll))
"Problem 7"
"a"
(define pic1 (scale 0.75(bitmap "random.png")))
(define pic2 (scale 0.5 (bitmap "random2.png")))
(beside pic1 pic2)
"b"
(define result 
(beside  (overlay/align "left" "top" (text "LOW QUALITY" 30 "black") pic1)
(rectangle 30 30 "outline" "transparent")
         (overlay/align "right" "bottom" (text "HIGH QUALITY" 30 "black")pic2)))
result
"c"
(save-image result "result.png")

"Problem 8"
(define random_image (bitmap/url "https://picsum.photos/seed/picsum/200/300"));random image online
(crop-bottom random_image 50)
(crop-top random_image 20)
(crop-left random_image 35)
(crop-right random_image 60)