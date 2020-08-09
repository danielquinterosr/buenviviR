# Introducción al uso de R en Ciencias Sociales
# Daniel Quinteros (@dquinterosr)
# MÓDULO 3. ANÁLISIS DE DATOS: IMPORTACIÓN, EXPORTACIÓN Y ESTADÍSTICOS DESCRIPTIVOS
# DATOS ENCUESTA INSCRIPCIÓN


# PASO 8. IMPORTAR DATOS: Vamos a usar un archivo online, pero si tienen un archivo en su computador, pueden usar alguna de las siguientes sintaxis. 

## A. Archivos locales
## especificar ruta local donde guardó su archivo. "header" indica q los datos tienen encabezado y "sep" especifica el separador (en este caso, punto y coma)
#buenviviR <- read.csv("/Usuario/carpeta/subcarpeta/buenviviR.csv",header=TRUE, sep=";")
#View(buenviviR)

#Para archivo excel:
#library(readxl)
#buenviviR <- read_excel("/Usuario/carpeta/subcarpeta/buenviviR.xlsx")

#Para archivo SPSS:
#library(haven)
#buenviviR <- read_sav(""/Usuario/carpeta/subcarpeta/buenviviR.sav")


## B. Archivos online

buenviviR <- read.csv(url("https://raw.githubusercontent.com/danielquinterosr/buenviviR/master/buenviviR.csv"), header=TRUE, sep=";")
View(buenviviR)

# PASO 9. EXPLORAR EL ARCHIVO DE DATOS

### a) Tipo de objeto (pueden hacerlo para cada uno de los objetos que vayan creando)
class(buenviviR)

### b) Variables que contiene (sólo para data.frame)
names(buenviviR)

### c) Cantidad de columnas (variables) (sólo para data.frame)
ncol(buenviviR)

### d) Cantidad de filas (casos) (sólo para data.frame)
nrow(buenviviR)

### e) Cantidad de filas y columnas (sólo para data.frame)
dim(buenviviR)

### f) Información sobre las variables (sólo para data.frame). Función muy recomendable para conocer la estructura del archivo de datos.
str(buenviviR)

## BONUS: Simplificar los nombres de la variables (ayuda para recordar mejor y escribir menos)
buenviviR$edad <- buenviviR$P4...Cuántos.años.cumpliste.en.tu.último.cumpleaños.
buenviviR$sexo <- buenviviR$P5..Sexo
buenviviR$area <- buenviviR$P1..Área.disciplinar..principal.

# PASO 10. EXPORTAR LOS DATOS

#CSV
## write.csv2(buenviviR,"/Usuario/carpeta/subcarpeta/buenviviR.csv", row.names = TRUE, fileEncoding = "UTF-8") #UTF-8 permite reconocer acentos y caracteres específicos del castellano, como la Ñ

#SPSS (SAV)
##library(haven)
## write_sav(buenviviR, "buenviviR.sav")


# PASO 11. EXPLORAR LOS DATOS: ESTADÍSTICOS DESCRIPTIVOS.

### a) Media (vectores)
mean(buenviviR$edad)

### b) Mediana (vectores)
median(buenviviR$edad)

### c) Moda: Como Rbase no contiene una sintaxis específica para obtener la moda, es posible crear una función para calcularla.
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

### Luego, calcula la moda usando la función creada:
getmode(buenviviR$edad)

### d) Tablas de frecuencias absolutas (factores)

table(buenviviR$area)
table(buenviviR$sexo)

### e) Tablas de frecuencias relativas (factores)

prop.table(table(buenviviR$area))
prop.table(table(buenviviR$sexo))
