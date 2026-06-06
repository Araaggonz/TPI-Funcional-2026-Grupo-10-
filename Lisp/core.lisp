;Codigo de los requerimientos 1 al 6
;======================================================
; REQUERIMIENTO 1 
;orden de transiciones validas rojo=>verde=>amarillo=>rojo
;=======================================================

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
(reduce #'+ tiempos) ;voy a ocupar reduce porque quiero un solo resultado final que sume todo lo que le paso por parametro,
                    ; esta seria la sintaxis(reduce #'funcion lista) podria utilizar mapcar, pero me va a devolver una lista y yo lo que
                    ;quiero es un resultado unico 

)

(defun recomendacion ciclo (duracion)
;y aca tiene que recibir el resultado de la suma y recomendar una optimizacion (si esta por debajo de rango, dentro, o por fuera de rango)
)

