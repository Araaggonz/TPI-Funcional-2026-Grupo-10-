;Codigo de los requerimientos 1 al 6
;orden de transiciones validas rojo=>verde=>amarillo=>rojo
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
