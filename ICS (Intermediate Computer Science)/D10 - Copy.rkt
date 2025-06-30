;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname D10) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(require "D10help.rkt")
;; D10 help
;; there was a lang racket thing
#; (provide (all-defined-out))
#; (define-struct cm (from text) #:prefab)
#; (define (gcm? x)
     (and (cm? x)
          (string? (cm-from x))
          (string? (cm-text x))))

(define-struct chat (id messages convo))
(define (dhelp msgs)
  (cond [(empty? msgs) (square 0 0 "transparent")]
        [else (above/align "left"
                           (dhelp (rest msgs))
                           (text (first msgs) 25 "black"))]))

(define (dh m)
  (above (overlay/align "left" "top" (dhelp (chat-convo m)) (rectangle 500 350 "outline" "black"))
         (overlay/align "left" "middle" (text (string-append "> " (chat-messages m)) 25 "blue") (rectangle 500 50 "outline" "blue"))))

(define (kh m key)
  (cond [(string=? key "\r") (make-package (make-chat (chat-id m) "" (chat-convo m)) (string-append (chat-id m) ": " (chat-messages m)))]
        [(string=? key "\b") (make-chat (chat-id m) (if (> (string-length (chat-messages m)) 0) (substring (chat-messages m) 0 (- (string-length (chat-messages m)) 1)) "") (chat-convo m))]
        [(= (string-length key) 1) (make-chat (chat-id m)(string-append (chat-messages m) key) (chat-convo m))]
        [else m]))

(define (rh m msg)
  (make-chat (chat-id m) (chat-messages m) (list* msg (chat-convo m))))

(define (startbang title initial)
  (big-bang initial
    (name title)
    (on-draw dh)
    (register LOCALHOST)
    (on-receive rh)
    (on-key kh)))

(launch-many-worlds
 (startbang "skib" (make-chat "skib" "" '()))
 (startbang "sig" (make-chat "sig" "" '()))
 (startbang "ma" (make-chat "ma" "" '())))

