;;===========================================================
;; SEGUNDA ITERACION 
;;===========================================================


;;Codigo de los requerimientos 1 al 6

;; REQUERIMIENTO 1 
;;orden de transiciones validas rojo=>verde=>amarillo=>rojo
;; ========================================================
;;FUNCION: transicion
;;NATURALEZA: pura(devuelve una lista pero no modifica variables)
;;ESTRATEGIA: se basa en la estructura condicional cond
;;IMPACTO:no destructiva
;; ========================================================
;;ENTRADA: color actual del semaforo y al que debe cambiar
;;SALIDA: lista con color actual y confirmacion del color a cambiar en caso de que sea valido
;;ejemplos de prueba con sus respectivas salidas: 
;;(transicion 'en-rojo 'verde)  ==> (en-rojo rojo-intermitente cambiar-a-verde)
;;;;(transicion 'en-verde 'armarillo)  ==> (en-verde verde-intermitente cambiar-a-amarillo)
;;(transicion 'en-rojo 'azul)   ==> (en-rojo accion-por-defecto)

(defun transicion (color-actual cambiar-a)
    (cond
        ((and (eq color-actual 'en-rojo)(eq cambiar-a 'verde))
        (list color-actual "rojo-intermitente cambiar-a-verde")
        )
        ((and (eq color-actual 'en-verde)(eq cambiar-a 'amarillo))
            (list color-actual "verde-intermitente cambiar-a-amarillo")
        )
        ((and (eq color-actual 'en-amarillo)(eq cambiar-a 'rojo))
            (list color-actual "amarillo-intermitente cambiar-a-rojo")
        )
        (t (list color-actual 'accion-por-defecto))
    )
)


;;REQUERIMIENTO 2
;;FUNCION: timer
;;NATURALEZA: Pura: dado un determinado tiempo se devuelve el color que corresponde a dicho tiempo
;;ESTRATEGIA: Recursiva:se reduce el tiempo hasta hallar al que color pertenece
;;IMPACTO: No destructiva
;;(timer 140)
;;(timer 95)
;;(timer 160)

;;Rojo = 90 Amarillo = 6 Verde = 120 intermitencias = 9   Total= 225

(sb-ext:unlock-package :sb-ext) ; comando necesario para que al ejecutar sbcl no de error

(defun timer (tiempo-Unix )

  (cond
    ((>= tiempo-Unix 225) (timer (- tiempo-Unix 225)))

    ((< tiempo-Unix 90)  "rojo")
    ((< tiempo-Unix 93)  "rojo-intermitente")
  
    ((< tiempo-Unix 213) "verde")
    ((< tiempo-Unix 216) "verde-intermitente")

    ((< tiempo-Unix 222) "amarillo")
    ((< tiempo-Unix 225) "amarillo-intermitente")
    (t
     "el dato ingresado no es un formato valido")))


;; Requerimiento 3
;; ======================================================== 
;; FUNCIÓN: registrar-cambio 
;; NATURALEZA: PURA 
;; ESTRATEGIA: Funcion de aplicacion directa (sin recursividad)
;; IMPACTO: no destructiva (no modifica ningun dato o estructura)
;; ========================================================+


;;MENSAJE TOTALMENTE NECESARIO PARA INICIALIZAR LA FUNCION LOCAL TIME

(ql:quickload :local-time)

(defun registrar-cambio (epoch color-anterior color-nuevo) 
     (cond  ;;SI LOS COLORES SON IGUALES O EL TIEMPO ES INCORRECTO
          ((<= epoch 0) 'ERROR-TIEMPO-INCORRECTO)

          ((eq color-anterior color-nuevo) 'ERROR-COLORES-INCORRECTOS)

          (t (format nil "Tiempo ~A: la luz ha cambiado de ~A a ~A~%" ;SI TODO ES VALIDO IMPRIME
          (local-time:format-timestring nil ;FORMAT-TIMESTRING FORMATEA UN OBJETO TIMESTAMP A STRING LEGIBLE
                                            ;EL NIL INDICA QUE DEVUELVE UN STRING EN LUGAR DE IMPRIMIR
               (local-time:unix-to-timestamp epoch) ;UNIX-TO-TIMESTAMP: CONVIERTE A UN OBJETO TIMESTAMP NECESARIO PQ FORMAT-TIMESTRING NO ACEPTA NUMEROS
               :format '("[" :year "-" :month "-" :day " " :hour ":" :min ":" :sec "]")) ;FORMATO DE SALIDA DE LA FECHA
          (string-downcase (string color-anterior)) ;CONVIERTE A MINUSCULAS
          (string-downcase (string color-nuevo)))
          )
     )
)
;; Requerimiento 4 
;;=======================
;;FUNCION: duracion-ciclo
;;NATURALEZA: Pura (siempre que se le otorgue la misma lista de tiempos retorna la misma duracion)
;;ESTRATEGIA: Funcion de orden superior (reduce)
;;IMPACTO:No destructiva
;;----------------------
;;ENTRADA: lista con las duraciones de las luces del semaforo (ciclo) Ejemplo: '(93, 9, 123)
;;SALIDA: Duracion total del ciclo en segundos
;;----------------------
;; EJEMPLO: se ingresa '(9o, 6, 120) se resulta 216 y se suman 9 osea se egresa 225
;;=======================

(defun  duracion-ciclo (tiempos)
    (+ (reduce #'+ tiempos) 9) ; se agregan 9 segundos que serian los de intermitencia
)

;;=======================
;;FUNCION: recomendacion-ciclo
;;NATURALEZA: Pura (siempre que se le de la misma duracion va a retornar la misma recomendacion)
;;ESTRATEGIA: Condicional (cond) 
;;IMPACTO: No destructiva
;;----------------------
;;ENTRADA: Duracion del ciclo en segundos 
;;SALIDA: Recomendacion segun los estandares de ingenieria del trafico (35 a 150 segundos)
;;----------------------
;; Ejemplo: (225 > 150) "Ciclo demasiado largo. Se recomienda dismunuir la duracion"  
;;=======================

(defun recomendacion-ciclo (duracion) ;entra como parametro el resultado de la funcion duracion-ciclo
(cond    
    ((< duracion 35) "Ciclo demasiado corto. Se recomienda aumentar duracion")
    ((> duracion 150) "Ciclo demasiado largo. Se recomienda disminuir la duracion")
    (t "Ciclo optimo")
    ))


;; Requerimiento 5
;; ========================================================
;; FUNCIÓN: ciclos-por-tiempo
;; NATURALEZA: Pura 
;; ESTRATEGIA: Composición Funcional (Combina funciones aritméticas puras para transformar los minutos en ciclos enteros)
;; IMPACTO: No destructiva
;; ========================================================


(defun ciclos-por-tiempo (minutos)
  (let* ((tiempo-segundos (* minutos 60))
         (duracion-ciclo (+ 90 6 120 9))) ; se agregan 9 segundos que serian los de intermitencia
    ;; values descarta valores secundarios que puedan llegar a mostrarse
    (values (floor tiempo-segundos duracion-ciclo))))


;; Requerimiento 6
;; ========================================================
;; FUNCIÓN: distribucion-temporal
;; NATURALEZA: Pura (no escribe en pantalla)
;; ESTRATEGIA: Funcion de orden Superior (utiliza mapcar)
;; IMPACTO: No destructiva
;; ========================================================
;; Ejemplo 1 - Funcionamiento normal
;;(distribucion-temporal '(90 6 120))
;; Salida: (("rojo" 41.666664) ("amarillo" 2.777778) ("verde" 55.555557))

;; Ejemplo 2 - Camino alternativo (lista vacía)
;;(distribucion-temporal '())
;; Salida: NIL

;; Ejemplo 3 - Error (elemento no numérico)
;;(distribucion-temporal '(90 "hola" 120))
;;Salida: "hola" is not a number

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


;;VALIDACION


;; ========================================================
;; FUNCIÓN: validar-estados
;; NATURALEZA: Impura
;; ESTRATEGIA: Recursiva (se llama repetidamente a la funcion hasta que el valor ingresado sea igual a alguna de las condiciones de la funcion)
;; IMPACTO: No destructiva
;; ========================================================


(defun validar-estados ()
  (let ((estado (read)))
    (cond
      ((or (eq estado 'rojo) (eq estado 'amarillo) (eq estado 'verde))
        estado)
      (t 
        (format t "ingrese un estado correcto (rojo amarillo verde) ~%")
        (validar-estados)))))


;; ========================================================
;; FUNCIÓN: validar-estado2
;; NATURALEZA: Impura
;; ESTRATEGIA: Recursiva (se llama repetidamente a la funcion hasta que el valor ingresado sea igual a alguna de las condiciones de la funcion)
;; IMPACTO: No destructiva
;; ========================================================


(defun validar-estados2 ()
  (let ((estado (read)))
    (cond
      ((or (eq estado 'en-rojo) (eq estado 'en-amarillo) (eq estado 'en-verde))
        estado)
      (t 
        (format t "ingrese un estado correcto (en-rojo en-amarillo en-verde) ~%")
        (validar-estados2)))))


;; ========================================================
;; FUNCIÓN: validar-numero
;; NATURALEZA: Impura
;; ESTRATEGIA: Recursiva (se llama repetidamente a la funcion hasta que hasta que se cumplan las condiciones)
;; IMPACTO: No destructiva
;; ========================================================


(defun validar-numero ()
  (let ((numero (read)))
    (cond 
      ((and (integerp numero) (> numero 0))
        numero)
    (t 
      (format t "ingrese un numero entero positivo~%")
      (validar-numero)))))


;; ========================================================
;; FUNCIÓN: validar-lista
;; NATURALEZA: Impura
;; ESTRATEGIA: Recursiva (se llama repetidamente a la funcion hasta que hasta que el valor ingresado  cumpla las condiciones (sea lista, y sea un numero entero positivo))
;; IMPACTO: No destructiva
;; ========================================================


(defun validar-lista ()
  (let ((numero (read)))
    (cond
      ((not (listp numero))
       (format t "Ingrese una lista.~%")
       (validar-lista))

      ((and (= (length numero) 3)
            (every #'(lambda (x)
                       (and (integerp x)
                            (> x 0)))
                   numero))
       numero)

      (t
       (format t "Ingrese una lista de 3 numeros enteros mayores a 0.~%")
       (validar-lista)))))


;; ========================================================
;; FUNCIÓN: validar-opcion
;; NATURALEZA: Impura
;; ESTRATEGIA: Recursiva (se llama repetidamente a la funcion hasta que hasta que se cumplan las condiciones)
;; IMPACTO: No destructiva
;; ========================================================


(defun validar-opcion ()
  (let ((opcion (read)))
    (cond 

      ((and (integerp opcion) (and (< opcion 7)(> opcion -1)))
        opcion)
      (t 
        (format t "ingrese un numero del 0 al 6~%")
        (validar-opcion)))))


;;Persistencia de Datos


;; ========================================================
;; FUNCIÓN: ejecutar-guardar-historial
;; NATURALEZA: Pura no modifica nada
;; ESTRATEGIA: Función con uso de cond 
;; IMPACTO: No destructiva 
;; ========================================================


(defun ejecutar-guardar-historial (epoch color-anterior color-nuevo historial)
  (let ((datos (registrar-cambio epoch color-anterior color-nuevo )))

    (cond 
      ((stringp datos)
        (cons datos historial))
      (t historial))))


;; ========================================================
;; FUNCIÓN: informe
;; NATURALEZA: Impura escribe en un archivo externo
;; ESTRATEGIA: Función de Orden Superior (utiliza mapcar para escribir los cambios de colores)
;; IMPACTO: No destructiva 
;; ========================================================


(defun informe (historial)
  (with-open-file (stream "informe-ejecucion-semaforo.txt" :direction :output :if-exists :supersede)
    (format stream "Informe de Ejecucion del Sistema de Semaforo~%")
    (format stream "=========================================~%")

    (mapcar (lambda (x)
      (format stream "~a ~%" x))
    (reverse historial))
    (format stream "Fin del Informe~%")))



;; ========================================================
;; FUNCIÓN: menu
;; NATURALEZA: Impura
;; ESTRATEGIA: Recursiva (se llama repetidamente a la misma funcion hasta que se ingrese la opcion 0)
;; IMPACTO: No destructiva
;; ========================================================



(defun menu (historial)     ;muestra en pantalla distintas opciones , de las cuales el usuario debera elegir una y ingresar datos relacionados a esa opcion
  (format t "0. Salir ~%")
  (format t "1. Requerimiento 1: ~%")
  (format t "2. Requerimiento 2: ~%")
  (format t "3. Requerimiento 3: ~%")
  (format t "4. Requerimiento 4: ~%")
  (format t "5. Requerimiento 5: ~%")
  (format t "6. Requerimiento 6: ~%")
  

  (let ((opcion (validar-opcion)))
  
  (cond 

    ((= opcion 0)
      (informe historial)
      (format t "ADIOS")
      nil)
  

    ((= opcion 1)
      
      (format t "ingrese el color actual:~%")
      (let ((color-actual (validar-estados2)))
      (format t "cambiar-a: ~%")
      (let ((cambiar-a (validar-estados)))

      (format t "~a ~%" (transicion color-actual cambiar-a))))
      (menu historial))

    ((= opcion 2)

      (format t "ingrese el tiempo en segundos(unix): ~%")
      (let ((tiempo-Unix (validar-numero)))

      (format t "el color en esos segundos es ~a ~%" (timer tiempo-Unix)))
      (menu historial))

    ((= opcion 3)
      (format t "color anterior: ~%")
      (let ((color-anterior (validar-estados)))
          (format t "ingrese epoch: ~%")
          (let ((epoch (validar-numero)))
          (format t "color-nuevo: ~%")
          (let ((color-nuevo (validar-estados)))
       
            (let ((nuevo-historial(ejecutar-guardar-historial epoch color-anterior color-nuevo historial)))
            
            (format t "~a ~%" (first nuevo-historial))
           (menu nuevo-historial))))))
    
    ((= opcion 4)  
      (format t "ingrese la duracion de cada estado en formato lista:~%")
      (let ((tiempos (validar-lista)))

      (format t "la duracion del ciclo es: ~a  se tienen en cuenta los 9 segundos de intermitencia~%" (duracion-ciclo tiempos))
      (format t "~a ~%" (recomendacion-ciclo (duracion-ciclo tiempos))))
      (menu historial))
    
    ((= opcion 5)
      (format t "ingrese el tiempo en minutos:~%")
      (let ((minutos (validar-numero)))

      (format t "la cantidad de ciclos que hay son: ~A ~%" (ciclos-por-tiempo minutos)))
      (menu historial))

    ((= opcion 6)
      (format t "ingrese el valor de cada estado de forma ordenada; ~%")
      (let ((porcentaje (validar-lista)))

      (format t "~A  ~%" (distribucion-temporal porcentaje)))
      (menu historial))

    
    )

))

(menu nil)

