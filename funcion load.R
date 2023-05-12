##loadbiomarc() 
# FUNCION PARA SELECCIONAR BIOMARCADORES DE LOS LOADINGS DE UN PCA
# loadings_contribucion1=un dataframe con los loadings de cada compuesto,
#                       los compuestos en las filas y los componentes principales
#                       en columnas
# data_norm1=la matriz numérica usada para el PCA, los nombres de los compuestos
#           deben ser los mismos que en loadings_contribucion
# n_biom=numero de biomarcadores por componente principal, por defecto n_biom = 10

loadbiomarc<-function(loadings_contribucion1,data_norm1,n_biom = 10){ #Parámetros
  
  nombres = vector() #Creamos un vector vacio llamado nombres
  for(i in 1:ncol(loadings_contribucion1)){ #Para cada i (columna) en loadings_contribucion
    contribucion = loadings_contribucion1[,c(i)] #Extraer la i-esima columna y ponerla en el vector contribucion
    orden = order(abs(contribucion),decreasing = T) #ordenar los valores absolutos de cada contribucion 
    nombres = c(nombres,names(contribucion)[head(orden,n = n_biom)]) #guardar los nombres ordenados en en el vector nombre y mostrar los 10 primeros
  } 
  #despues...
  if(any(duplicated(nombres)) == TRUE){ #Si alguno de los nombres está duplicado
    nombres = nombres[!duplicated(nombres)] #conservar solo uno de los nombres y crear un vector sin nombres duplicados
  } else { #y si no hay duplicados...
    nombres = nombres #usar el mismo vector de nombres
  }
  #despues...
  matriz_simplificada = data_norm1[,nombres] #extraer las columnas cuyos nombres coincidan  con los nombres sinn duplicar
  return(matriz_simplificada) #...y finalmente regresar la matriz de las intensidades correspondientes
}

