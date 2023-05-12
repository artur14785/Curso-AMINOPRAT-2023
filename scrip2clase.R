##EJEMPLO ANALISIS DE DATOS GENERADOS POR GCMS###################
##MC.Arturo Ramírez-Ordorica curso 2023
library(ggplot2)
library(viridis)
# Cargar los datos
data <- read.csv("tricopca.csv",header = T)
head(names(data),n=10)
#Preparar los datos
data_matriz<-as.matrix(data[,-c(1:2)])

#Graficar intensidades por cada tratamiento 
hist(as.matrix(data_matriz),breaks=100)
sqrt_data_matriz<-sqrt(as.matrix(data_matriz))
hist(sqrt_data_matriz,breaks=100)

#EJERCICIO: Imputar los ceros con la media de la intensidad de cada tratamiento
media_repeticiones<-apply(data_matriz,1,mean)

for(i in 1:length(media_repeticiones)){
    data_matriz[i,][data_matriz[i,]==0]<-media_repeticiones[i]
}

sqrt_data_matriz<-sqrt(as.matrix(data_matriz))
hist(sqrt_data_matriz,breaks=100)

#Boxplot intensidades
boxplot(sqrt_data_matriz)
boxplot(sqrt_data_matriz~data$Tratamiento)

# Normalizar las variables
data_norm <- scale(sqrt_data_matriz,center = T,scale =T)
hist(data_norm,breaks = 100)
dim(data_norm)
boxplot(data_norm)
boxplot(data_norm~data$Tratamiento)

##ANÁLISIS DE COMPONENTES PRINCIPALES (PCA)##

# Realizar el análisis de componentes principales
pca <- prcomp(data_norm)
summary(pca)

# Graficar las coordenadas de las observaciones en las dos primeras componentes principales
colores<-as.factor(data$Tratamiento)
plot(pca$x[,1], pca$x[,2], 
     main="PCA", xlab="PC1", ylab="PC2",col=as.numeric(colores),
     pch=16,cex=1.5)

# Graficar texto correspondiente
text(pca$x[,1], pca$x[,2],data$Tratamiento,pos=3)


#Tres componentes principales
library(rgl)
plot3d(x=pca$x[,1],y=pca$x[,2],z=pca$x[,3],
       col=as.numeric(colores),type="s",size=2)

text3d(x=pca$x[,1],y=pca$x[,2],z=pca$x[,3],
       data$Tratamiento,add=T,pos=3)

###### NMDS (Non metric Multidimensional scaling) #######
library(vegan)
nmds_result<-metaMDS(data_matriz,distance = "bray",k = 3)
plot(nmds_result$points[,1], nmds_result$points[,2], 
     main="NMDS", xlab="PC1", ylab="PC2",col=as.numeric(colores),
     pch=16,cex=1.5)

plot3d(nmds_result$points[,1], nmds_result$points[,2],z=nmds_result$points[,3],
       col=as.numeric(colores),type="s",size=2)

###### PERMANOVA ####################
factor_tratamiento<-as.factor(data$Tratamiento)
adonis(data_matriz~factor_tratamiento,dist="euclidean")

###### k-medias #######################
library(ggplot2)
library(factoextra)
coordenadas<-data.frame(pca$x[,c(1,2)])
kmedias<-kmeans(coordenadas,centers = 2,nstart = 25)
fviz_cluster(kmedias,data=coordenadas)
plot(pca$x[,1], pca$x[,2], 
     main="PCA", xlab="PC1", ylab="PC2", col=kmedias$cluster,
     pch=16,cex=1.5)
ordihull(pca,groups = kmedias$cluster)

##### En búsqueda de biomarcadores ########
loadings_contribucion<-pca$rotation[,c(1,2)]
write.csv(loadings_contribucion,"loadings.csv")
##Podemos hacerlo manualmente...o crearnos una función para automatizar la tarea

##LLAMAR A LA FUNCIÓN loadbiomarc()
data_biomar<-loadbiomarc(loadings_contribucion,data_norm,n_biom = 20)
dim(data_biomar)
colnames(data_biomar)

#### Ahora reconstruimos el PCA unicamente con los biomarcadores
pca2 <- prcomp(data_biomar)
summary(pca2)
colores<-as.factor(data$Tratamiento)
plot(pca2$x[,1], pca2$x[,2], 
     main="PCA", xlab="PC1", ylab="PC2",col=as.numeric(colores),
     pch=16,cex=1.5)
text(pca2$x[,1], pca2$x[,2],data$Tratamiento,pos=3)
plot3d(x=pca2$x[,1],y=pca2$x[,2],z=pca2$x[,3],
       col=as.numeric(colores),type="s",size=2)

text3d(x=pca2$x[,1],y=pca2$x[,2],z=pca2$x[,3],
       data$Tratamiento,add=T,pos=3)

#### Mapa de calor de compuestos biomarcadores #####
class(data_biomar)
row.names(data_biomar) <- colores
dist_renglones<-vegdist(data_biomar,method = "euclidean")  
dist_columnas<-vegdist(t(data_biomar),method = "euclidean")  
heatmap(x = data_biomar,
        Rowv = dist_renglones,
        Colv = dist_columnas,
        col=magma(10))
#ver: https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html

#### Correlogramas ####
corr_matriz<-cor(data_biomar)
dim(corr_matriz)
dist<-vegdist(corr_matriz,method = "euclidean")  
heatmap(x = corr_matriz,
        Rowv = dist,
        Colv = dist,
        col=magma(10),
        symm = T)

corr_matriz<-cor(data_norm)
dim(corr_matriz)
dist<-vegdist(corr_matriz,method = "euclidean")  
heatmap(x = corr_matriz,
        Rowv = dist,
        Colv = dist,
        col=magma(10),
        symm = T)

### Bosques aleatorios (random forest) ###
library(randomForest)
modelo_rf <- randomForest(as.factor(data$Fuente) ~ ., 
                          data = data_norm, ntree = 1000,keep.forest=F,importance=T)
contribucion <- importance(modelo_rf)
write.csv(contribucion,"random_forest.csv")

########## BOXPLOT ALGUNOS METABOLITOS ######################
tabla_norm<-as.data.frame(data_norm)
boxplot(tabla_norm$Acetoina~as.factor(data$Fuente))

##### FIN INTRODUCCION #####






