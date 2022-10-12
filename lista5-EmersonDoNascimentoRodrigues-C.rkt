;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lista5-EmersonDoNascimentoRodrigues-C) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;;;;;;;;;;;; EMERSON DO NASCIMENTO RODRIGUES
;;;;;;;;;;;; LISTA 5

;;; COMPLETE AS LACUNAS E FAÇA O QUE FOI PEDIDO NOS ENUNCIADOS DAS QUESTÕES

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 1 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Um elemento do conjunto   {false}OuString  é:
; 1. Boolean, ou
; 2. String

; Um elemento do conjunto NumeroOuString é:
; 1. Número, ou
; 2. String


(define-struct cidadão (nome CPF idade sexo saude? covid? comorb gravidez?))

;;Um elemento do cjto. Cidadão é uma estrutura (make-cidadão nome CPF idade sexo saude? covid? comorb gravidez?)
;;onde:
;; nome : String, é o nome do cidadão
;; CPF : Número, é o CPF do cidadão
;; idade: Número, é a idade do cidadão 
;; sexo?: Boolean, é a informação que indica se o sexo é masculino ou feminino
;; saude?: Boolean, é a informação que indica se o cidadão está trabalhando na linha de frente contra o covid
;; covid?: Boolean, é a informação que indica se o cidadão já teve covid
;; comorb: {false}OuString, é a informação que indica se o cidadão possui alguma comorbidade
;; gravidez?: Boolean, é a informação que indica se a cidadã está grávida


(define-struct imunizante (nome fabricante quantidade umaDose?))
;;Um elemento conjunto Imunizante é uma estrutura (make-imunizante nome fabricante quantidade umaDose?))
;;onde
;; nome : String, é o nome do imunizante
;; fabricante: String, é o nome do fabricante
;; quantidade: Número, é a quantidade de imunizante disponível
;; umaDose?: Boolean, se a o imunizante possui uma dose única ou não

;; exemplos de instâncias:

(define U (make-imunizante "U" "fabricante U" 5432 true))
(define A (make-imunizante "A" "fabricante A" 4321 true))
(define B (make-imunizante "B" "fabricante B" 3210 false))

(define Emerson (make-cidadão "Emerson" 00123456789 19 false false false false false))
(define Lucas (make-cidadão "Lucas" 00987654321 22 false false true false true))
(define Leila (make-cidadão "Leila" 02134657809 20 true false true false false))
(define Ana (make-cidadão "Ana" 08976453201 20 true true false false true))


;;; CRIE OUTRAS, para ambos conjuntos !!!

(define João (make-cidadão "João" 16475498765 80 false false false false false))
(define Messi (make-cidadão "Messi" 87564509213 70 false false false false false))
(define Alisson (make-cidadão "Alisson" 54634980123 60 false false false false false))
(define Edenilson (make-cidadão "Edenilson" 98749243210 50 false false false false false))
(define Kroos (make-cidadão "Kroos" 09012134356 40 false false false false false))
(define Neuer (make-cidadão "Neuer" 66666666666 15 false false false false false))
(define Neymar (make-cidadão "Neymar" 77777777777 14 false false false false false))
(define Salah (make-cidadão "Salah" 88888888888 55 false false false true false))
(define Taison (make-cidadão "Taison" 99999999999 18 false true false false false))
(define Marta (make-cidadão "Marta" 11111111111 20 true false false false true))
(define Diego (make-cidadão "Diego" "Olá" 80 false false false false false))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 2 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; checa-erro : Cidadão -> NúmeroOuString
;; dado um elemento do conjunto Cidadão, se o cidadão for do sexo feminino e estiver grávida, retorna o CPF, senão, retorna "CPF OK"

; ;; exemplos:
;


;; Corpo da função:

(define (checa-erro cidadão)
  (cond
    [(or (equal? (cidadão-sexo cidadão) false) (equal? (cidadão-gravidez? cidadão) true)) (cidadão-CPF cidadão)]
    [else "CPF OK"]
    )
 )

;; Testes:

(check-expect (checa-erro Emerson) 00123456789)
(check-expect (checa-erro Lucas) 00987654321)
(check-expect (checa-erro Leila) "CPF OK")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 3 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ;; prioridade : Cidadão -> String
; ;; dado um elemento do conjunto Cidadão, 


; exemplos:
;
;


;;Corpo da Função:

(define (prioridade cidadão)
  (cond
    [(equal? (string? (checa-erro cidadão)) true) "Dados deste CPF devem ser verificados!"]
    [(equal? (cidadão-saude? cidadão) true) "jan"]
    [(>= (cidadão-idade cidadão) 80) "fev"]
    [(>= (cidadão-idade cidadão) 70) "mar"]
    [(>= (cidadão-idade cidadão ) 60) "abr"]
    [(and (or (and (equal? (cidadão-sexo cidadão) true) (equal? (cidadão-gravidez? cidadão) true)) (or (string? (cidadão-comorb cidadão)) (equal? (cidadão-comorb cidadão) true))) (>= (cidadão-idade cidadão) 15)) "mai"]
    [(>= (cidadão-idade cidadão) 50) "jun"]
    [(>= (cidadão-idade cidadão) 40) "jul"]
    [(>= (cidadão-idade cidadão) 18) "ago"]
    [(>= (cidadão-idade cidadão) 15) "set"]
    [(<= (cidadão-idade cidadão) 14) "Aguarde novo calendário"]
    )
  )

; testes:

(check-expect (prioridade Taison) "jan")
(check-expect (prioridade Marta) "mai")
(check-expect (prioridade Messi) "mar")
(check-expect (prioridade Alisson) "abr")
(check-expect (prioridade Edenilson) "jun")
(check-expect (prioridade Salah) "mai")
(check-expect (prioridade Kroos) "jul")
(check-expect (prioridade Neuer) "set")
(check-expect (prioridade Neymar) "Aguarde novo calendário")
(check-expect (prioridade Emerson) "ago")
(check-expect (prioridade João) "fev")
(check-expect (prioridade Leila) "Dados deste CPF devem ser verificados!")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;; Exercício 4 ;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; imunizante-valido : Cidadão Imunizante -> String
;
; [escreva o objetivo aqui]


; Código:


(define (imunizante-válido? cidadão imunizante)
  (cond
     [(equal? (string? (checa-erro cidadão)) true) "Erro nos dados do cidadão!"]
     [(and (string? (cidadão-comorb cidadão)) (equal? (imunizante-nome imunizante) "U") (>= (imunizante-quantidade imunizante) 1000)) "Deve receber o imunizante!"]    
     [(and (string? (cidadão-comorb cidadão) ) (not (equal? (imunizante-nome imunizante) "U"))) "Não deve receber o imunizante!"]   
     [(and (equal? (cidadão-sexo cidadão) true) (equal? (cidadão-gravidez? cidadão) true)(equal? (imunizante-nome imunizante) "A") (>= (imunizante-quantidade imunizante) 1000)) "Deve receber o imunizante!"]
     [(and (equal? (cidadão-sexo cidadão) true) (equal? (cidadão-gravidez? cidadão) true)(not (equal? (imunizante-nome imunizante) "2"))) "Não deve receber o imunizante!"]
     [(and (< (cidadão-idade cidadão) 15) (> (cidadão-idade cidadão) 15) (equal? (imunizante-nome imunizante) "B") (>= (imunizante-quantidade imunizante) 1000)) "Deve receber o imunizante!"]
     [(and (< (cidadão-idade cidadão) 18) (> (cidadão-idade cidadão) 15)(not (equal? (imunizante-nome imunizante) "2"))) "Não deve receber o imunizante!"]
     [(>= (imunizante-quantidade imunizante) 1000)"Deve receber o imunizante!"]
     [(< (imunizante-quantidade imunizante) 1000) "Mão deve receber o imunizante!"]))


; testes:

(check-expect (imunizante-válido? Diego U) "Erro nos dados do cidadão!")
(check-expect (imunizante-válido? Salah U) "Deve receber o imunizante!")
(check-expect (imunizante-válido? Marta U) "Não deve receber o imunizante!")
