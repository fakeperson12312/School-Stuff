;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname D20) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
#;(require "posn-util.rkt")
(define (posn-add p q)
  (make-posn (+ (posn-x p) (posn-x q)) (+ (posn-y p) (posn-y q))))
(define (add-posns p q) (posn-add p q))
(define-struct piece (team loc))
(define-struct game (board player mouse))
(require racket/base)
(define (vblock n img)
  (if (= n 1) img (above img (vblock (- n 1) img))))
(define (hblock n img)
  (if (= n 1) img (beside img (hblock (- n 1) img))))
(define (grid x y img)
  (if (or (= x 1) (= y 1)) img (vblock y (hblock x img))))
(define board  (grid 8 8 (overlay (square 40 "outline" "black") (square 40 "solid" "red"))))
(define (make-grid z)
  (make-posn (- (* 40 (posn-x z)) 20) (- (* 40 (posn-y z)) 20)))
(define (convert p)
  (make-posn (+ (quotient (posn-x p) 40) 1) (+ (quotient (posn-y p) 40) 1)))
(define (make-img p)
  (if (string=? (piece-team p) "white")
      (circle 20 "solid" "white")
      (circle 20 "solid" "black")))
(define (draw-all pieces)
  (if (empty? pieces)
      board
      (place-image (make-img (first pieces))
                   (posn-x (make-grid (piece-loc (first pieces))))
                   (posn-y (make-grid (piece-loc (first pieces))))
                   (draw-all (rest pieces)))))
(define (dh game)
  (draw-all (game-board game)))

(define (in-bound? pos)
  (and (>= (posn-x pos) 1)
       (<= (posn-x pos) 8)
       (>= (posn-y pos) 1)
       (<= (posn-y pos) 8)))
(define (occupied? pos pieces)
  (cond
    [(empty? pieces) #false]
    [(and (= (posn-x (piece-loc (first pieces))) (posn-x pos))
          (= (posn-y (piece-loc (first pieces))) (posn-y pos))) #true]
    [else (occupied? pos (rest pieces))]))
(define (find-piece pieces pos)
  (cond
    [(empty? pieces) #false]
    [(and (= (posn-x (piece-loc (first pieces))) (posn-x pos))
          (= (posn-y (piece-loc (first pieces))) (posn-y pos)))
     (first pieces)]
    [else (find-piece (rest pieces) pos)]))

(define (cca board player next dir accum)
  (if (not (in-bound? next))
      empty
      (if (not (occupied? next board))
          empty
          (if (string=? (piece-team (find-piece board next)) player)
              (if (empty? accum) empty (reverse accum))
              (cca board player (add-posns next dir) dir (cons next accum))))))
(define (cc board player pos dir)
  (if (not (in-bound? (add-posns pos dir)))
      empty
      (if (not (occupied? (add-posns pos dir) board))
          empty
          (if (string=? (piece-team (find-piece board (add-posns pos dir))) player)
              empty
              (cca board player (add-posns pos dir) dir empty)))))
(define (flips-for-move board player pos directions)
  (if (empty? directions)
      empty
      (append (cc board player pos (first directions))
              (flips-for-move board player pos (rest directions)))))
(define (legal-move? board player pos directions)
  (not (empty? (flips-for-move board player pos directions))))
(define (flip-board board flip-positions new-team)
  (if (empty? board)
      empty
      (if (member (piece-loc (first board)) flip-positions)
          (cons (make-piece new-team (piece-loc (first board)))
                (flip-board (rest board) flip-positions new-team))
          (cons (first board)
                (flip-board (rest board) flip-positions new-team)))))
(define specialpos (list (make-posn 0 1)
                   (make-posn -1 1)
                   (make-posn 0 -1)
                   (make-posn -1 -1)
                   (make-posn -1 0)
                   (make-posn 1 -1)
                   (make-posn 1 1)
                   (make-posn 1 0)))

(define all-cells
  (for*/list ([i (in-range 1 9)]
              [j (in-range 1 9)])
    (make-posn i j)))
(define (legal? board team cells)
  (cond
    [(empty? cells) #false]
    [else 
     (if (and (not (occupied? (first cells) board))
              (legal-move? board team (first cells) specialpos))
         #true
         (legal? board team (rest cells)))]))
(define (any-legal-move? board team)
  (legal? board team all-cells))

(define (mmh game new-board new-pos)
  (make-game (flip-board new-board
                          (flips-for-move new-board (game-player game) new-pos specialpos)
                          (game-player game))
             (if (string=? (game-player game) "white") "black" "white")
             new-pos))
(define (make-move game new-pos)
  (if (legal-move? (game-board game) (game-player game) new-pos specialpos) (mmh game (cons (make-piece (game-player game) new-pos) (game-board game)) new-pos) game))
(define (posn=? a b)
  (and (= (posn-x a) (posn-x b)) (= (posn-y a) (posn-y b))))
(define (checkinlst n lst)
  (cond [(empty? lst) #f]
        [(posn=? n (piece-loc (first lst))) #t]
        [else (or #f (checkinlst n (rest lst)))]))
(define (mh game x y event)
  (if (and (string=? "button-down" event) (not (checkinlst (convert (make-posn x y)) (game-board game))))
      (make-move game (convert (make-posn x y)))
      game))
(define (previousplace mouse img player)
  (if (string=? player "white")
      (place-image (circle 20 "solid" (make-color 255 255 255 100))
                   (posn-x (make-grid mouse)) (posn-y (make-grid mouse)) img)
      (place-image (circle 20 "solid" (make-color 0 0 0 50))
                   (posn-x (make-grid mouse)) (posn-y (make-grid mouse)) img)))
(define (dh2 game)
  (previousplace (game-mouse game) (dh game) (game-player game)))

(define (tick game)
  (if (not (any-legal-move? (game-board game) (game-player game))) (make-game (game-board game) (if (string=? (game-player game) "white") "black" "white") (game-mouse game)) game))

(define (stop? game)
  (or (>= (length (game-board game)) 64)
      (and (not (any-legal-move? (game-board game) "white"))
           (not (any-legal-move? (game-board game) "black")))))
(define (count-team pieces team)
  (if (empty? pieces)
      0
      (if (string=? (piece-team (first pieces)) team)
          (+ 1 (count-team (rest pieces) team))
          (count-team (rest pieces) team))))
(define (won game)
  (define white-count (count-team (game-board game) "white"))
  (define black-count (count-team (game-board game) "black"))
  (cond
    [(> white-count black-count)
     (text (string-append "White wins! " (number->string white-count)
                          " to " (number->string black-count)) 40 "black")]
    [(> black-count white-count)
     (text (string-append "Black wins! " (number->string black-count)
                          " to " (number->string white-count)) 40 "black")]
    [else (text "Tie!" 40 "black")]))
    
(big-bang 
 (make-game (list (make-piece "white" (make-posn 4 4))
                  (make-piece "white" (make-posn 5 5))
                  (make-piece "black" (make-posn 5 4))
                  (make-piece "black" (make-posn 4 5)))
            "black"
            (make-posn -1 -1))
 (on-draw dh2)
 (on-mouse mh)
 (on-tick tick)
 (stop-when stop? won)
 (name "Reversi"))