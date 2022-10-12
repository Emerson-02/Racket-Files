;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lista7-EmersonDoNascimentoRodrigues-C) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")) #f)))
;; Nome: Emerson do Nascimento Rodrigues
;; Lista 7

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

;; --------------------
;; TIPO LISTA DE CARTAS:
;; --------------------
;; Uma ListaDeCartas é
;; 1. vazia (empty), ou
;; 2. (cons c lc), onde 
;;        c: Carta;
;;       lc: ListaDeCartas

;; --------------------
;; TIPO LISTA DE NUMEROS:
;; --------------------
;; Uma ListaDeNumeros é
;; 1. empty, ou
;; 2. (cons n ln), onde 
;;        n: Numero;
;;       ln: ListaDeNumeros

;; =========================================================================
;;                                 QUESTÃO 1
;; =========================================================================

;; cria-cartas: String ListaDeNumeros -> ListaDeCartas

;; Obj: Dada uma cor e uma lista de números, cria uma lista de cartas com a cor passada.


;; Exemplos:

;; (cria-cartas "verde" empty) -> empty

;; (cria-cartas "verde" (cons 1
;;                          (cons 2
;;                           (cons 3
;;                            (cons 4
;;                             (cons 5
;;                              (cons 6
;;                                empty)))))))-> (cons
;;                                                (make-carta "verde" 1)
;;                                                 (cons
;;                                                  (make-carta "verde" 2)
;;                                                  (cons
;;                                                   (make-carta "verde" 3)
;;                                                   (cons
;;                                                    (make-carta "verde" 4)
;;                                                    (cons
;;                                                     (make-carta "verde" 5)
;;                                                      (cons (make-carta "verde" 6) '()))))))

;; (cria-cartas "vermelho" (cons COMPRA2
;;                          (cons PULA_VEZ
;;                           (cons CURINGA
;;                            (cons CURINGA_COMPRA4
;;                             (cons INVERTE
;;                              (cons 0
;;                                empty))))))) -> (cons
;;                                                 (make-carta "vermelho" -2)
;;                                                 (cons
;;                                                  (make-carta "vermelho" -1)
;;                                                  (cons
;;                                                   (make-carta "vermelho" -5)
;;                                                   (cons
;;                                                    (make-carta "vermelho" -4)
;;                                                    (cons
;;                                                     (make-carta "vermelho" -3)
;;                                                      (cons (make-carta "vermelho" 0) '()))))))


;; Função cria-cartas:

(define (cria-cartas c ln)
           (cond
             ;; Se a lista estiver vazia, retorna empty.
             [(empty? ln) empty]
             ;; Se a lista não for vazia, cria uma carta com a cor e o primero valor passados
             ;; e em seguida recomeça a função, para criar as outras cartas da lista, se houverem. 
             [else (cons (make-carta c (first ln)) (cria-cartas c (rest ln)))]
            )
   )


;; Testes:

(check-expect (cria-cartas "verde" empty) empty)

(check-expect (cria-cartas "verde" (cons 1
                          (cons 2
                           (cons 3
                            (cons 4
                             (cons 5
                              (cons 6
                                empty)))))))
                                               (cons
                                                (make-carta "verde" 1)
                                                 (cons
                                                  (make-carta "verde" 2)
                                                  (cons
                                                   (make-carta "verde" 3)
                                                   (cons
                                                    (make-carta "verde" 4)
                                                    (cons
                                                     (make-carta "verde" 5)
                                                      (cons (make-carta "verde" 6) '()))))))
 )

(check-expect (cria-cartas "vermelho" (cons COMPRA2
                          (cons PULA_VEZ
                           (cons CURINGA
                            (cons CURINGA_COMPRA4
                             (cons INVERTE
                              (cons 0
                                empty)))))))
                                                (cons
                                                 (make-carta "vermelho" -2)
                                                 (cons
                                                  (make-carta "vermelho" -1)
                                                  (cons
                                                   (make-carta "vermelho" -5)
                                                   (cons
                                                    (make-carta "vermelho" -4)
                                                    (cons
                                                     (make-carta "vermelho" -3)
                                                      (cons (make-carta "vermelho" 0) '()))))))
                )
        
;; =========================================================================
;;                                 QUESTÃO 2
;; =========================================================================

;; seleciona-cartas: ListaDeCartas String -> ListaDeCartas

;; Obj: Dada uma lista de cartas e uma string representando uma cor, retorna uma lista com as cartas da cor que foi pedida.

;; Exemplos:
;;(seleciona-cartas (cons (make-carta "verde" 1)
;;                       (cons (make-carta "azul" 2)
;;                            (cons (make-carta "verde" 7)
;;                                 (cons (make-carta "vermelho" 9)
;;                                      (cons (make-carta "amarelo" 0)
;;                                           empty))))) "verde") -> (cons
;;                                                                   (make-carta "verde" 1)
;;                                                                   (cons
;;                                                                    (make-carta "verde" 7)
;;                                                                    '()))
;;

;;(seleciona-cartas (cons (make-carta "azul" 2)
;;                       (cons (make-carta "vermelho" CURINGA)
;;                            (cons (make-carta "verde" COMPRA2)
;;                                 (cons (make-carta "vermelho" COMPRA2)
;;                                      (cons (make-carta "amarelo" 1)
;;                                           empty))))) "vermelho") -> (cons
;;                                                                      (make-carta "vermelho" -5)
;;                                                                      (cons
;;                                                                       (make-carta "vermelho" -2)
;;                                                                       '()))

;;(seleciona-cartas (cons (make-carta "azul" 9)
;;                       (cons( make-carta "azul" CURINGA)
;;                            (cons (make-carta "azul" COMPRA2)
;;                                 (cons (make-carta "azul" COMPRA2)
;;                                      (cons (make-carta "azul" 1)
;;                                           empty))))) "azul") -> (cons
;;                                                                  (make-carta "azul" 9)
;;                                                                  (cons
;;                                                                   (make-carta "azul" -5)
;;                                                                   (cons
;;                                                                    (make-carta "azul" -2)
;;                                                                    (cons
;;                                                                     (make-carta "azul" -2)
;;                                                                     (cons
;;                                                                      (make-carta "azul" 1)
;;                                                                      '())))))




;; Função seleciona-cartas:

(define (seleciona-cartas lc c)
  (cond
      ;; Se a lista estiver vazia, retorna empty.
      [(empty? lc) empty]
      ;; Se a primeira carta tiver a cor pedida, adiciona ela a uma nova lista e recomeça a função para verificar as outras cartas.
      [(string=? (carta-cor (first lc)) c) (cons (first lc) (seleciona-cartas (rest lc) c))]
      ;; Senão, recomeça a função para verificar as outras cartas.
      [else (seleciona-cartas (rest lc) c)]
     )
 )



;; Testes:
(check-expect (seleciona-cartas (cons (make-carta "verde" 1)
                       (cons (make-carta "azul" 2)
                            (cons (make-carta "verde" 7)
                                 (cons (make-carta "vermelho" 9)
                                      (cons (make-carta "amarelo" 0)
                                           empty))))) "verde")
                                                       (cons
                                                        (make-carta "verde" 1)
                                                        (cons
                                                         (make-carta "verde" 7)
                                                         '()))
 )

(check-expect (seleciona-cartas (cons (make-carta "azul" 2)
                       (cons (make-carta "vermelho" CURINGA)
                            (cons (make-carta "verde" COMPRA2)
                                 (cons (make-carta "vermelho" COMPRA2)
                                      (cons (make-carta "amarelo" 1)
                                           empty))))) "vermelho")
                                                         (cons
                                                          (make-carta "vermelho" -5)
                                                          (cons
                                                           (make-carta "vermelho" -2)
                                                           '()))
 )

(check-expect (seleciona-cartas (cons (make-carta "azul" 9)
                       (cons (make-carta "azul" CURINGA)
                            (cons (make-carta "azul" COMPRA2)
                                 (cons (make-carta "azul" COMPRA2)
                                      (cons (make-carta "azul" 1)
                                           empty))))) "azul")
                                                       (cons
                                                        (make-carta "azul" 9)
                                                        (cons
                                                         (make-carta "azul" -5)
                                                         (cons
                                                          (make-carta "azul" -2)
                                                          (cons
                                                           (make-carta "azul" -2)
                                                           (cons
                                                            (make-carta "azul" 1)
                                                            '())))))
 )

;; =========================================================================
;;                                 QUESTÃO 3
;; =========================================================================

;; carta=?: Carta Carta -> Boolean
;; Obj: Recebe duas cartas e compara suas cores e valores, se ambos forem iguais retorna #true, senão, retorna #false.

;; Exemplos:
;; (carta=?(make-carta "verde" 1)(make-carta "verde" 1)) -> #true
;; (carta=?(make-carta "verde" 2)(make-carta "verde" 3)) -> #false
;; (carta=?(make-carta "verde" 4)(make-carta "vermelho" 4)) -> #false
;; (carta=?(make-carta "azul" 5)(make-carta "amarelo" 6)) -> #false


;; Função carta=?:

(define (carta=? carta1 carta2)
  (cond
  ;; Se a cor e o valor das duas cartas forem iguais retorna #true.
  [(and (string=? (carta-cor carta1) (carta-cor carta2)) (= (carta-valor carta1) (carta-valor carta2))) #true]
  ;; Senão retorna false.
  [else #false]
  )
)

;; Testes: 
(check-expect (carta=? (make-carta "verde" 1) (make-carta "verde" 1)) #true)
(check-expect (carta=? (make-carta "verde" 2) (make-carta "verde" 3)) #false)
(check-expect (carta=? (make-carta "verde" 4) (make-carta "vermelho" 4)) #false)
(check-expect (carta=? (make-carta "azul" 5) (make-carta "amarelo" 6)) #false)

;; -------------------------------------------------------------------------------------------

;; carta-repetida?: Carta ListaDeCartas -> Boolean

;; Obj: Recebe uma carta e uma lista de cartas, verifica se há carta repetida na lista e retorna #true houver e #false se não houver repetida.

;; Exemplos:

;; (carta-repetida? (make-carta "verde" 1) empty) -> #false
;; (carta-repetida? (make-carta "verde" 1) (cons (make-carta "verde" 1) (cons (make-carta "verde" 1) (cons (make-carta "verde" -2) (cons (make-carta "vermelho" 2) empty))))) -> #true
;; (carta-repetida? (make-carta "verde" 1) (cons (make-carta "verde" 2) (cons (make-carta "vermelho" 3) (cons (make-carta "azul" 4) (cons (make-carta "amarelo" 5) empty))))) -> #false

;; Função carta-repetida?:
(define (carta-repetida? c lc)
  (cond
    ;;Se a lista for vazia, retorna #false.
    [(empty? lc) #false]
    ;; Se a primeira carta da lista for igual a carta pedida, retorna #true.
    [(carta=? (first lc) c) #true]
    ;; Senão, recomeça a função para verificar as outras cartas da lista
    [else (carta-repetida? c (rest lc))]
    )
  )

;; Testes:

(check-expect (carta-repetida? (make-carta "verde" 1) empty) #false)
(check-expect (carta-repetida? (make-carta "verde" 1) (cons (make-carta "verde" 1) (cons (make-carta "verde" 1) (cons (make-carta "verde" -2) (cons (make-carta "vermelho" 2) empty))))) #true)
(check-expect (carta-repetida? (make-carta "verde" 1) (cons (make-carta "verde" 2) (cons (make-carta "vermelho" 3) (cons (make-carta "azul" 4) (cons (make-carta "amarelo" 5) empty))))) #false)
 
;; /////////////////////////////////////////////////////////////////////////

;; remove-repetidas: ListaDeCartas -> ListaDeCartas

;; Obj: Recebe uma lista de cartas e devolve a lista sem as cartas repetidas.

;; Exemplos:

;; (remove-repetidas empty) -> empty

;; (remove-repetidas (cons (make-carta "verde" 1)
;;                        (cons (make-carta "azul" 2)
;;                              (cons (make-carta "verde" 1)
;;                                    (cons (make-carta "vermelho" 1)
;;                                          (cons (make-carta "vermelho" 1)
;;                                                (cons (make-carta "verde" 1)
;;                                                       empty))))))) -> (cons
;;                                                                   (make-carta "azul" 2)
;;                                                                   (cons
;;                                                                    (make-carta "vermelho" 1)
;;                                                                    (cons
;;                                                                     (make-carta "verde" 1)
;;                                                                    '())))

;; (remove-repetidas (cons (make-carta "verde" 9)
;;                        (cons (make-carta "amarelo" 5)
;;                              (cons (make-carta "verde" 9)
;;                                     empty)))) -> (cons
;;                                              (make-carta "amarelo" 5)
;;                                              (cons
;;                                               (make-carta "verde" 9)
;;                                               '()))

;; Função remove-repetidas:

(define (remove-repetidas lc)
  (cond
    ;;Se a lista for vazia, retorna empty.
    [(empty? lc) empty]
    ;; Se a primeira carta da lista tiver outra igual, remove a carta e recomeça a função verificar as outras cartas.
    [(carta-repetida? (first lc) (rest lc)) (remove-repetidas (rest lc))]
    ;; Senão, cria uma lista com a primeira carta da lista e recomeça a função verificar as outras cartas.
    [else (cons (first lc) (remove-repetidas (rest lc)))]
    )
  )


;; Testes:

(check-expect (remove-repetidas empty) empty)

(check-expect (remove-repetidas (cons (make-carta "verde" 1)
                        (cons (make-carta "azul" 2)
                              (cons (make-carta "verde" 1)
                                    (cons (make-carta "vermelho" 1)
                                          (cons (make-carta "vermelho" 1)
                                                (cons (make-carta "verde" 1)
                                                       empty)))))))
                                                                  (cons
                                                                   (make-carta "azul" 2)
                                                                   (cons
                                                                    (make-carta "vermelho" 1)
                                                                    (cons
                                                                     (make-carta "verde" 1)
                                                                     '())))
 )

(check-expect (remove-repetidas (cons (make-carta "verde" 9)
                        (cons (make-carta "amarelo" 5)
                              (cons (make-carta "verde" 9)
                                     empty))))
                                             (cons
                                              (make-carta "amarelo" 5)
                                              (cons
                                               (make-carta "verde" 9)
                                               '()))

 )

;; =========================================================================
;;                                 QUESTÃO 4
;; =========================================================================

;; Documentação da função random, que já existe no Racket, que deve ser usada
;; na resolução do exercício:

;; random: Número -> Número
;; obj: Dado um número inteiro k, retorna um número inteiro aleatório, 
;; no intervalo [0, k-1]
;; ex:
;;   (random 1) -> 0
;;   (random 2) -> 0
;;   (random 2) -> 1
;;   (random 3) -> 2
;;   (random 1000) -> 42

;; /////////////////////////////////////////////////////////////////////////

;; quantas-cartas: ListaDeCartas -> Número

;; Obj: Recebe uma lista de cartas e retorna o número de cartas que há na lista.



;; Exemplos:

;; (quantas-cartas empty) -> 0

;; (quantas-cartas (cons (make-carta "verde" 1)
;;                                   empty)) -> 1

;; (quantas-cartas (cons (make-carta "verde" 1)
;;                                   (cons (make-carta "vermelho" 2)
;;                                        empty))) -> 2

;; (quantas-cartas (cons (make-carta "verde" 1)
;;                                   (cons (make-carta "vermelho" 2)
;;                                        (cons (make-carta "amarelo" 3)
;;                                             empty)))) -> 3



;; Função quantas-cartas:

(define (quantas-cartas lc)
           (cond
             ;; Se não houver carta, soma zero e encerra a função
             [(empty? lc) 0]
             ;; Se não for vazia, soma 1 e recomeça a função para continuar a contagem.
             [else (+ 1 (quantas-cartas (rest lc)))]
            )
    )



;; Testes:

(check-expect (quantas-cartas empty) 0)

(check-expect (quantas-cartas (cons (make-carta "verde" 1)
                                   empty)) 1)

(check-expect (quantas-cartas (cons (make-carta "verde" 1)
                                   (cons(make-carta "vermelho" 2)
                                        empty))) 2)

(check-expect (quantas-cartas (cons (make-carta "verde" 1)
                                   (cons (make-carta "vermelho" 2)
                                        (cons (make-carta "amarelo" 3)
                                             empty)))) 3)

;; /////////////////////////////////////////////////////////////////////////

;; insere-carta: ListaDeCartas Carta Número -> ListaDeCartas

;; Obj: Recebe uma lista de cartas, uma carta e uma posição, e então, insere a carta passada na posição pedida na lista.

;; Exemplos:

;; Função insere-carta:
(define (insere-carta lc c p)
            (cond            
               ;; Se a lista for vazia então devolve uma lista somente com a carta inserida.
               [(empty? lc) (cons c empty)]
               ;; Se o tamanho da lista for menor que o valor da posição em que se quer adicionar a carta, devolve uma lista com a carta e a lista passada.
               [(< (quantas-cartas lc) p) (cons c lc)]
               ;; Se o tamanho da lista não for igual à posição pedida menos 1, devolve a primeira carta e reinicia função.
               [(not (= (- p 1) (quantas-cartas lc))) (cons (first lc) (insere-carta (rest lc) c p))]
             )
    )
            
;; Testes:

(check-expect (insere-carta empty (make-carta "verde" 1) 1)
              (cons
               (make-carta "verde" 1)
               '()))

(check-expect (insere-carta (cons (make-carta "verde" 1) empty) (make-carta "vermelho" 2) 2)
              (cons
               (make-carta "vermelho" 2)
               (cons
                (make-carta "verde" 1)
                '())))

(check-expect (insere-carta (cons (make-carta "verde" 1)
                                  (cons (make-carta "vermelho" 2)
                                        (cons (make-carta "azul" 3)
                                              (cons (make-carta "amarelo" 4)
                                                    empty)))) (make-carta "verde" 7) 3)
              (cons
               (make-carta "verde" 1)
               (cons
                (make-carta "vermelho" 2)
                (cons
                 (make-carta "verde" 7)
                 (cons
                  (make-carta "azul" 3)
                  (cons
                   (make-carta "amarelo" 4)
                   '()))))))
              
;; /////////////////////////////////////////////////////////////////////////

;; embaralha: ListaDeCartas -> ListaDecartas

;; Obj: Recebe uma lista de cartas e a devolve com as cartas embaralhadas.


;; Exemplos:

;; (embaralha empty) -> '()

;; (embaralha (cons (make-carta "verde" 1)
;;                 (cons (make-carta "vermelho" 2)
;;                       (cons (make-carta "azul" 3)
;;                             (cons (make-carta "amarelo" 4)
;;                                   (cons (make-carta "verde" 5)
;;                                         (cons (make-carta "vermelho" 6)
;;                                               empty))))))) -> (cons
;;                                                                (make-carta "amarelo" 4)
;;                                                                (cons
;;                                                                 (make-carta "azul" 3)
;;                                                                 (cons
;;                                                                  (make-carta "verde" 1)
;;                                                                  (cons
;;                                                                   (make-carta "vermelho" 6)
;;                                                                   (cons
;;                                                                    (make-carta "verde" 5)
;;                                                                    (cons
;;                                                                     (make-carta "vermelho" 2)
;;                                                                     '()))))))




;; Função embaralha:

(define (embaralha lc)
  (cond
    ;; Se a lista estiver vazia, retorna uma lista vazia.
    [(empty? lc) empty]
    ;; Se o resto da lista estiver vazia, devolve a lista.
    [(empty? (rest lc)) lc]
    ;; Senão, adiciona a primeira carta a uma posição aleatória da lista e recomeça a função.
    [else (insere-carta (embaralha (insere-carta (rest (rest lc)) (first (rest lc)) (random (quantas-cartas lc)))) (first lc) (random (quantas-cartas lc)))]
    )
  )



;; Chamadas:

(embaralha empty)

(embaralha (cons (make-carta "verde" 1)
                 (cons (make-carta "vermelho" 2)
                       (cons (make-carta "azul" 3)
                             (cons (make-carta "amarelo" 4)
                                   (cons (make-carta "verde" 5)
                                         (cons (make-carta "vermelho" 6)
                                               empty)))))))
