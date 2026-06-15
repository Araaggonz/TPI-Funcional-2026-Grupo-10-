#|  Sistemas de Semáforos Inteligentes 
Descripción
Este proyecto fue desarrollado como trabajo integrador de la materia Paradigmas y Lenguajes. 
El objetivo consiste en modelar un problema del mundo real como lo es un sistema de semáforos urbanos utilizando la programación funcional en Common Lisp, aplicando conceptos como funciones puras, inmutabilidad y composición funcional. Así como las funciones de recursividad, de orden superior, validación de datos y persistencia de la información para resolver un problema de ingeniería en sistemas   
El sistema permite simular el comportamiento de un semáforo, calcular ciclos temporales, registrar cambios de estado y generar informes de ejecución.
Objetivos: 
•	Modelar un problema del mundo real: Traducir los requisitos funcionales de un sistema de tráfico urbano a código LISP utilizando el paradigma funcional.
•	Desarrollar autonomía y pensamiento algorítmico: Resolver la integración de herramientas externas y el aprendizaje de una tecnología nueva con el mínimo de asistencia docente.
•	Análisis Crítico y Metacognición: Evaluar y tipificar las funciones creadas, comprendiendo sus implicancias en la memoria y el flujo de datos, y comparar cómo diferentes lenguajes abordan un mismo problema lógico.
Tecnologías utilizadas: 
•	Common Lisp 
•	Quicklisp – Biblioteca Local-time 
•	https://ocaml.org/play 

FUNCIONALIDADES IMPLEMENTADAS 

Requerimiento 1: Transición de estados 
•	Permite validar las transiciones correctas entre los estados del semáforo.
•	Secuencia valida: Rojo -> Verde -> Amarrillo -> Rojo 
•	En la segunda iteración se incorporan estados intermitentes por cada color 

Requerimiento 2: Temporizador
•	Determina el estado del semáforo a partir de un tiempo Unix dado 
•	Utiliza una estrategia recursiva para calcular el estado correspondiente dentro del ciclo temporal
 
Requerimiento 3: Registros de cambios
•	Registra cambio de estado del semáforo utilizando marcas de tiempo 
•	La segunda iteración incorpora fechas legibles mediante la biblioteca Local-Time

Requerimiento 4: Ciclos del semáforo
1)	Duración del Ciclo: 
•	Calcula la duración total de un ciclo del semáforo utilizando la función de orden superior “Reduce” 
2)	Recomendación de Ciclo:
•	Además, genera recomendaciones según estándares de duración de ciclos de tránsito. 

Requerimiento 5: Ciclos por tiempo
•	Calcula cuantos ciclos completos del semáforo ocurren durante una cantidad determinada de minutos

Requerimiento 6: Distribución temporal
•	Calcula el porcentaje de tiempo que ocupa cada estado dentro del ciclo completo utilizando “mapcar” 

FUNCIONALIDADES ADICIONALES: 

1)	Validacion de Entradas: Se implementaron funciones recursivas para validar: 
•	Estados del semáforo
•	Valores numéricos 
•	Opciones del menú 
•	Listas de duraciones 
2)	Persistencia de datos: Los cambios de estado son almacenado en un historial durante la ejecución. Al finalizar el programa se genera automáticamente un archivo; informe-ejecucion-semaforo.txt que contiene el registro completo de eventos 
3)	Menú interactivo: El sistema posee una interfaz de consola que permite ejecutar cada requerimiento individualmente 

Ejecucion: 
A)	Cargar Quicklisp
•	(load "ruta/quicklisp/setup.lisp")
B)	Cargar Local-Time
•	(ql:quickload :local-time)
C)	Ejecutar el programa
•	(load "semaforo.lisp")
•	El menú principal se iniciara automáticamente 
Conceptos de Paradigmas Aplicados
  Durante el desarrollo se utilizaron:
•	Funciones puras.
•	Recursividad.
•	Funciones de orden superior.
•	Composición funcional.
•	Inmutabilidad.
•	Procesamiento de listas.
•	Persistencia de datos.

Integrantes
•	Biloni de Bianchetti Camila Alejandra 
•	Caseres Lautaro
•	Fernando Antonio Daniel Lopez 
•	Gonzalez Avril Araceli 
•	Ruben Yunes Ramiro

Conclusión
El proyecto permitió aplicar conceptos fundamentales de programación funcional para modelar un problema real relacionado con la gestión del tránsito urbano. Además de los requerimientos solicitados inicialmente, se incorporaron mejoras como validaciones, persistencia de datos, estados intermitentes y generación automática de informes, obteniendo una solución más robusta y cercana a un sistema real.
|#