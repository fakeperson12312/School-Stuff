;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname D06) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(require picturing-programs)
#; (require struct-plus-plus)
#; (struct++ stamp (id p a?))
(define-struct stamp (id p a?))
(define (set-stamp-p m p)
  (make-stamp (stamp-id m) p (stamp-a? m)))
(define (set-stamp-a? m a?)
  (make-stamp (stamp-id m) (stamp-p m) a?))
#; (define (make-stamp a b c) (stamp a b c))
(define (dh m)
  (place-image (circle 20 (cond [(stamp-a? m) "solid"]
                           [else "outline"]) "blue") (posn-x (stamp-p m)) (posn-y (stamp-p m)) (empty-scene 300 300)))
(define (mh m x y e)
  (cond [(string=? e "button-down") (set-stamp-p m (make-posn x y))]
        [else m]))
#;(define (rh model msg)
    (cond [(string=? (msg-from msg) (stamp-id model)) (set-stamp-a? model #t)]
          [else (set-stamp-a? model #f)]))
(define (rh model msg)
  (cond [(string=? msg (stamp-id model)) (set-stamp-a? model #t)]
        [else (set-stamp-a? model #f)]))
(define (kh m k)
  (cond [(string=? "1" k) (make-package m "1")]
        [(string=? "2" k) (make-package m "2")]
        [(string=? "3" k) (make-package m "3")]
        [(string=? "4" k) (make-package m "4")]
        #;[(string=? "q") ]
        [else m]))
(define (startbang title initial)
  (big-bang initial
    (name title)
    (on-draw dh)
    (on-mouse mh)
    (on-receive rh)
    (on-key kh)
    (register LOCALHOST)))
(launch-many-worlds
 (startbang "1" (make-stamp "1" (make-posn 150 150) #t))
 (startbang "2" (make-stamp "2" (make-posn 150 150) #f))
 (startbang "3" (make-stamp "3" (make-posn 150 150) #f))
 (startbang "4" (make-stamp "4" (make-posn 150 150) #f)))