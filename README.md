# Datos de análisis de Geo morfometría

Se muestran los análisis de realizados en Rstudio y en SAGA GIS, para realizar y analizar variables de Geo morfometría de una zona de estudio. 
Para el análisis de las variables de Geo morfometría de utilizo el programa Rstudio donde se generó el modelo digital de elevación, es la pieza clave para el análisis geo morfométrico.Los datos se agregaron a partir de datos de resolución SRTM de 90 m entre -60 y 60 de latitud. 'GADM' es una base de datos de límites administrativos globales. 'worldclim' es una base de datos de datos climáticos globales interpolados. 'SRTM' se refiere al CGIAR-SRTM lleno de agujeros (resolución de 90 m). 'countries' tiene polígonos para todos los países con una resolución más alta que los datos de 'wrld_simpl' en el paquete maptools. Pero se obtuvo un modelo por medio de Rstudio a 1 km de resolución espacial. 



# Código en Rstudio 

*Carga de docuemntos prueba*
Se guarda la información

> setwd("~/R/Pruebas/Prueba_19_02_21")

*carga libreria*
Se necesito cargar una librería raster

```library(raster)```

 *?getData*

Se consulto get Data para descargar los Modelos digitales de Elevación de la zona de estudio.El MDE (DEM), es una capa de información fundamental, y de él pueden extraerse un número muy elevado de nuevos parámetros.

*#Descarga ALT*

Si el nombre es 'alt' o 'GADM', debe proporcionar un argumento 'country ='. Los países se especifican por sus códigos ISO de 3 letras. Se puede establecer 'máscara' en FALSO "FALSE" si los valores de los países vecinos se establecen, de lo contrario se coloca VERDADERO " TRUE", para conocer el del país en específico.  

```DEM<-getData('alt', country='ESP', mask=TRUE)```
```DEM```
```plot(DEM)```

##### se concocieron sus coordenadas

> DEM
> class      : RasterLayer 
> dimensions : 1044, 1656, 1728864  (nrow, ncol, ncell)
> resolution : 0.008333333, 0.008333333  (x, y)
> extent     : -9.4, 4.4, 35.2, 43.9  (xmin, xmax, ymin, ymax)
> crs        : +proj=longlat +datum=WGS84 +no_defs 
> source     : C:/Users/Usuario/Documents/Análisis de Tesis en Rstudio y SAGA GIS/R/Tesis12_02_21/ESP_msk_alt.grd 
> names      : ESP_msk_alt 
> values     : -13, 3322  (min, max)

 *?terrain* 

De estos era necesario conocer las pendiente y la orientación, que son variables primarias.

```x <- terrain(DEM, opt=c('slope', 'aspect'), unit='degrees')```
```plot(x)```

 *?writeRaster*

Al tener la información se procedió a guardar la imagen formato TIF por lo que se instaló el paquete rgdal; y de esta forma guardar la imagen a ser procesada en SAGA GIS.

Imagen TIF

```install.packages("rgdal", dependencies = TRUE)```

```library(rgdal)```

```writeRaster(DEM, "DEM.tif", overwrite=TRUE, NAflag=-9999)```
 
# Analisis en SAGA GIS
El Modelos se analizó en el programa SAGA GIS, que es u sistema de análisis geo científicos automatizados de código abierto utilizado para analizar datos espaciales y gran cantidad de datos de módulos para el análisis de datos vectoriales (puntos, líneas y polígonos).
La topografía que están directamente relacionados con la variabilidad de la humedad del suelo (Pike y Evans, 2009), como la acumulación de flujo terrestre. El índice de humedad topográfica, indica áreas donde el agua tiende a acumularse por efecto de la topografía y es un índice secundario derivado de la combinación del área de ladera ascendente que drena a través de un cierto punto por unidad de longitud de contorno y la pendiente del terreno local (Wilson y Gallant 2000). 
La relación de geomorfometría e hidrología según Guevara y Vargas (2019), es útil para evitar redundancias estadísticas. 

Tambien dentro del mismo análisis de terreno de SAGA GIS, se obtuvieron las variables de incidencia de radiacón solar. La herramienta básica de análisis del terreno es muy poderosa, produce automáticamente 14 salidas métricas hidrológicas y de terreno.

### 1
En la opción de DATA, se cargó el DEM de España.
### 2
*En Geoprocessing se selecciona Terrain Analysis.
Luego Basic terrain analysis.
Despues se selcciona las coordenadas de la imagen.
En el valor de elevación se coloca el DEM; y asi se obtiene las 14 variables, como ser Analytical Hillshading, slope, aspect, flow acumulation...*

###### Se calcularon otras dos variables de incidencia de radiacón solar
Esta función calcula la cantidad de radiación solar entrante (insolación) según la pendiente, el aspecto y las propiedades atmosféricas.
*SAGA GIS
Solar Radiation: (Terrain Analysis > Lighting > Potential Incoming solar radiation

*Descripción
Modelo de entrada digital de elevación (DEM). Proporciona para cada píxel la longitud en grados. Unidades constante solar en Joule; predeterminado: 8.164 J / cm2 / min (= 1360.7 kWh / m2; la constante solar más comúnmente utilizada de 1367 kWh / m2 corresponde a 8.202 J / cm2 / min), altura de la atmósfera en m; predeterminado: 12000 m, si no se proporciona una cuadrícula de vapor de agua, este argumento especifica una presión de vapor de agua constante que es uniforme en el espacio; en mbar, por defecto 10 mbar. 

# *Flujo de trabajo*
![Especifico](https://user-images.githubusercontent.com/78845785/111362508-2ab6cb00-868f-11eb-9d99-fbd22696464a.jpg)



# *Referencias*
Guevara M, Vargas R (2019) Reducción de la humedad del suelo satelital mediante geomorfometría y aprendizaje automático. PLoS ONE 14 (9): e0219639. https://doi.org/10.1371/journal.pone.0219639

Pike R.J., Evans I.S., T., 2009. Chapter 1 Geomorphometry: A Brief Guide, in: Developments in Soil Science. Elsevier, pp. 3–30.

Wilson J. P., & Gallant J. C. (2000). Digital terrain analysis. Terrain analysis: Principles and applications, 6(12), 1–27. Google Scholar

Insolación solar SAGA GIS: https://rdrr.io/cran/RSAGA/man/rsaga.insolation.html

SRTM:https://srtm.csi.cgiar.org/
WorldClim:https://www.worldclim.org/data/index.html


