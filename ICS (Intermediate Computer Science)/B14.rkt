;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname B14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
;; Section 13.2


;; 13.2.3
(define (is-nintendo? str)
  (string=? str "nintendo"))
(check-expect (is-nintendo? "nintendo") true)
(check-expect (is-nintendo? "nintend") false)

;; 13.2.4
(define (empty-string? str)
  (string=? str ""))
(check-expect (empty-string? "") true)
(check-expect (empty-string? "d") false)

;; 13.2.5
(define (in-first-half? str)
  (string<? str "n"))
(check-expect (in-first-half? "a") true)
(check-expect (in-first-half? "z") false)

;; Section 13.3


;; 13.3.3
(define (may-drink? int)
  (>= int 21))
(check-expect (may-drink? 20) false)
(check-expect (may-drink? 21) true)
(check-expect (may-drink? 22) true)

;; 13.3.4
(define (under-a-dollar? int)
  (< int 1))
(check-expect (under-a-dollar? 1) false)
(check-expect (under-a-dollar? 1.49) false)
(check-expect (under-a-dollar? 0.5) true)

;; 13.3.5

;; Section 13.4
(define (is-17? int)
  (= int 17))
(check-expect (is-17? 17) true)
(check-expect (is-17? 18) false)

;; 13.4.1
(define (much-older? int int2)
  (>= (+ int -10) int2))
(check-expect (much-older? 20 9) true)
(check-expect (much-older? 20 10) true)
(check-expect (much-older? 20 11) false)

;; 13.4.2
(define (within-distance? x y d)
  (<= (sqrt (+ (* x x) (* y y))) d))
(check-expect (within-distance? 3 4 5) true)
(check-expect (within-distance? 3 4 4) false)
(check-expect (within-distance? 3 4 6) true)

;; Section 13.5


;; 13.5.1
(define (is-green-triangle? img)
  (image=? img (triangle 10 "solid" "green")))
(check-expect (is-green-triangle? (triangle 10 "solid" "green")) true)
(check-expect (is-green-triangle? (triangle 10 "solid" "blue")) false)

;; Section 13.7


;; 13.7.3
(define (teenage? age)
  (and (>= age 13) (< age 20)))
(check-expect (teenage? 13) true)
(check-expect (teenage? 20) false)
(check-expect (teenage? 19) true)

;; 13.7.4
(define (negative-or-over-100? num)
  (or (< num 0) (> num 100)))

;; 13.7.5
(define (may-drive? age)
  (>= age 16))
(define (may-drive-but-not-drink? age)
  (text (string-append "Your ability to drink is (t is true, f is false):" (substring (format "~a" (may-drink? age)) 1 2) " and your ability to drive is (t is true, f is false):" (substring (format "~a" (may-drive? age)) 1 2)) 20 "black"))
#;(may-drive-but-not-drink? 20)

;; 13.7.6
#;(define (win-craps? int)
    (text (string-append "it's a " (number->string int)) 20 "black")) ;; what else was i supposed to do
(define (win-craps? int)
  (or (= int 7) (= int 11)))
#; (win-craps? 7)

;; 13.7.7
(define (roll_dice _)
  (+ 1 (random 6)))
(define (play-craps _)
  (win-craps? (+ (roll_dice 69) (roll_dice 69))))
#; (play-craps 69)

;; 13.7.8
(define (not-13? num)
  (not (= num 13)))

;; 13.7.9
(define (not-single-letter? str)
  (not (string-length str)))

;; 13.7.10
(define (over-65-or-teenage? age)
  (or (> age 65) (teenage? age)))

;; 13.7.11
(define (lose-craps? num)
  (not (win-craps? num)))

;; 13.7.12
(define (is-not-red-square? img)
  (not (= img (rectangle (image-height img) (image-width img) "solid" "red")))) ;; ik that i switched height and width but it should be the same if square

;; 13.7.13
(define (any-two-same-pics? img1 img2 img3)
  (or (image=? img1 img2) (image=? img3 img2) (image=? img1 img3)))
