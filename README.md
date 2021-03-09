# Datos de análisis de Geo morfometría

Se muestran los análisis de realizados en Rstudio y en SAGA GIS, para realizar y analizar variables de Geo morfometría de una zona de estudio. 
Para el análisis de las variables de Geo morfometría de utilizo el programa Rstudio donde se generó el modelo digital de elevación, es la pieza clave para el análisis geo morfométrico.


# Código en Rstudio 

*Carga de docuemntos prueba*
Se guarda la información

>``` setwd("~/R/Pruebas/Prueba_19_02_21")```

*carga libreria*
Se necesito cargar una librería raster

```>library(raster)```

 *?getData*

Se consulto get Data para descargar los Modelos digitales de Elevación de la zona de estudio.

*#Descarga ALT*

```>DEM<-getData('alt', country='ESP', mask=TRUE)```
```>DEM```
```>plot(DEM)```

 *?terrain* 

De estos era necesario conocer las pendiente y la orientación.

```>x <- terrain(DEM, opt=c('slope', 'aspect'), unit='degrees')```
```>plot(x)```

 *?writeRaster*

Al tener la información se procedió a guardar la imagen formato TIF por lo que se instaló el paquete rgdal; y de esta forma guardar la imagen a ser procesada en SAGA GIS.

Imagen TIF

```>install.packages("rgdal", dependencies = TRUE)```

```>library(rgdal)```

```>writeRaster(DEM, "DEM.tif", overwrite=TRUE, NAflag=-9999)```
 
# Analisis en SAGA GIS
El Modelos se analizó en el programa SAGA GIS, que es u sistema de análisis geo científicos automatizados de código abierto utilizado para analizar datos espaciales y gran cantidad de datos de módulos para el análisis de datos vectoriales (puntos, líneas y polígonos).
La topografía que están directamente relacionados con la variabilidad de la humedad del suelo (Pike y Evans, 2009), como la acumulación de flujo terrestre. El índice de humedad topográfica, indica áreas donde el agua tiende a acumularse por efecto de la topografía y es un índice secundario derivado de la combinación del área de ladera ascendente que drena a través de un cierto punto por unidad de longitud de contorno y la pendiente del terreno local (Wilson y Gallant 2000). 
La relación de geomorfometría e hidrología según Guevara y Vargas (2019), es útil para evitar redundancias estadísticas. 

### 1
En la opción de DATA, se cargó el DEM de España.
### 2
*En Geoprocessing se selecciona Terrain Analysis.
Luego Basic terrain analysis.
Despues se selcciona las coordenadas de la imagen.
En el valor de elevación se coloca el DEM; y asi se obtiene las 14 variables, como ser Analytical Hillshading, slope, aspect, flow acumulation...* 


# *Flujo de trabajo*
![Flujo de procesos ](https://user-images.githubusercontent.com/78845785/109633763-c6e9b980-7b48-11eb-9fcf-4a6683ab787a.jpg)


# *Referencias*
Guevara M, Vargas R (2019) Reducción de la humedad del suelo satelital mediante geomorfometría y aprendizaje automático. PLoS ONE 14 (9): e0219639. https://doi.org/10.1371/journal.pone.0219639

Pike R.J., Evans I.S., T., 2009. Chapter 1 Geomorphometry: A Brief Guide, in: Developments in Soil Science. Elsevier, pp. 3–30.

Wilson J. P., & Gallant J. C. (2000). Digital terrain analysis. Terrain analysis: Principles and applications, 6(12), 1–27. Google Scholar
