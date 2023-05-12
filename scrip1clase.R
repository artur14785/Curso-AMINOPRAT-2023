##INICIANDO EN EL LENGUAJE R## 
##MC.Arturo Ramírez-Ordorica curso 2023
set.seed(150)
#Todo en R es un objeto.
#Tipos de estructuras de datos en R:
#Vector, lista, matriz, dataframe y factores
class()#Permite verificar el tipo es dato que tenemos
#tipos de datos: character, numeric(floating point), integer, logical, complex
#ejemplos:
a=c("a","ww","r")
#principales funciones para revisar atributos de los objetos en R
class(a)#tipo de obejeto
typeof(a)#tipo de objeto (como está almacenado??)
length(a) #largo (vectoroes)
dim(a)#dimensiones (matrices)
attributes(a)#metadatos asociados al objeto (nombres, p.ejemp) no todos los obejetos poseen atributos

a<-c(a,"wz","z") #usando operador de asignación " <-"
print(a)#explicita la impresión del obejeto (invocamos objeto)
#¿Qué tipo de dato contienen los siguientes objetos?:
obj1="Lenguaje R"
obj2=1:10
obj3<-rep(FALSE,3)
obj4<-c(2L,3L,1000L)
obj5<-5.23443
obj6<-10:1

ls()#Qué objetos tenemos en nuestra sesión?

#Objetos NA (Not Avaible), NaN (Not a Number) e Inf
b<-c(3,NA,3)#Surge en espacios vacios en nuestras bases de datos. Huecos
0/0#Valores indefinidos
1/0#¿Qué significa?
-Inf

#Para identificarlos: is.na() y anyNA()
d<-seq(1:10)
print(d)
d[2]<-NA#Podemos usar el operador de asignación
d[5]<-NA
d[c(2,5)]<-NA
print(d)

is.na(d)#¿Qué obtenemos?
anyNA(d)#¿Y aquí?
!is.na(d)

##Vectores
#Un vector es una colección de objetos que tienen la misma categoría de dato 
#(numerico, caracter, lógico, etc)
c()#Función concatenar
un_vector<-c(1,2,3,6,11,43,1e10)
print(un_vector)

un_vector[5]
un_vector[c(2,6)]
un_vector[-5]

#Podemos crear un vector con vector()
un_vector2<-vector("numeric",3)
?vector()
#Crear un vector lógico de tamaño 10

#¿Cuál es su longitud?

#Funciones útiles para crear vectores:
seq(from=2,to=20,by=2)#Esta es una "función" de nombre seq() con argumentos
#from=, to=, by=. Casi todas las funciones requieren de argumentos específicos
rep(2,4)#Para repetir un objeto n cantidad de veces

#Ejercicio
#Crear un vector con los números del 1 al 100 de 5 en 5
#Crear un vector con 10 nombres
#unirlos
#¿Qué longitud tiene?

#OPERACIONES MATEMÁTICAS
#Podemos hacer operaciones con vectores...los operadores son fáciles de 
#identificar por su sintaxis

#Ejercicio
#Crear un vector con la raíz cuadrada de los primeros 100 enteros
#Crear un vector con el cuadrado de los primeros 100 enteros
#arcotangente del vector anterior

##Nombres "names()"
vector_3<-vector("numeric",6)
print(vector_3)
names(vector_3)
##Crea un vector de caracteres con los nombres
#"Jośe","Inés","Raúl","Arturo","Berenice","Maricela"
#¿Cómo llamamos a los casos de cada posición en el vector?
#Asigne calificaciones a cada caso

mean()#media de calificaciones
sd()#Desviación estandar

#Podemos hace operaciones sobre vectores: suma, resta, multiplicación
#Dar ejemplos

#MATRICES
#Pueden ser concebidos como conjuntos de vectores de la misma longitud
#ordenados en filas y/o columnas.
#Están compuestos por la misma clase de elementos (a semejanza de los vectores)
matrix(seq(1:20),nrow=5,ncol=4)
#Llenar por filas??
matriz_1<-matrix(seq(1:20),nrow=5,ncol=4,byrow=TRUE)
##Posiciones [fila, columna]
matriz_1[3,2]
##Podemos hace operaciones sobre matrices.
#Suma,multiplicación por un escalar
matriz_2<-matrix(seq(1:20),nrow=5,ncol=4,byrow=TRUE)
matriz_3<-matrix(seq(1:20),nrow=5,ncol=4)
matriz_2+matriz_3
matriz_2*matriz_3#multiplicación elemento a elemento
#dim() para ver las dimensiones en la matríz
dim(matriz_2)
#Multiplicacion matricial
matriz_2 %*% t(matriz_3)#t() transpone la matriz y le das las dimensiones
#adecuadas para multiplicarlas (5x4)%*%(4x5)=5x5

#Hagamos una pequeña gŕafica
heatmap(matriz_2,Rowv = NA,Colv = NA,scale="none")
heatmap(matriz_3,Rowv = NA,Colv = NA,scale = "none")
heatmap(matriz_2 %*% t(matriz_3),Rowv = NA,Colv = NA,scale = "none")

class(matriz_2)
typeof(matriz_2)
matriz_2[2,]

#Para muchos casos, es conveniente saber los nombres de las columnas y
#renglones de las matrices
colnames(matriz_2)
row.names(matriz_2)
#Asignemos nombres a las columnas y las filas de la matriz

#Podemos crear matrices uniendo filas y columnas
cbind()#unir columnas
rbind()#unir filas

##LISTAS
#Es un objeto que contiene elementos de diferentes clases:
lista_1<-list("a",TRUE,FALSE,vector_3,matriz_2)
length(lista_1)
lista_1[[3]]
lista_1[[5]]
lista_1[[5]][3,2]

length(lista_1)
#Demosle nombres
names(lista_1)<-c("Caracter","Verdadero","Falso","Un vector","Una matriz")
#Llamemos elementos de la lista
lista_1$Verdadero

##DATAFRAME
#Son tablas de datos, y son un tipo especial de lista en forma de tabla.
#Los dataframe son el tipo más común de objeto que se usa en aplicaciones de
#análisis de datos

nombres=c("Jośe","Inés","Raúl","Arturo","Berenice","Maricela")
calificaciones=c(9,8,10,9,8,10)
salon=c("A","C","E","C","D","C")
mi_tabla=cbind(nombres,calificaciones,salon)
print(mi_tabla)
data(iris)
iris

#Nombres
colnames()
rownames()

#Para invocar columnas específicas de un data.frame, se utiliza los operadores
#[] y el $. No olvidar que un dataframe es un tipo de lista.
names(iris)
iris$Petal.Length
#Ejercicio:Poner un nombre a cada fila del dataframe iris. Con formato
#"especie_número consecutivo. Usar paste()

##OPERADORES LÓGICOS
# !=, ==, <, >, <=, >=
#Usar operadores lógicos para encontrar el número de individuos de cada especie en el vector 
#de nombres, y asignar un nombre a las filas con formato.
# "especie_número de individuo"

#R posee muchas funciones destinadas para la lectura de diferentes archivos
#Una de las más comunes es en archivos .csv o .txt

#Ejercicio: Crear un dataframe que simule una matriz de datos con 
#50 observaciones y 100 señales m/z que tenga una distribución normal
#Introducir 1500 ceros aleatoriamente en el dataframe
datos<-rnorm(50*100,mean=0,sd=2)
muestra<-sample(datos,1500)#sample() sirve para hacer un muestreo de datos
posiciones<-match(muestra,datos)
datos[posiciones]<-0
head(datos)#Observe los ceros
matriz_mz<-matrix(datos,ncol=100,nrow=50,byrow=T)
dim(matriz_mz)
mz<-seq(from=50,to=250,by=200/99)
mz<-round(mz,3)##función para redondear con 3 decimales
sufijo<-rep("m.z",length(mz))
etiqueta<-paste(mz,sufijo,sep="")
colnames(matriz_mz)<-etiqueta
obs<-1:50
obs_nomb<-paste(rep("obs",50),obs,sep = "")
rownames(matriz_mz)<-obs_nomb
mz_tabla<-data.frame(obs_nomb,matriz_mz)
dim(mz_tabla)


########BASES DE ESTRUCTURAS DE CONTROL
##Ejercicio: imputar las celdas con ceros por la media de la columna correspondiente
head(mz_tabla[,-1])
media_intensidad<-sapply(mz_tabla[,-1],mean,simplify = TRUE)#sapply entrega el resultado de una
#operación aplicada sobre cada columna de un dataframe. El promedio de las
#intensidades de cada m/z

##for...
#Permite repetir recursivamente una operación por un número dado de ciclos
mz_imputar<-mz_tabla[,-1]
#Vamos a repetir una operación de 1 al 100 (el número de columnas)
for (i in 1:length(media_intensidad)){
  mz_imputar[,i][mz_imputar[,i]==0]<-media_intensidad[i]
}

mz_imputar[,1][mz_imputar[,1]==media_intensidad[1]]

mz_imputado<-data.frame(obs_nomb,mz_imputar)##Dataframe imputado con la media

###HISTOGRAMAS EN R####
hist(as.matrix(mz_tabla[,-1]),breaks = 25)
hist(as.matrix(mz_imputado[,-1]),breaks = 25)
#as.matrix se conoce como función de coerción. Las funciones de coerción
#obligan al programa a interpretar un objeto como uno de una clase determinada
#funciones de coerción comunes: as.matrix(), as.character(), as.list(), as.data.frame()

#Ejercicio: crear un vector que simule datos periódicos con un error aleatorio
#y con regiones mínimas planas.
x<-seq(from=0, to=40,by=0.1)
sin_datos<-sin(x)
plot(sin_datos,type = "l")
error<-rnorm(length(sin_datos),mean=0,sd=0.1)
simulado=sin_datos+error
plot(simulado,type="l")
min(simulado)
simulado[simulado<=0]<-0
plot(x,simulado,type="l")

##FIN DE SESIÓN####
##Librerias necesarias (instalar con calma)
library(MASS)
library(rgl)
library(plotrix)
library(Rtsne)
#library(umap)
library(uwot) #otra implementacion
library(ica)
library(vegan)
library(ggplot2)
library(factoextra)
library(e1071)
library(vegan)

