;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname normalfile) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;run the program for about a minute for the full experience
;dedicated to REDACTED
(require picturing-programs)
(require rnrs/base-6)
(define normalimage (bitmap/url "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/d703fc3a-23e5-41ca-a298-2fe7856c8d95/da8zjlf-38fecb77-7c63-4ca0-b31f-fdc549c6e874.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcL2Q3MDNmYzNhLTIzZTUtNDFjYS1hMjk4LTJmZTc4NTZjOGQ5NVwvZGE4empsZi0zOGZlY2I3Ny03YzYzLTRjYTAtYjMxZi1mZGM1NDljNmU4NzQucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.i3uCuySvI2putCUghaw2dz01OxhgblTKDpz8vs4yqQs"))
(define (imgtest x) (scale x normalimage))
(define-struct js (x acc img))
(define (th js) (cond [(> (js-acc js) 6) (make-js (max (+ (js-x js) (/ (- 1 (mod (js-acc js) 2)) 10)) 0.01) (+ 0.03 (js-acc js)) (place-image
                                                                                                                                  (imgtest 0.2)
                                                                                                                                  (random 1601)
                                                                                                                                  (random 1101)
                                                                                                                                  (place-image
                                                                                                                                   (imgtest (js-x js))
                                                                                                                                   (- 1600 (* (js-x js) 225))
                                                                                                                                   (- 1100 (* (js-x js) 187.5))
                                                                                                                                   (place-image
                                                                                                                                    (imgtest (js-x js))
                                                                                                                                    (* (js-x js) 225)
                                                                                                                                    (- 1100 (* (js-x js) 187.5))
                                                                                                                                    (place-image
                                                                                                                                     (imgtest (js-x js))
                                                                                                                                     (- 1600 (* (js-x js) 225))
                                                                                                                                     (* (js-x js) 187.5)
                                                                                                                                     (place-image
                                                                                                                                      (imgtest (js-x js))
                                                                                                                                      (* (js-x js) 225)
                                                                                                                                      (* (js-x js) 187.5) (js-img js)))))))]
                      [(> (js-acc js) 4) (make-js (max (+ (js-x js) (/ (- 1 (mod (js-acc js) 2)) 10)) 0.01) (+ 0.03 (js-acc js)) (place-image
                                                                                                                                  (imgtest 0.2)
                                                                                                                                  (random 1601)
                                                                                                                                  (random 1101)
                                                                                                                                  (place-image
                                                                                                                                   (imgtest (js-x js))
                                                                                                                                   (* (js-x js) 225)
                                                                                                                                   (- 1100 (* (js-x js) 187.5))
                                                                                                                                   (place-image
                                                                                                                                    (imgtest (js-x js))
                                                                                                                                    (- 1600 (* (js-x js) 225))
                                                                                                                                    (* (js-x js) 187.5)
                                                                                                                                    (place-image
                                                                                                                                     (imgtest (js-x js))
                                                                                                                                     (* (js-x js) 225)
                                                                                                                                     (* (js-x js) 187.5) (js-img js))))))]
                      [(> (js-acc js) 2) (make-js (max (+ (js-x js) (/ (- 1 (mod (js-acc js) 2)) 10)) 0.01) (+ 0.03 (js-acc js)) (place-image
                                                                                                                                  (imgtest (js-x js))
                                                                                                                                  (- 1600 (* (js-x js) 225))
                                                                                                                                  (* (js-x js) 187.5)
                                                                                                                                  (place-image
                                                                                                                                   (imgtest (js-x js))
                                                                                                                                   (* (js-x js) 225)
                                                                                                                                   (* (js-x js) 187.5) (js-img js))))]
                      [else (make-js (max (+ (js-x js) (/ (- 1 (mod (js-acc js) 2)) 10)) 0.01) (+ 0.03 (js-acc js)) (place-image (imgtest (js-x js)) (* (js-x js) 225) (* (js-x js) 187.5) (js-img js)))]))
(define (dh js) (js-img js))
(define (imgtest1 js) (bitmap/url "https://www.allion.com/wp-content/uploads/2020/12/BSOD.png"))
(define (crashed? js) (> (js-acc js) 8))
(big-bang (make-js 0.02 0.01 (rectangle 1600 1100 "solid" "black"))
  (on-tick th 0.02)
  (stop-when crashed? imgtest1)
  (to-draw dh))