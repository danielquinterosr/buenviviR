# Introducción al uso de R en Ciencias Sociales
# Daniel Quinteros (@dquinterosr)
# MÓDULO 2. VISUALIZACIÓN DE DATOS: TABLAS Y GRÁFICOS  
# Mujeres en Chile y mercado laboral (INE, 2019)
# https://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/publicaciones-y-anuarios/publicaciones/mujeres-en-chile-y-mercado-del-trabajo---participaci%C3%B3n-laboral-femenina-y-brechas-salarialesa.pdf?sfvrsn=ade344d4_3


## VAMOS A COMENZAR DESDE CERO... ELIMINEMOS LOS OBJETOS CREADOS
rm(list=(ls)())


# PASO 5. PRESENTACIÓN DE TABLAS
library(kableExtra)
ocupacion.sexo %>% 
  kable() %>%
  kable_styling()


## Error??? Bienvenidxs a R!

## PARA EVITAR CARGAR TODO EL CÓDIGO NUEVAMENTE, PODEMOS EJECUTAR EL SCRIPT "01-buenviviR.R"
source("01-buenviviR.R") ## Para evitar que abra nuevas pestañas, depurar el código original... eliminar View() (fila 24).

## Ahora si podemos correr la tabla nuevamente (no es necesario volver a cargar "kableExtra()").
ocupacion.sexo %>% 
  kable() %>%
  kable_styling()


# PASO 6. PERSONALIZACION DE TABLAS

## Cambiemos el nombre de las columnas
ocupacion.sexo %>% 
  kable(col.names = c("Grupo ocupacional","Mujer","Hombre")) %>%
  kable_styling()

## Error otra vez??? Paciencia, la vas a necesitar. Faltaban los nombres para las columnas de %
ocupacion.sexo %>% 
  kable(col.names = c("Grupo ocupacional","Mujer","Hombre","% Mujer","% Hombre")) %>%
  kable_styling()

## Cambiemos el formato de la tabla
ocupacion.sexo %>% 
  kable(col.names = c("Grupo ocupacional","Mujer","Hombre","% Mujer","% Hombre")) %>%
  kable_styling(bootstrap_options = "striped", full_width = F, position = "left", font_size = 11)


# PASO 7. INTRODUCCIÓN A GGPLOT

## A) GRÁFICOS DE PIE O TORTA 
## S E C C I Ó N   E L I M I N A D A ... LAS TORTAS SON PARA LOS CUMPLEAÑOS! Sugiero usar alternativas como barras, treemaps... o waffles! (https://nsaunders.wordpress.com/2017/09/08/infographic-style-charts-using-the-r-waffle-package/)
## Hay mucha info al respecto. Acá un artículo para comenzar: https://www.elartedepresentar.com/2011/11/las-tartas-son-para-el-postre-5-razones-por-las-que-no-uso-graficos-circulares/)

## B) GRÁFICOS DE BARRA
barplot(ocupacion.sexo$mujer,main="Categoría ocupacional de las mujeres en Chile 2019",xlab="")
barplot(ocupacion.sexo$mujer,main="Categoría ocupacional de las \n mujeres en Chile 2019",xlab="",
        names.arg=ocupacion.sexo$"grupo.ocupacion", cex.axis=0.7, cex.names=0.5)

## C) EL PAQUETE "ggplot2()" PERMITE CREAR GRÁFICOS DE TODO TIPO, CON MÚLTIPLES OPCIONES DE CONFIGURACIÓN Y PERSONALIZACIÓN.
library(ggplot2)
ggplot(ocupacion.sexo,aes(x=factor(grupo.ocupacion), y=porc.mujer))+
  geom_bar(position="dodge", stat = "identity", width = 0.7) 

## D) TÍTULOS, SUBTÍTULOS Y NOTAS
ggplot(ocupacion.sexo,aes(x=factor(grupo.ocupacion), y=porc.mujer))+
  geom_bar(position="dodge", stat = "identity", width = 0.7) +
  labs(  x="", y="",
         title="Gráfico 1. Categoría ocupacional de \n las mujeres en Chile 2019", 
         subtitle="Un subtítulo",
         caption= "Fuente: INE (2019)")

## E) TIENE SENTIDO GRAFICAR LA BARRA DE TOTAL? PARA ELIMINARLA, HACER SUBSET [FILAS, COLUMNAS]
ocupacion.sexo2 <- ocupacion.sexo[-11,]

## F) AGREGAR ETIQUETAS DE VALOR Y CAMBIAR COLOR (VES ALGÚN CAMBIO EN EL EJE Y??) 
ggplot(ocupacion.sexo2,aes(x=factor(grupo.ocupacion), y=porc.mujer))+
  geom_bar(position="dodge", stat = "identity", width = 0.7, fill="red") +
  labs(  x="", y="",
         title="Gráfico 1. Categoría ocupacional de \n las mujeres en Chile 2019", 
         subtitle="Un subtítulo",
         caption= "Fuente: INE (2019)")  +
  geom_text(data=ocupacion.sexo2, aes(y=porc.mujer, label=paste0(porc.mujer,"%")),
            position=position_dodge(width = 0.7), vjust=-0.6, size=2.5, fontface="bold", show.legend=FALSE) 
  
## G) PODEMOS CONFIGURAR DISTINTOS ASPECTOS DEL FORMATO (TIPO Y TAMAÑO LETRA, ETC) CON LA FUNCIÓN "theme()"
## PODEMOS REAJUSTAR LA ESCALA DEL EJE Y, PARA REPRESENTAR CORRECTAMENTE EL % CON "coord_cartesian()" 
ggplot(ocupacion.sexo2,aes(x=factor(grupo.ocupacion), y=porc.mujer)) +
  geom_bar(position="dodge", stat = "identity", width = 0.7, fill="red") +
  labs(  x="", y="",
         title="Gráfico 1. Categoría ocupacional de \n las mujeres en Chile 2019", 
         subtitle="Un subtítulo",
         caption= "Fuente: INE (2019)")  +
  geom_text(data=ocupacion.sexo2, aes(y=porc.mujer, label=paste0(porc.mujer,"%")),
            position=position_dodge(width = 0.7), vjust=-0.6, size=2.5, fontface="bold", show.legend=FALSE) +
  coord_cartesian(ylim = c(0, 100)) +
  theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5),
        legend.position="top", legend.title = element_blank(),legend.text = element_text(size=7),
        axis.text.x = element_text(size=6), axis.text.y=element_text(size=9),
        rect = element_rect(fill = "transparent"), 
        panel.background = element_rect(colour = 'transparent'),
        plot.background = element_rect(fill = "transparent", color = NA),
        legend.key.size = unit(0.7,"line"),
        plot.subtitle=element_text(size=8, face = "italic"))


## H) PUEDES LEER LAS ETIQUETAS? PODEMOS INSERTAR UNA FUNCIÓN PARA SEPARAR CADA PALABRA EN UNA FILA DISTINTA () 
addline_format <- function(x,...){
  gsub('\\s','\n',x)
}

## I) ACORTAR ETIQUETAS UTILIZANDO LA FUNCIÓN "addline_format" QUE ACABAMOS DE CREAR
## GIRAR EL GRÁFICO CON "coord_flip()"
## COMO GIRAMOS EL GRÁFICO, CAMBIAR "vjust" por "hjust" EN "geom_text()"
ggplot(ocupacion.sexo2,aes(x=factor(grupo.ocupacion), y=porc.mujer))+
  geom_bar(position="dodge", stat = "identity", width = 0.7, fill="red") +
  labs(  x="", y="",
         title="Gráfico 1. Categoría ocupacional de \n las mujeres en Chile 2019", 
         subtitle="Un subtítulo",
         caption= "Fuente: INE (2019)")  +
  geom_text(data=ocupacion.sexo2, aes(y=porc.mujer, label=paste0(porc.mujer,"%")),
            position=position_dodge(width = 0.7), vjust=-0.6, size=2.5, fontface="bold", show.legend=FALSE) + #cambiar "hjust=-0.2"
  coord_cartesian(ylim = c(0, 100)) +
  theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5),
        legend.position="top", legend.title = element_blank(),legend.text = element_text(size=7),
        axis.text.x = element_text(size=6), axis.text.y=element_text(size=6),
        rect = element_rect(fill = "transparent"), 
        panel.background = element_rect(colour = 'transparent'),
        plot.background = element_rect(fill = "transparent", color = NA),
        legend.key.size = unit(0.7,"line"),
        plot.subtitle=element_text(size=8, face = "italic")) +
  coord_flip() +
 scale_x_discrete(breaks=unique(ocupacion.sexo2$grupo.ocupacion),
                  labels=addline_format(c("Poder Ejecutivo", "Profesionales y Científicos", 
                        "Técnicos y Profesionales","Empleados Oficina", "Servicios",
                        "Agricultores","Artes Mecánicas",
                        "Operadores y Montadores","No Calificados", "Otros"))) ## FUNCIÓN CREADA EN FILA 107
