;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lista4-EmersonDoNascimentoRodrigues-C) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;; Nome: EMERSON DO NASCIMENTO RODRIGUES

;; ========================================================================
;; QUESTÃO 1
;; =========================================================================

;; obj: Definir constantes que representam as cartas especiais

;; Constantes:

;; PULA VEZ
(define PULA_VEZ 10)

;; COMPRA 2 CARTAS
(define COMPRA2 11)

;; INVERTE
(define INVERTE 12)

;; CURINGA
(define CURINGA 13)

;; COMPRA 4 CARTAS
(define CURINGA_COMPRA4 14)

;; ========================================================================
;; QUESTÃO 2
;; =========================================================================

;; -----------------
;; TIPO CARTA:
;; -----------------

;; Carta: String Número -> Carta
;; obj: Recebe uma string que representa uma cor e um número que representa um valor, para assim construir uma carta com a cor e o valor passados. 

(define-struct carta (cor valor))

;; Um elemento do conjunto Carta é
;;      (make-carta cor valor) onde
;;      cor: String, é a cor da carta, que pode ser "azul", "verde", "amarelo", "vermelho", "preto" ou "livre"
;;      valor: Número, é o valor numérico da carta, que para cartas normais vai de 0 a 9, de 10 a 14 para cartas especiais e 100 para LIVRE.



;; Exemplos de constantes do tipo Carta:

;; 1 da cor AZUL
(define 1_AZUL (make-carta "azul" 1))

;; 2 da cor VERDE 
(define 2_VERDE (make-carta "verde" 2))

;; PULA VEZ da cor AMARELO
(define PULA_VEZ_AMARELO (make-carta "amarelo" 10))

;; COMPRA 2 da cor VERMELHO
(define COMPRA2_VERMELHO (make-carta "vermelho" 11))


;; ========================================================================
;; QUESTÃO 3
;; ========================================================================

;; jogada-válida? : Carta Carta -> Boolean
;; obj:

;; Exemplos:
;; (jogada-válida? (make-carta "preto" 14) (make-carta "vermelho" 2)) = true
;; (jogada-válida? (make-carta "azul" 1) (make-carta "vermelho" 1)) = true
;; (jogada-válida? (make-carta "azul" 1) (make-carta "azul" 2)) = true
;; (jogada-válida? (make-carta "preto" 12) (make-carta "verde" 7)) = true
;; (jogada-válida? (make-carta "verde" 1) (make-carta "amarelo" 3)) = false

(define (jogada-válida? carta-mesa carta-mão)
                   (cond
                       ;; Se a cor da carta da mão for igual à cor da carta da mesa, então a jogada é válida
                       [(equal? (carta-cor carta-mesa) (carta-cor carta-mão)) true]
                       ;; Se o valor da carta da mão for igual à cor da carta da mesa, então a jogada é válida 
                       [(equal? (carta-valor carta-mesa) (carta-valor carta-mão)) true]
                       ;; Se a carta d mesa for preta, qualquer jogada será válida
                       [(and (string=? (carta-cor carta-mesa) "preto") (or (or (or (string=? (carta-cor carta-mão) "azul") (string=? (carta-cor carta-mão) "verde")) (string=? (carta-cor carta-mão) "vermelho")) (string=? (carta-cor carta-mão) "amarelo"))) true]
                       ;; Se nenhuma condição for atendida, a jogada será inválida
                       [else false]
                    )
  )

;; Testes:
(check-expect (jogada-válida? (make-carta "preto" 14) (make-carta "vermelho" 2)) true)
(check-expect (jogada-válida? (make-carta "azul" 1) (make-carta "vermelho" 1)) true)
(check-expect (jogada-válida? (make-carta "azul" 1) (make-carta "azul" 2)) true)
(check-expect (jogada-válida? (make-carta "preto" 12) (make-carta "verde" 7)) true)
(check-expect (jogada-válida? (make-carta "verde" 1) (make-carta "amarelo" 3)) false)

;; ========================================================================
;; QUESTÃO 4
;; ========================================================================

;; -----------------
;; TIPO MÃO:
;; -----------------

;; Mão: Carta Carta Carta Carta -> Mão
;; obj: recebe as cores e os valores de 4 cartas, para assim, montar a mão

(define-struct mão (carta_1 carta_2 carta_3 carta_4))

;; Um elemento do conjunto Mão é
;;      (make-mão carta_1 carta_2 carta_3 carta_4) onde
;;      carta_1: É a primeira carta da mão
;;      carta_2: É a segunda carta da mão
;;      carta_3: É a terceira carta da mão
;;      carta_4: É a quarta carta da mão


;; Constante LIVRE:
(define LIVRE 100)


;; Exemplos de constantes do tipo Mão:

(define MÃO_1-VERDE_2-VERMELHO_3-AMARELO_4-AZUL
                        (make-mão
                         (make-carta "verde" 1)
                         (make-carta "vermelho" 2)
                         (make-carta "amarelo" 3)
                         (make-carta "azul" 4)
                         )
  )

(define MÃO_1-VERDE_7-VERDE_4-AMARELO_4-VERDE
                        (make-mão
                         (make-carta "verde" 1)
                         (make-carta "verde" 7)
                         (make-carta "amarelo" 4)
                         (make-carta "verde" 4)
                         )
  )

(define MÃO_8-AZUL_9-VERMELHO_5-VERMELHO_LIVRE
                        (make-mão
                         (make-carta "azul" 8)
                         (make-carta "vermelho" 9)
                         (make-carta "vermelho" 5)
                         (make-carta "livre" 100)
                         )
  )

(define MÃO_7-VERDE_6-AMARELO_LIVRE_LIVRE
                        (make-mão
                         (make-carta "verde" 7)
                         (make-carta "amarelo" 6)
                         (make-carta "livre" 100)
                         (make-carta "livre" 100)
                         )
  )



;; ========================================================================
;; QUESTÃO 5
;; ========================================================================

;; Conta-Cartas: Mão -> Número
;; obj: Recebe uma mão de cartas e retorna o número de cartas que há na mão

;; Exemplos:
;; (conta-cartas (make-mão (make-carta "verde" 1) (make-carta "azul" 2) (make-carta "vermelho" 3) (make-carta "amarelo" 4))) = 4
;; (conta-cartas (make-mão (make-carta "vermelho" 4) (make-carta "azul" 8) (make-carta "verde" 9) (make-carta "livre" 100))) = 3
;; (conta-cartas (make-mão (make-carta "amarelo" 3) (make-carta "amarelo" 4) (make-carta "livre" 100) (make-carta "livre" 100))) = 2
;; (conta-cartas (make-mão (make-carta "azul" 6) (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "livre" 100))) = 1
;; (conta-cartas (make-mão (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "livre" 100))) = 0

(define (conta-cartas mão)
              (cond
                ;; Se a soma dos valores das cartas for maior ou igual a 400, não há cartas na mão
                [(>= (+ (carta-valor (mão-carta_1 mão)) (carta-valor (mão-carta_2 mão)) (carta-valor (mão-carta_3 mão)) (carta-valor (mão-carta_4 mão))) 400) 0]
                ;; Se a soma dos valores das cartas for maior ou igual a 300, há 1 carta na mão
                [(>= (+ (carta-valor (mão-carta_1 mão)) (carta-valor (mão-carta_2 mão)) (carta-valor (mão-carta_3 mão)) (carta-valor (mão-carta_4 mão))) 300) 1]
                ;; Se a soma dos valores das cartas for maior ou igual a 200, há 2 cartas na mão
                [(>= (+ (carta-valor (mão-carta_1 mão)) (carta-valor (mão-carta_2 mão)) (carta-valor (mão-carta_3 mão)) (carta-valor (mão-carta_4 mão))) 200) 2]
                ;; Se a soma dos valores das cartas for maior ou igual a 100, há 3 cartas na mão
                [(>= (+ (carta-valor (mão-carta_1 mão)) (carta-valor (mão-carta_2 mão)) (carta-valor (mão-carta_3 mão)) (carta-valor (mão-carta_4 mão))) 100) 3]
                ;; Se a soma dos valores das cartas for maior ou igual a 0, há 4 cartas na mão
                [(>= (+ (carta-valor (mão-carta_1 mão)) (carta-valor (mão-carta_2 mão)) (carta-valor (mão-carta_3 mão)) (carta-valor (mão-carta_4 mão))) 0) 4]
                )
  )

;; Teste:

(check-expect (conta-cartas (make-mão (make-carta "verde" 1) (make-carta "azul" 2) (make-carta "vermelho" 3) (make-carta "amarelo" 4))) 4)
(check-expect (conta-cartas (make-mão (make-carta "vermelho" 4) (make-carta "azul" 8) (make-carta "verde" 9) (make-carta "livre" 100))) 3)
(check-expect (conta-cartas (make-mão (make-carta "amarelo" 3) (make-carta "amarelo" 4) (make-carta "livre" 100) (make-carta "livre" 100))) 2)
(check-expect (conta-cartas (make-mão (make-carta "azul" 6) (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "livre" 100))) 1)
(check-expect (conta-cartas (make-mão (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "livre" 100))) 0)

;; ========================================================================
;; QUESTÃO 6
;; ========================================================================

;; -----------------
;; TIPO RESULTADO:
;; -----------------

;; Resultado: Carta String -> Resultado

;; define-jogada : Mão Carta -> Carta String
;; obj: Recebe uma mão e uma carta da mesa, e retorna a carta da mão que deve ser jogada e uma frase correspondente ao número de cartas que irão sobrar na mão 

;; Exemplos
;; (define-jogada (make-mão (make-carta "azul" 1) (make-carta "verde" 0) (make-carta "verde" 0) (make-carta "verde" 0)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Segue o jogo")

;; (define-jogada (make-mão (make-carta "verde" 0) (make-carta "azul" 1) (make-carta "verde" 0) (make-carta "verde" 0)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Segue o jogo")

;; (define-jogada (make-mão (make-carta "verde" 0) (make-carta "verde" 0) (make-carta "azul" 1) (make-carta "verde" 0)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Segue o jogo")

;;(define-jogada (make-mão (make-carta "verde" 0) (make-carta "verde" 0) (make-carta "verde" 0) (make-carta "azul" 1)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Segue o jogo")

;;(define-jogada (make-mão (make-carta "livre" 100) (make-carta "azul" 1) (make-carta "verde" 0) (make-carta "verde" 0)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Segue o jogo")

;;(define-jogada (make-mão (make-carta "azul" 1) (make-carta "livre" 100) (make-carta "verde" 0) (make-carta "verde" 0)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Segue o jogo")

;;(define-jogada (make-mão (make-carta "livre" 100) (make-carta "verde" 0) (make-carta "azul" 1) (make-carta "verde" 0)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Segue o jogo")

;;(define-jogada (make-mão (make-carta "livre" 100) (make-carta "verde" 0) (make-carta "verde" 0) (make-carta "azul" 1)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Segue o jogo")

;;(define-jogada (make-mão (make-carta "azul" 1) (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "verde" 0)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "UNO")

;;(define-jogada (make-mão (make-carta "livre" 100) (make-carta "azul" 1) (make-carta "livre" 100) (make-carta "verde" 0)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "UNO")

;;(define-jogada (make-mão (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "azul" 1) (make-carta "verde" 0)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "UNO")

;;(define-jogada (make-mão (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "verde" 0) (make-carta "azul" 1)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "UNO")

;;(define-jogada (make-mão (make-carta "azul" 1) (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "livre" 100)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Ganhei")

;;(define-jogada (make-mão (make-carta "livre" 100) (make-carta "azul" 1) (make-carta "livre" 100) (make-carta "livre" 100)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Ganhei")

;;(define-jogada (make-mão (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "azul" 1) (make-carta "livre" 100)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Ganhei")

;;(define-jogada (make-mão (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "azul" 1)) (make-carta "azul" 1)) = (make-resultado (make-carta "azul" 1) "Ganhei")

;;(define-jogada (make-mão (make-carta "azul" 1) (make-carta "azul" 1) (make-carta "azul" 1) (make-carta "azul" 1)) (make-carta "verde" 0)) = (make-resultado (make-carta "livre" 100) "Segue o jogo")


;; Código:

(define-struct resultado (carta_usada frase))

(define (define-jogada mão carta_mesa)
                  (cond
                    [(and (= (conta-cartas mão) 4) (jogada-válida? carta_mesa (mão-carta_1 mão))) (make-resultado (mão-carta_1 mão) "Segue o jogo")]
                    [(and (= (conta-cartas mão) 4) (jogada-válida? carta_mesa (mão-carta_2 mão))) (make-resultado (mão-carta_2 mão) "Segue o jogo")]
                    [(and (= (conta-cartas mão) 4) (jogada-válida? carta_mesa (mão-carta_3 mão))) (make-resultado (mão-carta_3 mão) "Segue o jogo")]
                    [(and (= (conta-cartas mão) 4) (jogada-válida? carta_mesa (mão-carta_4 mão))) (make-resultado (mão-carta_4 mão) "Segue o jogo")]
                    [(and (= (conta-cartas mão) 3) (jogada-válida? carta_mesa (mão-carta_1 mão))) (make-resultado (mão-carta_1 mão) "Segue o jogo")]
                    [(and (= (conta-cartas mão) 3) (jogada-válida? carta_mesa (mão-carta_2 mão))) (make-resultado (mão-carta_2 mão) "Segue o jogo")]
                    [(and (= (conta-cartas mão) 3) (jogada-válida? carta_mesa (mão-carta_3 mão))) (make-resultado (mão-carta_3 mão) "Segue o jogo")]
                    [(and (= (conta-cartas mão) 3) (jogada-válida? carta_mesa (mão-carta_4 mão))) (make-resultado (mão-carta_4 mão) "Segue o jogo")]
                    [(and (= (conta-cartas mão) 2) (jogada-válida? carta_mesa (mão-carta_1 mão))) (make-resultado (mão-carta_1 mão) "UNO")]
                    [(and (= (conta-cartas mão) 2) (jogada-válida? carta_mesa (mão-carta_2 mão))) (make-resultado (mão-carta_2 mão) "UNO")]
                    [(and (= (conta-cartas mão) 2) (jogada-válida? carta_mesa (mão-carta_3 mão))) (make-resultado (mão-carta_3 mão) "UNO")]
                    [(and (= (conta-cartas mão) 2) (jogada-válida? carta_mesa (mão-carta_4 mão))) (make-resultado (mão-carta_4 mão) "UNO")]
                    [(and (= (conta-cartas mão) 1) (jogada-válida? carta_mesa (mão-carta_1 mão))) (make-resultado (mão-carta_1 mão) "Ganhei")]
                    [(and (= (conta-cartas mão) 1) (jogada-válida? carta_mesa (mão-carta_2 mão))) (make-resultado (mão-carta_2 mão) "Ganhei")]
                    [(and (= (conta-cartas mão) 1) (jogada-válida? carta_mesa (mão-carta_3 mão))) (make-resultado (mão-carta_3 mão) "Ganhei")]
                    [(and (= (conta-cartas mão) 1) (jogada-válida? carta_mesa (mão-carta_4 mão))) (make-resultado (mão-carta_4 mão) "Ganhei")]
                    [else (make-resultado (make-carta "livre" 100) "Segue o jogo")]
                    )
  )

;; Testes:

(check-expect (define-jogada (make-mão (make-carta "azul" 1) (make-carta "verde" 0) (make-carta "verde" 0) (make-carta "verde" 0)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Segue o jogo"))

(check-expect (define-jogada (make-mão (make-carta "verde" 0) (make-carta "azul" 1) (make-carta "verde" 0) (make-carta "verde" 0)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Segue o jogo"))

(check-expect (define-jogada (make-mão (make-carta "verde" 0) (make-carta "verde" 0) (make-carta "azul" 1) (make-carta "verde" 0)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Segue o jogo"))

(check-expect (define-jogada (make-mão (make-carta "verde" 0) (make-carta "verde" 0) (make-carta "verde" 0) (make-carta "azul" 1)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Segue o jogo"))

(check-expect (define-jogada (make-mão (make-carta "livre" 100) (make-carta "azul" 1) (make-carta "verde" 0) (make-carta "verde" 0)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Segue o jogo"))

(check-expect (define-jogada (make-mão (make-carta "azul" 1) (make-carta "livre" 100) (make-carta "verde" 0) (make-carta "verde" 0)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Segue o jogo"))

(check-expect (define-jogada (make-mão (make-carta "livre" 100) (make-carta "verde" 0) (make-carta "azul" 1) (make-carta "verde" 0)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Segue o jogo"))

(check-expect (define-jogada (make-mão (make-carta "livre" 100) (make-carta "verde" 0) (make-carta "verde" 0) (make-carta "azul" 1)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Segue o jogo"))
;
;
(check-expect (define-jogada (make-mão (make-carta "azul" 1) (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "verde" 0)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "UNO"))

(check-expect (define-jogada (make-mão (make-carta "livre" 100) (make-carta "azul" 1) (make-carta "livre" 100) (make-carta "verde" 0)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "UNO"))

(check-expect (define-jogada (make-mão (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "azul" 1) (make-carta "verde" 0)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "UNO"))

(check-expect (define-jogada (make-mão (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "verde" 0) (make-carta "azul" 1)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "UNO"))
;
;
(check-expect (define-jogada (make-mão (make-carta "azul" 1) (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "livre" 100)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Ganhei"))

(check-expect (define-jogada (make-mão (make-carta "livre" 100) (make-carta "azul" 1) (make-carta "livre" 100) (make-carta "livre" 100)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Ganhei"))

(check-expect (define-jogada (make-mão (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "azul" 1) (make-carta "livre" 100)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Ganhei"))

(check-expect (define-jogada (make-mão (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "livre" 100) (make-carta "azul" 1)) (make-carta "azul" 1)) (make-resultado (make-carta "azul" 1) "Ganhei"))
;
;
(check-expect (define-jogada (make-mão (make-carta "azul" 1) (make-carta "azul" 1) (make-carta "azul" 1) (make-carta "azul" 1)) (make-carta "verde" 0)) (make-resultado (make-carta "livre" 100) "Segue o jogo"))

;

;; ========================================================================
;; QUESTÃO 7
;; ========================================================================

;; Carta-Ingles: Carta -> Carta
;; obj: Faz com que sejam aceitos nomes de cores em português

;; Desenha-Carta: Carta -> Imagem
;; obj: Cria a imagem das cartas

(define (carta-ingles carta-portugues)
                  (cond
                    ;; Se for passada a cor azul, cria a carta da cor azul
                    [(equal? (carta-cor carta-portugues) "azul") (make-carta "blue" (carta-valor carta-portugues))]
                    ;; Se for passada a cor vermelho, cria a carta da cor vermelho
                    [(equal? (carta-cor carta-portugues) "vermelho") (make-carta "red" (carta-valor carta-portugues))]
                    ;; Se for passada a cor verde, cria a carta da cor verde
                    [(equal? (carta-cor carta-portugues) "verde") (make-carta "green" (carta-valor carta-portugues))]
                    ;; Se for passada a cor amarelo, cria a carta da cor amarelo
                    [(equal? (carta-cor carta-portugues) "amarelo") (make-carta "yellow" (carta-valor carta-portugues))]
                    ;; Se for passada a cor preto, cria a carta da cor preto
                    [(equal? (carta-cor carta-portugues) "preto") (make-carta "black" (carta-valor carta-portugues))]
                    [else (make-carta (carta-cor carta-portugues) (carta-valor carta-portugues))]
                    )
  )

(define (desenha-carta carta-ingles)
                   (cond
                     [(and (>= (carta-valor carta-ingles) 0) (<= (carta-valor carta-ingles) 9))
                      (overlay
                       (text (number->string (carta-valor carta-ingles)) 30 "black")
                       (circle 23 "solid" "white")
                       (circle 23 "outline" (carta-cor carta-ingles))
                       (rectangle 50 80 "solid" (carta-cor carta-ingles))
                       (rectangle 55 85 "solid" "white")
                       (rectangle 60 90 "solid" "black")
                       )
                      ]
                     [(= (carta-valor carta-ingles) 10)
                      (overlay
                       (above (text "PULA" 15 "black") (text "VEZ" 15 "black"))
                       (circle 23 "solid" "white")
                       (circle 23 "outline" (carta-cor carta-ingles))
                       (rectangle 50 80 "solid" (carta-cor carta-ingles))
                       (rectangle 55 85 "solid" "white")
                       (rectangle 60 90 "solid" "black")
                       )
                      ]
                     [(= (carta-valor carta-ingles) 11)
                      (overlay
                       (text "+2" 25 "black")
                       (circle 23 "solid" "white")
                       (circle 23 "outline" (carta-cor carta-ingles))
                       (rectangle 50 80 "solid" (carta-cor carta-ingles))
                       (rectangle 55 85 "solid" "white")
                       (rectangle 60 90 "solid" "black")
                       )
                      ]
                     [(= (carta-valor carta-ingles) 12)
                      (overlay
                       (text "<<" 25 "black")
                       (circle 23 "solid" "white")
                       (circle 23 "outline" (carta-cor carta-ingles))
                       (rectangle 50 80 "solid" (carta-cor carta-ingles))
                       (rectangle 55 85 "solid" "white")
                       (rectangle 60 90 "solid" "black")
                       )
                      ]
                     [(and (string=? (carta-cor carta-ingles) "black") (= (carta-valor carta-ingles) 13))
                      (overlay
                       (text "CURINGA" 10 "black")
                       (circle 23 "solid" "white")
                       (circle 23 "outline" (carta-cor carta-ingles))
                       (rectangle 50 80 "solid" (carta-cor carta-ingles))
                       (rectangle 55 85 "solid" "white")
                       (rectangle 60 90 "solid" "black")
                       )
                      ]
                     [(and (string=? (carta-cor carta-ingles) "black") (= (carta-valor carta-ingles) 14))
                      (overlay
                       (text "+4" 25 "black")
                       (circle 23 "solid" "white")
                       (circle 23 "outline" (carta-cor carta-ingles))
                       (rectangle 50 80 "solid" (carta-cor carta-ingles))
                       (rectangle 55 85 "solid" "white")
                       (rectangle 60 90 "solid" "black")
                       )
                      ]
                     [(and (string=? (carta-cor carta-ingles) "livre") (= (carta-valor carta-ingles) 100))
                      (overlay
                       (text "LIVRE" 17 "black")
                       (rectangle 55 85 "solid" "white")
                       (rectangle 60 90 "solid" "black")
                       )
                      ]
                     )
  )

;; Testes:

(check-expect (carta-ingles (make-carta "vermelho" 1)) (make-carta "red" 1))
(check-expect (carta-ingles (make-carta "verde" 2)) (make-carta "green" 2))
(check-expect (carta-ingles (make-carta "azul" 3)) (make-carta "blue" 3))
(check-expect (carta-ingles (make-carta "amarelo" 4)) (make-carta "yellow" 4))
(check-expect (carta-ingles (make-carta "preto" 12)) (make-carta "black" 12))

(check-expect (desenha-carta (carta-ingles (make-carta "vermelho" 1)))
              (overlay
               (text (number->string 1) 30 "black")
               (circle 23 "solid" "white")
               (circle 23 "outline" "red")
               (rectangle 50 80 "solid" "red")
               (rectangle 55 85 "solid" "white")
               (rectangle 60 90 "solid" "black")
               )
 )
(check-expect (desenha-carta (carta-ingles (make-carta "amarelo" 10)))
              (overlay
               (above (text "PULA" 15 "black") (text "VEZ" 15 "black"))
               (circle 23 "solid" "white")
               (circle 23 "outline" "yellow")
               (rectangle 50 80 "solid" "yellow")
               (rectangle 55 85 "solid" "white")
               (rectangle 60 90 "solid" "black")
               )
 )
(check-expect (desenha-carta (carta-ingles (make-carta "azul" 11)))
              (overlay
               (text "+2" 25 "black")
               (circle 23 "solid" "white")
               (circle 23 "outline" "blue")
               (rectangle 50 80 "solid" "blue")
               (rectangle 55 85 "solid" "white")
               (rectangle 60 90 "solid" "black")
               )
 )
(check-expect (desenha-carta (carta-ingles (make-carta "verde" 12)))
              (overlay
               (text "<<" 25 "black")
               (circle 23 "solid" "white")
               (circle 23 "outline" "green")
               (rectangle 50 80 "solid" "green")
               (rectangle 55 85 "solid" "white")
               (rectangle 60 90 "solid" "black")
               )
 )
(check-expect (desenha-carta (carta-ingles (make-carta "preto" 13)))
              (overlay
               (text "CURINGA" 10 "black")
               (circle 23 "solid" "white")
               (circle 23 "outline" "black")
               (rectangle 50 80 "solid" "black")
               (rectangle 55 85 "solid" "white")
               (rectangle 60 90 "solid" "black")
               )
 )
(check-expect (desenha-carta (carta-ingles (make-carta "preto" 14)))
              (overlay
               (text "+4" 25 "black")
               (circle 23 "solid" "white")
               (circle 23 "outline" "black")
               (rectangle 50 80 "solid" "black")
               (rectangle 55 85 "solid" "white")
               (rectangle 60 90 "solid" "black")
               )
 )
(check-expect (desenha-carta (carta-ingles (make-carta "livre" 100)))
              (overlay
               (text "LIVRE" 17 "black")
               (rectangle 55 85 "solid" "white")
               (rectangle 60 90 "solid" "black")
               )
 )

;; ========================================================================
;; QUESTÃO 8 (DESAFIO)
;; =========================================================================