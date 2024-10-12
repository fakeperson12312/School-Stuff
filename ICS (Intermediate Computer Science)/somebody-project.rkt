;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname alec_o_project) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(require "posn-utils.rkt")
(define (radians x) (* (/ pi 180) x))
(define cube-model
  (overlay (square 40 "outline" "black") (place-image (rectangle 27 8 "solid" "cyan") 20 28 (place-image (rectangle 9 9 "solid" "cyan") 29 13 (place-image (rectangle 9 9 "solid" "cyan") 11 13 (square 40 "solid" "yellow"))))))
;the player model
cube-model
(define-struct hb (hx hy hx1 hy1 hx2 hy2 hx3 hy3 bx by hx4 hy4 hx5 hy5 hx6 hy6))
;manages all the hitboxes in one structure so that I don't have to rewrite my code each time I add a new hitbox
(define-struct gdv (s y e c h r dj cam a hb))
;the main structure for the game, s determines the x-coordinate of the cube and crops the image from the left, y determines the computer y-coordinate of the cube, e determine the height of waht the cube is on if it can be stood on,
;c determines if the player clicked, h determines if the player is holding, r determines the rotation of the cube, dj (down jump) determines if the cube is falling, cam is how high the camera is, a is the attempt counter, and hb is the hitbox struct
(define start-game (make-gdv 0 980 0 #false #false 0 #false 0 1 (make-hb 800 970 1200 970 1245 970 1550 970 1595 975 1642 970 1687 970 1732 970)))
;an example structure
(define (ar g) (cond [(or (>= 45 (remainder (real->int (gdv-r g)) 360)) (<= 315 (remainder (real->int (gdv-r g)) 360))) 0]
                     [(>= 45 (abs (- 90 (remainder (real->int (gdv-r g)) 360)))) 90]
                     [(>= 45 (abs (- 180 (remainder (real->int (gdv-r g)) 360)))) 180]
                     [(>= 45 (abs (- 270 (remainder (real->int (gdv-r g)) 360)))) 270]))
;decides what side the cube should land on when it hits the ground
(define (jump g) (cond [(and (boolean=? (gdv-dj g) #true) (< (- (gdv-y g) 1) (- 980 (gdv-e g)) (+ (gdv-y g) 1)) (boolean=? (gdv-h g) #true)) (make-gdv (+ 2 (gdv-s g)) (- 980 (gdv-e g)) (gdv-e g) #true (gdv-h g) (ar g) #false (gdv-cam g) (gdv-a g) (gdv-hb g))]
                       [(and (boolean=? (gdv-dj g) #true) (< (- (gdv-y g) 1) (- 980 (gdv-e g)) (+ (gdv-y g) 1))) (make-gdv (+ 2 (gdv-s g)) (- 980 (gdv-e g)) (gdv-e g) #false (gdv-h g) (ar g) #false (gdv-cam g) (gdv-a g) (gdv-hb g))]
                       [(and (boolean=? (gdv-dj g) #true) (> 870 (- (- 980 (gdv-y g)) (gdv-e g)))) (make-gdv (+ 2 (gdv-s g)) (+ (gdv-y g) (- 2.3 (/ (- (- 980 (gdv-e g)) (gdv-y g)) 90))) (gdv-e g) (gdv-c g) (gdv-h g) (+ 0.5 (gdv-r g)) #true (gdv-cam g) (gdv-a g) (gdv-hb g))]
                       [(boolean=? (gdv-dj g) #true) (make-gdv (+ 2 (gdv-s g)) (+ (gdv-y g) (- 2.3 (/ (- (- 980 (gdv-e g)) (gdv-y g)) 180))) (gdv-e g) (gdv-c g) (gdv-h g) (+ 0.25 (gdv-r g)) #true (gdv-cam g) (gdv-a g) (gdv-hb g))]
                       [(and (boolean=? #true (gdv-c g)) (> (- (- 980 (gdv-y g)) (gdv-e g)) 120)) (make-gdv (+ 2 (gdv-s g)) (- (gdv-y g) (- 2.3 (/ (- (- 980 (gdv-e g)) (gdv-y g)) 90))) (gdv-e g) (gdv-c g) (gdv-h g) (+ 0.5 (gdv-r g)) #true (gdv-cam g) (gdv-a g) (gdv-hb g))]
                       [(boolean=? #true (gdv-c g)) (make-gdv (+ 2 (gdv-s g)) (- (gdv-y g) (- 2.3 (/ (- (- 980 (gdv-e g)) (gdv-y g)) 90))) (gdv-e g) (gdv-c g) (gdv-h g) (+ 0.5 (gdv-r g)) (gdv-dj g) (gdv-cam g) (gdv-a g) (gdv-hb g))]
                       [else (make-gdv (+ 2 (gdv-s g)) (gdv-y g) (gdv-e g) (gdv-c g) (gdv-h g) (gdv-r g) (gdv-dj g) (gdv-cam g) (gdv-a g) (gdv-hb g))]))
;a helper function for the tick-handler that helps decide what to do when a player has clicked the mouse, dictating how the jump physics should work at any given point
(define (spike-hitbox-s hx hy x y) (and (< (- hy 7) y (+ hy 17)) (< (- hx 7) (+ x 200) (+ hx 7))))
;helper function for a spike-hitbox with one point
(define (block-hitbox-s-k hx hy x y) (and (< (- hy 25) y (+ hy 25)) (< (- hx 25) (+ x 200) (+ hx 25))))
;helper function for a block-kill-hitbox with one point
(define (spike-hitbox hx hy x y r) (or (spike-hitbox-s hx hy x y)
                                       (spike-hitbox-s hx hy (+ x (* 20 (cos (radians (- r))))) (- y (* 20 (sin (radians (- r))))))
                                       (spike-hitbox-s hx hy (- x (* 20 (cos (radians (- 270 r))))) (+ y (* 20 (sin (radians (- 270 r))))))
                                       (spike-hitbox-s hx hy (+ x (* 20 (cos (radians (- 90 r))))) (- y (* 20 (sin (radians (- 90 r))))))
                                       (spike-hitbox-s hx hy (+ x (* (* 20 (sqrt 2)) (cos (radians (- 315 r))))) (+ y (* (* 20 (sqrt 2)) (sin (radians (- 315 r))))))
                                       (spike-hitbox-s hx hy (- x (* 20 (cos (radians (- 180 r))))) (+ y (* 20 (sin (radians (- 180 r))))))
                                       (spike-hitbox-s hx hy (+ x (* (* 20 (sqrt 2)) (cos (radians (- 45 r))))) (- y (* (* 20 (sqrt 2)) (sin (radians (- 45 r))))))
                                       (spike-hitbox-s hx hy (- x (* (* 20 (sqrt 2)) (cos (radians (- 225 r))))) (+ y (* (* 20 (sqrt 2)) (sin (radians (- 225 r))))))
                                       (spike-hitbox-s hx hy (- x (* (* 20 (sqrt 2)) (cos (radians (- 135 r))))) (- y (* (* 20 (sqrt 2)) (sin (radians (- 135 r))))))))
;creates an accurate hitbox around (s+200, y) using 9 points to create a close approximation of a square, and checks if any of them have collided with the spike
(define (block-hitbox-k hx hy x y r) (or (block-hitbox-s-k hx hy x y)
                                         (block-hitbox-s-k hx hy (+ x (* 12 (cos (radians (- r))))) (- y (* 12 (sin (radians (- r))))))
                                         (block-hitbox-s-k hx hy (- x (* 12 (cos (radians (- 270 r))))) (+ y (* 12 (sin (radians (- 270 r))))))
                                         (block-hitbox-s-k hx hy (+ x (* 12 (cos (radians (- 90 r))))) (- y (* 12 (sin (radians (- 90 r))))))
                                         (block-hitbox-s-k hx hy (+ x (* (* 12 (sqrt 2)) (cos (radians (- 315 r))))) (+ y (* (* 12 (sqrt 2)) (sin (radians (- 315 r))))))
                                         (block-hitbox-s-k hx hy (- x (* 12 (cos (radians (- 180 r))))) (+ y (* 12 (sin (radians (- 180 r))))))
                                         (block-hitbox-s-k hx hy (+ x (* (* 12 (sqrt 2)) (cos (radians (- 45 r))))) (- y (* (* 12 (sqrt 2)) (sin (radians (- 45 r))))))
                                         (block-hitbox-s-k hx hy (- x (* (* 12 (sqrt 2)) (cos (radians (- 225 r))))) (+ y (* (* 12 (sqrt 2)) (sin (radians (- 225 r))))))
                                         (block-hitbox-s-k hx hy (- x (* (* 12 (sqrt 2)) (cos (radians (- 135 r))))) (- y (* (* 12 (sqrt 2)) (sin (radians (- 135 r))))))))
;creates a smaller hitbox around the player to make sure that the palyer does not die when they are standing on a block, but die if they run into one
(define (block-hitbox-e hx hy x y) (and (or (<= (- hx 25) (+ x 180) (+ hx 25)) (<= (- hx 25) (+ x 200) (+ hx 25)) (<= (- hx 25) (+ x 220) (+ hx 25))) (<= (- hy 26) (+ y 20) (- hy 24))))
;helper function that checks if the player is standing on a block
(check-expect (block-hitbox-e 1975 975 1768 930) #true)
(define (hh g) (cond [(or 
                       (spike-hitbox (hb-hx (gdv-hb g)) (hb-hy (gdv-hb g)) (gdv-s g) (gdv-y g) (gdv-r g))
                       (spike-hitbox (hb-hx1 (gdv-hb g)) (hb-hy1 (gdv-hb g)) (gdv-s g) (gdv-y g) (gdv-r g))
                       (spike-hitbox (hb-hx2 (gdv-hb g)) (hb-hy2 (gdv-hb g)) (gdv-s g) (gdv-y g) (gdv-r g))
                       (spike-hitbox (hb-hx3 (gdv-hb g)) (hb-hy3 (gdv-hb g)) (gdv-s g) (gdv-y g) (gdv-r g))
                       (block-hitbox-k (hb-bx (gdv-hb g)) (hb-by (gdv-hb g)) (gdv-s g) (gdv-y g) (gdv-r g))
                       (spike-hitbox (hb-hx4 (gdv-hb g)) (hb-hy4 (gdv-hb g)) (gdv-s g) (gdv-y g) (gdv-r g))
                       (spike-hitbox (hb-hx5 (gdv-hb g)) (hb-hy5 (gdv-hb g)) (gdv-s g) (gdv-y g) (gdv-r g))
                       (spike-hitbox (hb-hx6 (gdv-hb g)) (hb-hy6 (gdv-hb g)) (gdv-s g) (gdv-y g) (gdv-r g))) ;determines if the player is dead
                      (make-gdv 0 980 0 #false #false 0 #false 0 (+ (gdv-a g) 1) (make-hb 800 970 1200 970 1245 970 1550 970 1595 975 1642 970 1687 970 1732 970))] ;adds 1 to the attempt counter
                     [(and (not (block-hitbox-e (hb-bx (gdv-hb g)) (hb-by (gdv-hb g)) (gdv-s g) (gdv-y g))) (<= (- 980 (gdv-y g)) (gdv-e g)) (> (gdv-e g) 0))
                      (jump (make-gdv (gdv-s g) (gdv-y g) 0 (gdv-c g) (gdv-h g) (gdv-r g) #true (gdv-cam g) (gdv-a g) (gdv-hb g)))]
                     [(block-hitbox-e (hb-bx (gdv-hb g)) (hb-by (gdv-hb g)) (gdv-s g) (gdv-y g))
                      (jump (make-gdv (gdv-s g) (gdv-y g) (- 1000 (- (hb-by (gdv-hb g)) 25)) (gdv-c g) (gdv-h g) (gdv-r g) (gdv-dj g) (gdv-cam g) (gdv-a g) (gdv-hb g)))]
                     [else (jump g)]))
;decides if the player has hit an obstacle and died, is on top of a block, or if it should just resort to (jump g)
(define (update-camera g n) (make-gdv (gdv-s g) (gdv-y g) (gdv-e g) (gdv-c g) (gdv-h g) (gdv-r g) (gdv-dj g) n (gdv-a g) (gdv-hb g)))
(define (th g) (cond [(> (- 980 (gdv-y g)) (+ (gdv-cam g) 140)) (hh (update-camera g (+ (gdv-cam g) 1)))]
                     [(< (- 980 (gdv-y g)) (+ (gdv-cam g) 80)) (hh (update-camera g (max (- (gdv-cam g) 1) 0)))]
                     [else (hh g)]))
;changes the camera depending on how high the player is
(define (dh g) (crop-top
                (crop-bottom
                 (crop-left
                  (place-image (rectangle 10 24 "outline" "red") 800 975 ;visualized spike hitbox
                               (place-image (circle 5 "solid" "black") (+ (+ (gdv-s g) 200) (* 20 (cos (radians (- 90 (gdv-r g)))))) (- (gdv-y g) (* 20 (sin (radians (- 90 (gdv-r g))))))
                                            (place-image (circle 5 "solid" "black") (+ (+ (gdv-s g) 200) (* (* 20 (sqrt 2)) (cos (radians (- 45 (gdv-r g)))))) (- (gdv-y g) (* (* 20 (sqrt 2)) (sin (radians (- 45 (gdv-r g)))))) ;shows two points where the player's hitbox is calculated to check if they are working properly
                                                         (place-image (text (string-append "Attempt " (number->string (gdv-a g))) 60 "black") 400 900
                                                                      (place-image (overlay (square 50 "outline" "white") (square 50 "solid" "black")) (hb-bx (gdv-hb g)) (hb-by (gdv-hb g))
                                                                                   (place-image (isosceles-triangle 100 50 "solid" "black") (hb-hx6 (gdv-hb g)) (+ (hb-hy6 (gdv-hb g)) 30)
                                                                                                (place-image (isosceles-triangle 100 50 "solid" "black") (hb-hx5 (gdv-hb g)) (+ (hb-hy5 (gdv-hb g)) 30)
                                                                                                             (place-image (isosceles-triangle 100 50 "solid" "black") (hb-hx4 (gdv-hb g)) (+ (hb-hy4 (gdv-hb g)) 30)
                                                                                                                          (place-image (isosceles-triangle 100 50 "solid" "black") (hb-hx3 (gdv-hb g)) (+ (hb-hy3 (gdv-hb g)) 30)
                                                                                                                                       (place-image (isosceles-triangle 100 50 "solid" "black") (hb-hx2 (gdv-hb g)) (+ (hb-hy2 (gdv-hb g)) 30)
                                                                                                                                                    (place-image (isosceles-triangle 100 50 "solid" "black") (hb-hx1 (gdv-hb g)) (+ (hb-hy1 (gdv-hb g)) 30)
                                                                                                                                                                 (place-image (isosceles-triangle 100 50 "solid" "black") (hb-hx (gdv-hb g)) (+ (hb-hy (gdv-hb g)) 30) ;places the respective shape at each spike/block hitbox
                                                                                                                                                                              (place-image
(rotate (- (gdv-r g)) cube-model) (+ 200 (gdv-s g)) (gdv-y g) ;places the cube model
                                                                                                                                                                                           (beside (empty-scene 1999 1000) (crop-right (empty-scene 1999 1000) (- 1999 (gdv-s g))))))))))))))))) (gdv-s g)) (gdv-cam g)) (- 750 (gdv-cam g)))) ;changes s and the camera
;places down the player and a spike at every hitbox, as well as an attempt counter at the top-left, and crops the background based on s, which causes the level to move forward
(define (mh g x y event) (cond [(string=? event "button-up") (make-gdv (gdv-s g) (gdv-y g) (gdv-e g) (gdv-c g) #false (gdv-r g) (gdv-dj g) (gdv-cam g) (gdv-a g) (gdv-hb g))]
                               [(string=? event "button-down") (make-gdv (gdv-s g) (gdv-y g) (gdv-e g) #true #true (gdv-r g) (gdv-dj g) (gdv-cam g) (gdv-a g) (gdv-hb g))]
                               [else g]))
;checks if the player has clicked, released, or held the mouse and changes the variables c and h accordingly
(define (stop? g) (> (gdv-s g) 1700))
;stops the game so that you don't have to wait for 10 seconds after you pass the first 4 jumps
(big-bang start-game
  (on-tick th 0.003)
  (on-mouse mh)
  (stop-when stop?)
  (to-draw dh))
(overlay (circle (exact->inexact (* 25 (sqrt 2))) "outline" "black") (square 50 "outline" "black") (rotate 45 (square 50 "outline" "black")))
(dh start-game)
;helped me visualize how to rotate the hitbox points to make them accurate to the player
(check-within (+ 200 (* (* 20 (sqrt 2)) (cos (radians (- 45 0))))) 220 0.01)
(check-within (- 980 (* 20 (sin (radians (- 90 0))))) 960 0.01)
