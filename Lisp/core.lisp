;Codigo de los requerimientos 1 al 6

; REQUERIMIENTO 1 
;orden de transiciones validas rojo=>verde=>amarillo=>rojo

=======================
FUNCION: 
NATURALEZA: 
ESTRATEGIA: 
IMPACTO:
----------------------
ENTRADA: 
SALIDA: 
----------------------
=======================

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
=======================
FUNCION: 
NATURALEZA: 
ESTRATEGIA: 
IMPACTO:
----------------------
ENTRADA: 
SALIDA: 
----------------------
=======================

(defun  duracion-Ciclo (tiempos)
    (reduce #'+ tiempos) 

    ;voy a ocupar reduce porque quiero un solo resultado final que sume todo lo que le paso por parametro,
    ; esta seria la sintaxis(reduce #'funcion lista) podria utilizar mapcar, pero me va a devolver una lista y yo lo que
    ;quiero es un resultado unico 

)

=======================
FUNCION: 
NATURALEZA: 
ESTRATEGIA: 
IMPACTO:
----------------------
ENTRADA: 
SALIDA: 
----------------------
=======================

(defun recomendacion ciclo (duracion) ;entra como parametro el resultado de la funcion duracion-ciclo
(cond    
    ((<= duracion 35) "Ciclo demasiado corto. Se recomienda aumentar duracion")
    ((>= duracion 150) "Ciclo demasiado largo. Se recomienda disminuir la duracion")
    (t "Ciclo optimo")
    )
)

