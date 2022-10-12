;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lista3-EmersonDoNascimentoRodrigues-C) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;;;;;;;;;;;;  EMERSON DO NASCIMENTO RODRIGUES
;;;;;;;;;;;; LISTA 3

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 1 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Pi: Número -> Número
;;; obj: Recebe um número e calcula a proporção da população que precisa ser imunizada.
;; exemplos:
; (Pi 2) retorna 0.5
; (Pi 5) retorna 0.8

;; Corpo da função:

;; Definição de constantes
(define orig 2)
(define alfa 3)
(define beta 4.5)
(define gama 4.7)
(define delta 6)
(define sarampo 14)

(define (Pi R0) (- 1 (/ 1 R0)))

(define (imunidade-coletiva virus)
               (cond
                    ;;Se a variável virus for igual a orig, retorna o cálculo de Pi com o valor da constante orig sendo o R0 
                    [(= virus orig) (* (Pi orig) 100)]
                    ;;Se a variável virus for igual a alfa, retorna o cálculo de Pi com o valor da constante alfa sendo o R0
                    [(= virus alfa) (round (* (Pi alfa) 100))]
                    ;;Se a variável virus for igual a beta, retorna o cálculo de Pi com o valor da constante beta sendo o R0
                    [(= virus beta) (round (* (Pi beta) 100))]
                    ;;Se a variável virus for igual a gama, retorna o cálculo de Pi com o valor da constante gama sendo o R0
                    [(= virus gama) (round (* (Pi gama) 100))]
                    ;;Se a variável virus for igual a delta, retorna o cálculo de Pi com o valor da constante delta sendo o R0
                    [(= virus delta) (round (* (Pi delta) 100))]
                    ;;Se a variável virus for igual a sarampo, retorna o cálculo de Pi com o valor da constante sarampo sendo o R0
                    [(= virus sarampo) (round (* (Pi sarampo) 100))]
                )
  )


;; Testes:

(check-expect (imunidade-coletiva orig) 50)
(check-expect (imunidade-coletiva alfa) 67)
(check-expect (imunidade-coletiva beta) 78)
(check-expect (imunidade-coletiva gama) 79)
(check-expect (imunidade-coletiva delta) 83)
(check-expect (imunidade-coletiva sarampo) 93) 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 2 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; eficacia: String Número -> Número
;; obj: Recebe o nome da vacina (string: A ou B) e o número de dias decorridos (Número: 14 ou 90) e retorna a eficácia da vacina nesse período.

;; exemplos:
;; (eficacia "A" 14) = 94
;; (eficacia "B" 90) = 61

;; Corpo da função:

(define (eficacia nomeDaVacina diasDecorridos)
                      (cond
                           ;;Se for passado a string "A" e o número 14, retorna 94, que é a eficácia da vacina A após 14 dias
                           [(and (string=? nomeDaVacina "A") (= diasDecorridos 14)) 94]
                           ;;Se for passado a string "A" e o número 90, retorna 78, que é a eficácia da vacina A após 90 dias
                           [(and (string=? nomeDaVacina "A") (= diasDecorridos 90)) 78]
                           ;;Se for passado a string "B" e o número 14, retorna 69, que é a eficácia da vacina A após 14 dias
                           [(and (string=? nomeDaVacina "B") (= diasDecorridos 14)) 69]
                           ;;Se for passado a string "B" e o número 14, retorna 61, que é a eficácia da vacina A após 90 dias
                           [(and (string=? nomeDaVacina "B") (= diasDecorridos 90)) 61]

                        )
  )

;; Testes:

(check-expect (eficacia "A" 14) 94)
(check-expect (eficacia "A" 90) 78)
(check-expect (eficacia "B" 14) 69)
(check-expect (eficacia "B" 90) 61)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 3 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; resposta: Número Número Número -> Número

;; obj: recebe 3 valores, x que é a proporção de pessoas que est˜ao vacinadas, R0 que é o número de pessoas que uma pessoa pode
;;contaminar em média e v que é a eficácia da vacina, e se o x for menor que 0.5, retorna Pi, segundo o R0 informado, senão,
;;retorna Re que é o número de reprodução efetiva.

;; exemplos:
;; (resposta 1.0 2 0.95) = 0.1
;; (resposta 0.4 2 0.85) = 0.5

(define (Re R0 x v) (* R0 (- 1 (* x v))))

(define (resposta x R0 v)
                (cond
                     ;;Se x for menor que 0.5, retorna Pi
                     [(< x 0.5) (Pi R0)]
                     ;;Senão, retorna Re
                     [else (Re R0 x v)]
                  )
  )

;; Testes:

(check-expect (resposta 1.0 2 0.95) 0.1)
(check-expect (resposta 0.4 2 0.85) 0.5)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 4 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; calcula-TMB: Número Número Número Número Boolean -> Número
;; obj: recebe 5 valores, o peso, a altura, a idade, um fator multiplicativo e um valor booleano,se o booleano for true,
;; retorna o resultado do cálculo da taxa metabólica basal para mulheres, se for false, retorna o cálculo para homens.

;; exemplos:
;; (calcula-TMB 70 170 18 1.35 false) = 2371.41
;; (calcula-TMB 70 170 18 1.3 true) = 1246.57

(define (calcula-TMB p a i f boolean)
                      (cond
                           ;;Se na variável boolean for passado o valor false, retorna o resultado do cálculo da taxa metabólica basal para homens
                           [(boolean=? boolean false) (* (-  (+ 66.5 (* 13.75 p) (* 5.0 a)) (* 6.8 i)) f)]
                           ;;Se na variável boolean for passado o valor true, retorna o resultado do cálculo da taxa metabólica basal para mulheres
                           [(boolean=? boolean true) (* (-  (+ 65.5 (* 9.6 p) (* 1.8 a)) (* 4.7 i)) f)]
                        ))


;; Testes:

(check-expect (calcula-TMB 70 170 18 1.35 false) 2371.41)
(check-expect (calcula-TMB 70 170 18 1.3 true) 1246.57)