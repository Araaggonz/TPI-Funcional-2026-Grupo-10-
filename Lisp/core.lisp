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

;Rojo = 3	Amarrillo = 4	Verde = 6 	Total= 13

(defun Temporizador (tiempo-Unix)

  (cond
    ((>= tiempo-Unix 13)
     (Temporizador (- tiempo-Unix 13)))

    ((< tiempo-Unix 4)
     "rojo")

    ((< tiempo-Unix 7)
     "amarillo")

    (t
     "verde")))

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

