;Codigo de los requerimientos 1 al 6

; REQUERIMIENTO 1 
;orden de transiciones validas rojo=>verde=>amarillo=>rojo

;FUNCION: transicion
;NATURALEZA: pura(devuelve una lista pero no modifica variables)
;ESTRATEGIA: se basa en la estructura condicional cond
;IMPACTO:no destructiva

;ENTRADA: color actual del semaforo y al que debe cambiar
;SALIDA: lista con color actual y confirmacion del color a cambiar en caso de que sea valido
;ejemplos de prueba: 
;(transicion 'en-rojo 'verde)
;(transicion 'en-rojo 'azul)
(defun transicion (color-actual cambiar-a)
    (cond
        ((and (eq color-actual 'en-rojo)(eq cambiar-a 'verde))
        (list color-actual "cambiar-a-verde")
        )
        ((and (eq color-actual 'en-verde)(eq cambiar-a 'amarillo))
            (list color-actual "cambiar-a-amarillo")
        )
        ((and (eq color-actual 'en-amarillo)(eq cambiar-a 'rojo))
            (list color-actual "cambiar-a-rojo")
        )
        (t (list color-actual 'accion-por-defecto))
    )
)
;REQUERINIENTO 2
;FUNCION: Temporizador
;NATURALEZA: Pura: dado un determinado tiempo se devuelve el color que corresponde a dicho tiempo
;ESTRATEGIA: Recursiva:se reduce el tiempo hasta hallar al que color pertenece
;IMPACTO: No destructiva

;Rojo = 90	Amarrillo = 7	Verde = 120 Total= 216

(defun Temporizador (tiempo-Unix)

  (cond
    ((>= tiempo-Unix 217)
     (Temporizador (- tiempo-Unix 13)))

    ((< tiempo-Unix 91)
     "rojo")

    ((< tiempo-Unix 7)
     "amarillo")

    (t
     "verde")))

; Requerimiento 3
;; ======================================================== 
;; FUNCIÓN: registrar-cambio 
;; NATURALEZA: IMPURA (ya que imprime en pantalla)
;; ESTRATEGIA: Funcion de aplicacion directa (sin recursividad)
;; IMPACTO: no destructiva (no modifica ningun dato o estructura)
;; ========================================================

;Codigo de la primera Fase 
(defun registrar-cambio (epoch color-anterior color-nuevo) 
     (if (or (<= epoch 0) (eq color-anterior color-nuevo))
          'ERROR  
          (format t "Tiempo ~A: la luz ha cambiado de ~A a ~A~%" 
          epoch
          (string-downcase (string color-anterior))
          (string-downcase (string color-nuevo)))
     )
  
)

;Codigo de la segunda Fase (version extendida)
;;MENSAJE TOTALMENTE NECESARIO PARA INCIALIZAR LA FUNCION LOCAL TIME
(load "C:\\Users\\ramir\\quicklisp\\setup.lisp")
(ql:quickload :local-time)

(defun registrar-cambio (epoch color-anterior color-nuevo) 
     (cond  ;;SI LOS COLORES SON IGUALES O EL TIEMPO ES INCORRECTO
          ((<= epoch 0) 'ERROR-TIEMPO-INCORRECTO) 
          ((eq color-anterior color-nuevo) 'ERROR-COLORES-INCORRECTOS)
          (t (format t "Tiempo ~A: la luz ha cambiado de ~A a ~A~%" ;SI TODO ES VALIDO IMPRIME
          (local-time:format-timestring nil ;FORMAT-TIMESTRING FORMATEA UN OBJETO TIMESTAMP A STRING LEGIBLE
                                            ;EL NIL INDICA QUE DEVUELVE UN STRING EN LUGAR DE IMPRIMIR
               (local-time:unix-to-timestamp epoch) ;UNIX-TO-TIMESTAMP: CONVIERTE A UN OBJETO TIMESTAMP NECESARIO PQ FORMAT-TIMESTRING NO ACEPTA NUMEROS
               :format '("[" :year "-" :month "-" :day " " :hour ":" :min ":" :sec "]")) ;FORMATO DE SALIDA DE LE FEHCA
          (string-downcase (string color-anterior)) ;CONVIERTE A MINUSCULAS
          (string-downcase (string color-nuevo)))
          )
     )
)
; Requerimiento 4 
;=======================
;FUNCION: duracion-Ciclo
;NATURALEZA: Pura (siempre que se le otorgue la misma lista de tiempos retorna la misma duracion)
;ESTRATEGIA: Funcion de orden superior (reduce)
;IMPACTO:No destructiva
;----------------------
;ENTRADA: lista con las duraciones de las luces del semaforo (ciclo) Ejemplo: '(90, 6, 120)
;SALIDA: Duracion total del ciclo en segundos  
;----------------------
;=======================

(defun  duracion-Ciclo (tiempos)
    (reduce #'+ tiempos) 

    ;voy a ocupar reduce porque quiero un solo resultado final que sume todo lo que le paso por parametro,
    ; esta seria la sintaxis(reduce #'funcion lista) podria utilizar mapcar, pero me va a devolver una lista y yo lo que
    ;quiero es un resultado unico 

)

;=======================
;FUNCION: recomendacion-Ciclo
;NATURALEZA: Pura (siempre que se le de la misma duracion va a retornar la misma recomendacion)
;ESTRATEGIA: Condicional (cond) 
;IMPACTO: No destructiva
;----------------------
;ENTRADA: Duracion del ciclo en segundos 
;SALIDA: Recomendacion segun los estandares de ingenieria del trafico (35 a 150 segundos)
;----------------------
;=======================

(defun recomendacion-Ciclo (duracion) ;entra como parametro el resultado de la funcion duracion-ciclo
(cond    
    ((<= duracion 35) "Ciclo demasiado corto. Se recomienda aumentar duracion")
    ((>= duracion 150) "Ciclo demasiado largo. Se recomienda disminuir la duracion")
    (t "Ciclo optimo")
    )
)

; Requerimiento 5
; ========================================================
; FUNCIÓN: ciclos-por-tiempo
; NATURALEZA: Pura 
; ESTRATEGIA: Composición Funcional (Combina funciones aritméticas puras para transformar los minutos en ciclos enteros)
; IMPACTO: No destructiva
; ========================================================

(defun ciclos-por-tiempo (minutos)
  (let* ((tiempo-segundos (* minutos 60))
         (duracion-ciclo (+ 90 6 120))) 
    ;; values descarta valores secundarios que puedan llegar a mostrarse
    (values (floor tiempo-segundos duracion-ciclo))))

;Requerimiento 6
;; ========================================================
;; FUNCIÓN: distribucion-temporal
;; NATURALEZA: Pura (no escribe en pantalla)
;; ESTRATEGIA: Funcion de orden Superior (utiliza mapcar)
;; IMPACTO: No destructiva
;; ========================================================

;Utilizo la funcion de mi compañero duracion-ciclo para la duracion total del ciclo
(defun distribucion-temporal (tiempos)
	(mapcar #'(lambda (x y)
				(when (numberp x)
						(list y (* (/ x (duracion-ciclo tiempos)) 100.00))
				)
			  ) 
	tiempos
	'("rojo" "amarillo" "verde")
	 )
)





;===========================================================
; SEGUNDA ITERACION 
;===========================================================


;Codigo de los requerimientos 1 al 6

; REQUERIMIENTO 1 
;orden de transiciones validas rojo=>verde=>amarillo=>rojo

;FUNCION: transicion
;NATURALEZA: pura(devuelve una lista pero no modifica variables)
;ESTRATEGIA: se basa en la estructura condicional cond
;IMPACTO:no destructiva

;ENTRADA: color actual del semaforo y al que debe cambiar
;SALIDA: lista con color actual y confirmacion del color a cambiar en caso de que sea valido

(defun transicion (color-actual cambiar-a)
    (cond
        ((and (eq color-actual 'en-rojo)(eq cambiar-a 'verde))
        (list color-actual "rojo-intermitente	cambiar-a-verde")
        )
        ((and (eq color-actual 'en-verde)(eq cambiar-a 'amarillo))
            (list color-actual "verde-intermitente	cambiar-a-amarillo")
        )
        ((and (eq color-actual 'en-amarillo)(eq cambiar-a 'rojo))
            (list color-actual "amarillo-intermitente	cambiar-a-rojo")
        )
        (t (list color-actual 'error))
    )
)
;REQUERINIENTO 2
;FUNCION: Temporizador
;NATURALEZA: Pura: dado un determinado tiempo se devuelve el color que corresponde a dicho tiempo
;ESTRATEGIA: Recursiva:se reduce el tiempo hasta hallar al que color pertenece
;IMPACTO: No destructiva

;Rojo = 3	Amarrillo = 4	Verde = 6 	Total= 13

(defun Temporizador (tiempo-Unix )

  (cond
    ((>= tiempo-Unix 225)
     (Temporizador (- tiempo-Unix 225)))

    ((< tiempo-Unix 90)
     "rojo")
    ((< tiempo-Unix 93)
    	"rojo-intermitente")
	
	((< tiempo-Unix 213) 
    	"verde")
    ((< tiempo-Unix 216)
    	"verde-intermitente")

    ((< tiempo-Unix 222)
     "amarillo")
    ((< tiempo-Unix 225)
    	"amarillo-intermitente")

    

    (t
     "error 0800")))

; Requerimiento 3
;; ======================================================== 
;; FUNCIÓN: registrar-cambio 
;; NATURALEZA: IMPURA (ya que imprime en pantalla)
;; ESTRATEGIA: Funcion de aplicacion directa (sin recursividad)
;; IMPACTO: no destructiva (no modifica ningun dato o estructura)
;; ========================================================

;;MENSAJE TOTALMENTE NECESARIO PARA INCIALIZAR LA FUNCION LOCAL TIME
(load "C:\\Users\\Hogar\\quicklisp\\setup.lisp")
(ql:quickload :local-time)

(defun registrar-cambio (epoch color-anterior color-nuevo) 
     (cond  ;;SI LOS COLORES SON IGUALES O EL TIEMPO ES INCORRECTO
          ((<= epoch 0) 'ERROR-TIEMPO-INCORRECTO) 
          ((eq color-anterior color-nuevo) 'ERROR-COLORES-INCORRECTOS)
          (t (format t "Tiempo ~A: la luz ha cambiado de ~A a ~A~%" ;SI TODO ES VALIDO IMPRIME
          (local-time:format-timestring nil ;FORMAT-TIMESTRING FORMATEA UN OBJETO TIMESTAMP A STRING LEGIBLE
                                            ;EL NIL INDICA QUE DEVUELVE UN STRING EN LUGAR DE IMPRIMIR
               (local-time:unix-to-timestamp epoch) ;UNIX-TO-TIMESTAMP: CONVIERTE A UN OBJETO TIMESTAMP NECESARIO PQ FORMAT-TIMESTRING NO ACEPTA NUMEROS
               :format '("[" :year "-" :month "-" :day " " :hour ":" :min ":" :sec "]")) ;FORMATO DE SALIDA DE LE FEHCA
          (string-downcase (string color-anterior)) ;CONVIERTE A MINUSCULAS
          (string-downcase (string color-nuevo)))
          )
     )
)
; Requerimiento 4 
;=======================
;FUNCION: duracion-Ciclo
;NATURALEZA: Pura (siempre que se le otorgue la misma lista de tiempos retorna la misma duracion)
;ESTRATEGIA: Funcion de orden superior (reduce)
;IMPACTO:No destructiva
;----------------------
;ENTRADA: lista con las duraciones de las luces del semaforo (ciclo) Ejemplo: '(90, 6, 120)
;SALIDA: Duracion total del ciclo en segundos  
;----------------------
;=======================

(defun  duracion-Ciclo (tiempos)
    (reduce #'+ tiempos) 

    ;voy a ocupar reduce porque quiero un solo resultado final que sume todo lo que le paso por parametro,
    ; esta seria la sintaxis(reduce #'funcion lista) podria utilizar mapcar, pero me va a devolver una lista y yo lo que
    ;quiero es un resultado unico 

)

;=======================
;FUNCION: recomendacion-Ciclo
;NATURALEZA: Pura (siempre que se le de la misma duracion va a retornar la misma recomendacion)
;ESTRATEGIA: Condicional (cond) 
;IMPACTO: No destructiva
;----------------------
;ENTRADA: Duracion del ciclo en segundos 
;SALIDA: Recomendacion segun los estandares de ingenieria del trafico (35 a 150 segundos)
;----------------------
;=======================

(defun recomendacion-Ciclo (duracion) ;entra como parametro el resultado de la funcion duracion-ciclo
(cond    
    ((< duracion 35) "Ciclo demasiado corto. Se recomienda aumentar duracion")
    ((> duracion 150) "Ciclo demasiado largo. Se recomienda disminuir la duracion")
    (t "Ciclo optimo")
    ))




; Requerimiento 5
; ========================================================
; FUNCIÓN: ciclos-por-tiempo
; NATURALEZA: Pura 
; ESTRATEGIA: Composición Funcional (Combina funciones aritméticas puras para transformar los minutos en ciclos enteros)
; IMPACTO: No destructiva
; ========================================================

(defun ciclos-por-tiempo (minutos)
  (let* ((tiempo-segundos (* minutos 60))
         (duracion-ciclo (+ 90 6 120))) 
    ;; values descarta valores secundarios que puedan llegar a mostrarse
    (values (floor tiempo-segundos duracion-ciclo))))

;Requerimiento 6
;; ========================================================
;; FUNCIÓN: distribucion-temporal
;; NATURALEZA: Pura (no escribe en pantalla)
;; ESTRATEGIA: Funcion de orden Superior (utiliza mapcar)
;; IMPACTO: No destructiva
;; ========================================================

;Utilizo la funcion de mi compañero duracion-ciclo para la duracion total del ciclo
(defun distribucion-temporal (porcentaje)
	(mapcar #'(lambda (x y)
				(when (numberp x)
						(list y (* (/ x (duracion-ciclo porcentaje)) 100.00))
				)
			  ) 
	porcentaje
	'("rojo" "verde" "amarillo")
	 )
)


(defun menu ()
	
	(format t "0. Salir ~%")
	(format t "1. Requirimiento 1: ~%")
	(format t "2. Requirimiento 2: ~%")
	(format t "3. Requirimiento 3: ~%")
	(format t "4. Requirimiento 4: ~%")
	(format t "5. Requirimiento 5: ~%")
	(format t "6. Requirimiento 6: ~%")
	

	(let ((opcion (read)))
	
	(cond 

		((= opcion 1)
			
			(format t "ingrese el color actual:~%")
			(let ((color-actual (read)))
			(format t "cambiar-a: ~%")
			(let ((cambiar-a (read)))

			(format t "~a ~%" (transicion color-actual cambiar-a))))
			(menu))

		((= opcion 2)

			(format t "ingrese el tiempo en segundos(unix): ~%")
			(let ((tiempo-Unix (read)))

			(format t "el color en esos segundos es ~a ~%" (Temporizador tiempo-Unix)))
			(menu))

		((= opcion 3)
			(format t "color anterior; ~%")
			(let ((color-anterior (read)))
			(format t "ingrese epoch: ~%")
			(let ((epoch (read)))
			(format t "color-nuevo: ~%")
			(let ((color-nuevo (read)))

			(format t "~a ~%" (registrar-cambio epoch color-anterior color-nuevo)))))
			(menu))
		
		((= opcion 4)  
			(format t "ingrese la duracion de cada estado en formato lista:~%")
			(let ((tiempos (read)))

			(format t "la duracion del ciclo es: ~a ~%" (duracion-Ciclo tiempos))
			(format t "~a ~%" (recomendacion-Ciclo (duracion-Ciclo tiempos))))
			(menu))
		
		((= opcion 5)
			(format t "ingrese el tiempo en minutos:~%")
			(let ((minutos (read)))

			(format t "la cantidad de ciclos que hay son: ~A ~%" (ciclos-por-tiempo minutos)))
			(menu))

		((= opcion 6)
			(format t "ingrese el valor de cada estado de forma ordenada; ~%")
			(let ((porcentaje (read)))

			(format t "~A ~,2f ~%" (distribucion-temporal porcentaje)))
			(menu))
		
		((= opcion 0)
			(format t "ADIOS"))
	)
))

(menu)









