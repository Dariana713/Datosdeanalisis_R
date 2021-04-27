# Cargar librerias 
library(raster)
library(RStoolbox)
library(FactoInvestigate)
library(FactoMineR)
library(factoextra)

#Cargar capeta de insolación
setwd("~/Análisis de Tesis en Rstudio y SAGA GIS/Variables/Georfometria R_SAGA GIS/Indice de Radiacioón solar")
list.files(pattern = ".sgrd")
insolación <- stack(list.files(pattern = ".sgrd"), native=TRUE)
plot(insolación)

#carpeta de trabajo de Geomorfometría  
setwd("~/Análisis de Tesis en Rstudio y SAGA GIS/Variables/Georfometria R_SAGA GIS/Prueba_19_02_21/Variables de SAGA GIS")


#Unificar archivos "sgrd", en un solo stack, que se llamará top
list.files(pattern = ".sgrd")
top <- stack(list.files(pattern = ".sgrd"), native=TRUE)
plot(top)


#Se realiza la cargar el DEM
dem <- raster("~/Análisis de Tesis en Rstudio y SAGA GIS/Variables/Georfometria R_SAGA GIS/Prueba_19_02_21/DEM.tif")

#Se unifica en un solo stack, el "top y dem",  (solo correr una vez para no generar doble variable).
top1 <- stack(top, dem, insolación)
plot(top1)

## Se estandariza el top1

#PCA. spca me dice que si o no puedo estandarizar, en este caso si se entandarizo  para reducir las dimensiones de los valores. Hay que escalar los datos par centrar las medias
rpc <- rasterPCA(top1, spca=TRUE)


## Model parameters, con cada uno de los componetes y sus varianzas 
summary(rpc$model)
plot(rpc$model)


#loading es para intepretar las variables relacionadas con los componentes 
loadings(rpc$model)
plot(rpc$model)

#Cambiando 
top1_df <- na.omit(as.data.frame(top1))


#Esto es para?    La escala?, hacerlo con mas datos, intentar con 1000      
sr_1000 <- sampleRandom(top1, 1000)

res = PCA(sr_1000)

Investigate(res)


#RGB
ggRGB(rpc$map,1,2,3, stretch="lin", q=0)

#
if(require(gridExtra)){
  plots <- lapply(1:3, function(x) ggR(rpc$map, x, geom_raster = TRUE))
  grid.arrange(plots[[1]],plots[[2]], plots[[3]], ncol=2)
}

# Kmeans 

#cargar librerias 
library("raster")  
library("cluster")
library("randomForest")

#
image <- rpc$map
#image <- top1

#Extraigo los valores
v <- getValues(image)
#Se eliminan los "na"
i <- which(!is.na(v))
#Se valoran los "na"
v <- na.omit(v)

#Generar el Kmeans, los grupos de terrenos probar con 2 grupos (hacer una diapositiva) ¿CUANTAS UNIDADES DE TRABAJO ES MAS RAZONABLE QUE PODAMOS DISTINGUIR?
E <- kmeans(v, 12, iter.max = 100, nstart = 10)

kmeans_raster <- raster(image)
kmeans_raster[i] <- E$cluster
plot(kmeans_raster)

#Generar el Kmeans, los grupos de terrenos probar con 3 grupos (hacer una diapositiva) ¿CUANTAS UNIDADES DE TRABAJO ES MAS RAZONABLE QUE PODAMOS DISTINGUIR?
E <- kmeans(v, 4, iter.max = 100, nstart = 10)

kmeans_raster <- raster(image)
kmeans_raster[i] <- E$cluster
plot(kmeans_raster)

#loading_ selección de

fviz_nbclust(sr_1000, kmeans, method = "wss")  

fviz_nbclust(sr_1000, kmeans, method = "silhouette")



