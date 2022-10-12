;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lista6-EmersonDoNascimentoRodrigues-C) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;; ========================================================================
;;                        DEFINIÇÕES DE DADOS
;; ========================================================================  

;; CONSTANTES:
(define PULA_VEZ -1)
(define COMPRA2 -2)
(define INVERTE -3)
(define CURINGA -5)
(define CURINGA_COMPRA4 -4)

;; -----------------
;; TIPO CARTA:
;; -----------------
(define-struct carta (cor valor))  
;; Um elemento do conjunto Carta é
;;   (make-carta c v)     onde
;;   c : String, é a cor da carta, que pode ser "azul", "verde", "amarelo", "vermelho" ou "preto" ou "livre"
;;   v : Número, é o valor da carta, que pode ser qualquer inteiro entre 0 e 9,
;;               ou um número negativo -1 (PulaVez), -2 (Compra2), -3 (Inverte),-4 (Compra4) ou -5 (Curinga)




;; ========================================================================
;;                         FUNÇÕES - Use se quiser
;; ========================================================================

;; jogada-válida? : Carta Carta -> Booleano
;; Objetivo: Dada uma carta da mao e uma da mesa, nesta ordem,
;; verifica se é possível a carta da mão, de acordo com as regras do UNO
;; Exemplos:
;;    (jogada-válida? (make-carta "azul" 3) (make-carta "azul" 4))=  #t 
;;    (jogada-válida? (make-carta "azul" 3) (make-carta "preto" CURINGA_COMPRA4)) = #t 
;;    (jogada-válida? (make-carta "azul" 3) (make-carta "vermelho" 4)) = #f
(define (jogada-válida? carta-mao carta-mesa)
     (cond
          ;; se a carta da mão ou a da mesa for preta, a jogada é válida
          [(or (string=? (carta-cor carta-mao) "preto") (string=? (carta-cor carta-mesa) "preto")) #t]
          ;; se as duas cartas forem da mesma cor ou do mesmo tipo/valor, a jogada é válida
          [(or (string=? (carta-cor carta-mesa)(carta-cor carta-mao))
               (= (carta-valor carta-mesa) (carta-valor carta-mao))) #t]
          ;; senão, a jogada é inválida
          [else #f] )) 

;; desenha-carta : Carta -> Imagem
;; Objetivo: A função cria uma imagem para a carta que é recebida de entrada
;; Exemplos:
;;     (desenha-carta (make-carta "azul" 3) devolve a imagem da carta de UNO azul 3
;;     (desenha-carta (make-carta "preto" CURINGA_COMPRA4)) devolve a imagem da carta de UNO curinga compra4
(define (desenha-carta carta)
  (overlay ;; sobrepor:    
              (desenha-texto (carta-valor carta))     ;; texto da carta,
              (circle 45 "solid" "white")             ;; círculo branco, 
              (rectangle 100 150 "solid" (cor carta)) ;; retângulo da cor da carta, e  
              (rectangle 110 160 "outline" "black"))) ;; contorno preto



;; desenha-texto: Número -> Imagem
;; Dado um valor, desenha uma imagem de carta de UNO correspondendo a este valor
;; Exemplos:
;;     (desenha-texto 3) devolve a imagem do número 3
;;     (desenha-texto CURINGA_COMPRA4)) devolve a imagem +4
(define (desenha-texto valor)
  (text (cond ;; escolher o símbolo a ser desenhado, dependendo do valor:
               [(= valor CURINGA_COMPRA4) "+4"]
               [(= valor COMPRA2)         "+2"]
               [(= valor INVERTE)         "«"]
               [(= valor PULA_VEZ)        "Ø"]
               [(= valor CURINGA)         "T"]
               [else (number->string valor)])
        ;; o texto será desenhado em tamanho 70 em preto
        70 "black"))



;; cor : Carta -> String
;; Objetivo: a função recebe uma carta UNO, e retorna a respectiva cor
;; em ingles, ou seja, "blue", "green", "yellow", "red" ou "black".
;; Exemplos:
;; (cor? "azul") = "blue"
;; (cor? "verde") = "green"
;; (cor? "rosa") = "black"
(define (cor c)
  (cond
    [(string=? "azul" (carta-cor c)) "blue"]
    [(string=? "verde" (carta-cor c)) "green"]
    [(string=? "vermelho" (carta-cor c)) "red"]
    [(string=? "amarelo" (carta-cor c)) "yellow"]
    [else "black"]))



;; ========================================================================
;;                                 QUESTÕES
;; =========================================================================

;; Todas as funções recursivas devem ter o modelo da solução (pode haver mais casos,
;; dependendo de como o problema está sendo solucionado):

;; Dados ....
;; Se <é o caso base da definição da lista> então <definir como resolver este caso>
;; Se <não é o caso base>
;;    então  <combinar>
;;              <fazer algo com> <o primeiro elemento da lista>
;;              <solucionar o problema para> <o resto da lista>

;; ========================================================================
;;                                 QUESTÃO 1
;; =========================================================================

;; --------------------
;; TIPO LISTA DE CARTAS:
;; --------------------


;; -----------------
;; TIPO JOGADOR:
;; -----------------
(define-struct jogador (nome mão pontos))
;; Um elemento do conjunto Jogador é
;;   (make-jogador ....)     onde
;;  ...

(define Emerson (make-jogador "Emerson"
                         (cons (make-carta "verde" 1)
                               (cons (make-carta "verde" 1)
                                     (cons (make-carta "verde" 1)
                                           (cons (make-carta "verde" 1) empty)))) 4))

(define Matheus (make-jogador "Matheus"
                         (cons (make-carta "vermelho" 1)
                               (cons (make-carta "verde" 2)
                                     (cons (make-carta "azul" 3)
                                           (cons (make-carta "amarelo" 4) empty)))) 10))


(check-expect Emerson (make-jogador "Emerson"
                         (cons (make-carta "verde" 1)
                               (cons (make-carta "verde" 1)
                                     (cons (make-carta "verde" 1)
                                           (cons (make-carta "verde" 1) empty)))) 4))

(check-expect Matheus (make-jogador "Matheus"
                         (cons (make-carta "vermelho" 1)
                               (cons (make-carta "verde" 2)
                                     (cons (make-carta "azul" 3)
                                           (cons (make-carta "amarelo" 4) empty)))) 10))


;; ========================================================================
;;                                 QUESTÃO 2
;; ========================================================================
;; Nesta questão você não deve incluir testes com check-expect, deixe apenas
;; chamadas da sua função.

;; desenha-cartas: ........

;; Pode-se colocar o modelo antes da definição da função:

;; Dada uma lista de cartas L
;; Se L é a lista vazia então <definir como resolver este caso>
;; Se <não é o caso base>
;;    então  <combinar>
;;              <fazer algo com> <o primeiro elemento da lista>
;;              a imagem das cartas do resto da lista L

;; Ou colocar permeado ao código:

(define (desenha-cartas L)
   ;;Dada uma lista de cartas L
  (cond
       ;; Se L é a lista vazia então <definir como resolver este caso>
       [(empty? L) empty-image]
       ;; Se <não é o caso base>
       ;;    então  <combinar>
       
                       ;; <fazer algo com> <o primeiro elemento da lista>
                      
                       ;; a imagem das cartas do resto da lista L
       [else (beside (desenha-carta (first L)) (desenha-cartas (rest L)))]))
                            
                              

(desenha-cartas (cons (make-carta "vermelho" 1)
                      (cons (make-carta "azul" 2) 
                                           (cons (make-carta "amarelo" 4) empty))))

;; ========================================================================
;;                                 QUESTÃO 3
;; ========================================================================

(define (número-opções L carta-mesa)
  (cond

    [(empty? L) false]

    [(jogada-válida? (first L) carta-mesa) 1]

    [else (+ (first L) (número-opções (rest L) carta-mesa))]))

;; ========================================================================
;;                                 QUESTÃO 4
;; ========================================================================

(define (soma-pontos L)
       (cond

         [(empty? L) 0]
         
         [(> (carta-valor (first L)) 0) (carta-valor (first L))]

         [(equal? (or (or (equal? (carta-valor (first L)) -1) (equal? (carta-valor (first L)) -2)) (equal? (carta-valor (first L)) -3)) L) 20]
 
         [(or (equal? (carta-valor (first L)) -4) (equal? (carta-valor (first L)) -5)) 50]

         [else (+ (carta-valor (first L)) (soma-pontos (carta-valor (rest L))))]))
         

;; ========================================================================
;;                                 QUESTÃO 5
;; ========================================================================

(define (define-jogada jogador carta-mesa)
  (cond
    [(empty? (jogador-mão jogador)) "Impossível jogar carta!"]

    [(jogada-válida? (first (jogador-mão jogador)) carta-mesa) (first (jogador-mão jogador))]

    [(equal? (jogada-válida? (first (jogador-mão jogador)) carta-mesa) (not true))

     (define-jogada (make-jogador (jogador-nome jogador) (rest (jogador-mão jogador)) (jogador-pontos jogador)) carta-mesa)]))

(check-expect (define-jogada Emerson (make-carta "verde" 1)) (make-carta "verde" 1))
(check-expect (define-jogada Emerson (make-carta "azul" 2)) "Impossível jogar carta!")


         
;; ========================================================================
;;                                 QUESTÃO 6 (Desafio)
;; =========================================================================
;; Nesta questão você não deve incluir testes com check-expect, deixe apenas
;; chamadas da sua função.

