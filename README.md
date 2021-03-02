# Datos de analisis de Geomorfometría

Se muestran los análisis de realizados en Rstudio y en SAGA GIS, para realizar y analizar variables de Geo morfometría de una zona de estudio. 
Para el análisis de las variables de Geo morfometría de utilizo el programa Rstudio donde se genero el modelo digital de elevación, es la pieza clave para el análisis geo morfométrico .

# CÓDIGO EN  Rstudio 

# Carga de docuemntos prueba
Se guarda la información
setwd("~/R/Pruebas/Prueba_19_02_21")
# carga libreria
Se necesito cargar una librería raster 
library(raster)

# ?getData
Se consulto get Data para descagar los Modelos digitales de Elevación de la zona de estudio
#Descarga ALT
DEM<-getData('alt', country='ESP', mask=TRUE)
DEM
plot(DEM)

# ?terrain
De estos era necesario conocer las pendiente y la orientación.
x <- terrain(DEM, opt=c('slope', 'aspect'), unit='degrees')
plot(x)

# ?writeRaster
Al tener la indormacion se procedio a guardar la imagen formato TIF por lo que se istalo el paquete rgdal; y de esta forma guardar la image a ser procesada en SAGA GIS.
# Imagen TIF
# install.packages("rgdal", dependencies = TRUE)
library(rgdal)
writeRaster(DEM, "DEM.tif", overwrite=TRUE, NAflag=-9999)
 
# ANALISÍS EN SAGA GIS

El Modelos se analizo en el programa SAGA GIS, que es u sistema de análisis geo científicos automatizados de código abierto utilizado para analizar datos espaciales y gran cantidad de datos de módulos para el análisis de datos vectoriales (puntos, líneas y polígonos).
