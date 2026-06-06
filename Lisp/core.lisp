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

; intento 1 del requerimiento 4 
;Guia de lo que pide el trabajo:
;=========================================================
;Requerimiento 4: Análisis de Ciclos Semafóricos
;Para la coordinación y planificación de la vía se necesita calcular cuántos ciclos, transición entre rojo a rojo, se realizarán pasado un determinado tiempo. A la hora de determinar la duración de un ciclo semafórico se acostumbra a tener en cuenta la psicología del conductor, según la cual, ciclos menores de 35 segundos o mayores de 150 segundos se acomodan difícilmente a la mentalidad del usuario de la vía pública, por lo que tienden a evitarse. Por lo que se solicita implementar una función duracion-ciclo que calcule la duración que tendrá cada ciclo con las reglas de negocio actuales y una funcion de recomendacion sobre la duración del ciclo. 
;Desarrolle funciones para análisis de eficiencia del sistema: 4a. Función duracion-ciclo 
;Entrada: un número determinado de segundos
;Propósito: Calcular duración total de un ciclo completo (rojo → amarillo → verde → rojo)
;Consideración psicológica: Evaluar si la duración está en el rango óptimo (35-150 segundos)
;4b. Función recomendacion-ciclo
;Entrada: Duración calculada del ciclo
;Salida: Recomendación de optimización basada en estándares de ingeniería de tráfico
;================================================================

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

;Aca tiene que sumar cuanto dura el verde, el amarillo y el rojo

)

(defun recomendacion ciclo (duracion)
;y aca tiene que recibir el resultado de la suma y recomendar una optimizacion (si esta por debajo de rango, dentro, o por fuera de rango)
)

