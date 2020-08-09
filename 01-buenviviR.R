# Introducción al uso de R en Ciencias Sociales
# Daniel Quinteros (@dquinterosr)
# MÓDULO 1. CREACIÓN Y MANIPULACIÓN DE BASES DE DATOS  
# Mujeres en Chile y mercado laboral (INE, 2019)
# https://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/publicaciones-y-anuarios/publicaciones/mujeres-en-chile-y-mercado-del-trabajo---participaci%C3%B3n-laboral-femenina-y-brechas-salarialesa.pdf?sfvrsn=ade344d4_3

# PASO 1. VARIABLES 
## Crear las variables a incluir en nuestra tabla de datos: Grupo ocupacional, Mujer y Hombre.

grupo.ocupacion <- c("Miembros del Poder Ejecutivo", "Profesionales, Científicos e Intelectuales", 
                     "Técnicos y Profesionales de Nivel Medio","Empleados de Oficina", "Trabajadores de los Servicios",
                     "Agricultores y Trabajadores Calificados","Oficiales, Operarios y Artesanos de Artes Mecánicas",
                     "Operadores de Instalaciones y Máquinas y Montadores","Trabajadores no Calificados", 
                     "Otros no identificados","Total")
mujer <- c(45615,417702,383275,433708,725169,54674,159689,55349,822600,7160,3104942)
hombre <- c(140008,429077,411013,255745,342866,235392,830347,601922,797429,50397,4094196)

# PASO 2. TABLA DE DATOS 
## Generar una tabla de datos (data frame), a partir del factor y los vectores (variables) grupo.ocupacion, hombre y mujer. 
ocupacion.sexo <- data.frame(grupo.ocupacion,mujer,hombre)

# PASO 3. VISUALIZACIÓN
print(ocupacion.sexo) #para imprimir la tabla en la consola. 
View(ocupacion.sexo) #para visualizar en una nueva pestaña

# PASO 4. MANIPULACIÓN DE VARIABLES
## A. Crear dos variables más, que contengan los porcentajes de ocupación por sexo (columnas)
ocupacion.sexo$porc.mujer <- 100*ocupacion.sexo$mujer/3104942
ocupacion.sexo$porc.hombre <- 100*ocupacion.sexo$hombre/4094196

## B. Repetir paso 3

## C. Mejorar la tabla: limitar cantidad de decimales
ocupacion.sexo$porc.mujer <- round(ocupacion.sexo$porc.mujer, digits=2)
ocupacion.sexo$porc.hombre <- round(ocupacion.sexo$porc.hombre, digits=2)

## D. Repetir paso 3


## NOTA: En la sesión 03 revisaremos el código de importación de datos que se revisa en el video.



