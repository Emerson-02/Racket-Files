;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname myproj01) (read-case-sensitive #t) (teachpacks ((lib "draw.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "draw.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(above
(rectangle 300 60 "solid" "red")
(overlay
 (star 30 "solid" "yellow")
 (rectangle 300 60 "solid" "white")
 )
(rectangle 300 60 "solid" "blue")
)

(beside
 (rectangle 100 200 "solid" "forest green")
 (rectangle 100 200 "solid" "white")
 (rectangle 100 200 "solid" "orange")
 )

(beside
 (rectangle 100 200 "solid" "blue")
 (rectangle 100 200 "solid" "white")
 (rectangle 100 200 "solid" "red")
 )

(beside
 (rectangle 100 200 "solid" "forest green")
 (rectangle 100 200 "solid" "white")
 (rectangle 100 200 "solid" "forest green")
 )

(beside
 (rectangle 100 200 "solid" "black")
 (rectangle 100 200 "solid" "yellow")
 (rectangle 100 200 "solid" "red")
 )

(beside
 (rectangle 100 200 "solid" "forest green")
 (rectangle 100 200 "solid" "white")
 (rectangle 100 200 "solid" "red")
 )

(beside
 (rectangle 100 200 "solid" "forest green")
 (overlay
  (star 30 "solid" "gold")
(rectangle 100 200 "solid" "red")
  )
 (rectangle 100 200 "solid" "gold")
 )


(define BarraBranca (rectangle 100 200 "solid" "white"))
(define BarraVerde (rectangle 100 200 "solid" "forest green"))
(define BarraVermelha (rectangle 100 200 "solid" "red"))

(beside BarraVerde BarraBranca BarraVermelha)




































