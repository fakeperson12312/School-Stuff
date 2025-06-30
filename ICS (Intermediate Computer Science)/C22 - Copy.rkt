;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname C22) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require picturing-programs)
(define (count-div n k)
  (cond [(= 0 (remainder n k)) 1]
        [else 0]))

(define (count-divisors n)
  (count-div-help n 1))

(define (count-div-help n k)
  (cond [(= n k) 1]
        [(= 0 (remainder n k)) (+ 1 (count-div-help n (+ k 1)))]
        [else (count-div-help n (+ k 1))]))
(check-expect (count-divisors 5) 2)
(check-expect (count-divisors 4) 3)
(check-expect (count-divisors 9) 3)
(check-expect (count-divisors 12) (* 3 2)) 

(define (smallest-factor n)
  (fac-sh n 2))

(define (fac-sh n k)
  (cond [(= 0 (remainder n k)) k]
        [else (fac-sh n (+ k 1))]))
(check-expect (smallest-factor 20) 2)
(check-expect (smallest-factor 7) 7)
(check-expect (smallest-factor 15) 3)
(check-expect (smallest-factor 361) 19)

(define (is-prime? n)
  (cond [(= (count-divisors n) 2) #true]
        [else #false]))
(check-expect (is-prime? 5) #true)
(check-expect (is-prime? 4) #false)
(check-expect (is-prime? 48) #false)
(check-expect (is-prime? 50) #false)

(define (largest-prime-factor n)
  (plh n n))
(define (plh n k)
  (cond [(< k 2) "ERROR (ur not skibdi)"]
    [(and (= 0 (remainder n k)) (is-prime? k)) k]
        [else (plh n (- k 1))]))
(check-expect (largest-prime-factor 2) 2)
(check-expect (largest-prime-factor 10) 5)
(check-expect (largest-prime-factor 1) "ERROR (ur not skibdi)")
(check-expect (largest-prime-factor 202) 101)

(define (group-3 s)
  (cond [(>= 3 (string-length s)) s]
        [else (string-append (substring s 0 3) " " (group-3 (substring s 3)))]))

(check-expect (group-3 "pancake") "pan cak e")
(check-expect (group-3 "skibidi") "ski bid i")
(check-expect (group-3 "sigma") "sig ma")
(check-expect (group-3 "ohioan") "ohi oan")
(check-expect (group-3 "wyrpg") "wyr pg")
