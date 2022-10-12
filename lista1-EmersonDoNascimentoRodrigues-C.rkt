;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lista1-EmersonDoNascimentoRodrigues-C) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
 
;;;;;;;;;;;; EMERSON DO NASCIMENTO RODRIGUES
;;;;;;;;;;;; LISTA 01

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 1 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Item a

(/ (+ 5 3) 4)

;; Item b

(- (sqrt 9) 1)

;; Item c

(+ (sin (/ pi 2)) 1)

;; Item d

(* (- (sqrt (expt 5 4)) (log e)) (/ 1 12))

;; Item e

(/ (+ -4 (sqrt (- (expt 4 2) (* (* 4 2) -16)))) (* 2 2))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 2 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(define (area-circulo raio)
;;  (* pi (raio * raio)))

;;(define (volume-cilindro r a)
;;  (* (area-Circulo raio) a))

;; SUA RESPOSTA AQUI E ATENTE QUE TUDO QUE NÃO FOR INTERPRETÁVEL PELO
;; DR RACKET DEVE ESTAR *** COMENTADO *** COMO ESTA LINHA

(define (area-circulo raio) (* pi (* raio raio)))

(area-circulo 3) ;Teste

(define (volume-cilindro raio a) (* (area-circulo raio) a))

(volume-cilindro 3 2) ;Teste

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 3 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (bhaskara a b c) (/ (+  (- b) (sqrt (- (expt b 2) (* (* 4 a) c)))) (* 2 a)))

(bhaskara 2 4 -16) ;Teste

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 4 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (calcula-TMB p a i f) (* (-  (+ 66.5 (* 13.75 p) (* 5.0 a)) (* 6.8 i)) f))

(calcula-TMB 70 170 18 1.3) ;Teste