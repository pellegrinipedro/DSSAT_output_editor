setwd('G:/Mi unidad/1.Doctorado/1.Papers/regiones_stress/simulaciones/floracion/WD_MasSembrados')
rm(list=ls())
library(tidyr);library(cluster); library(NbClust); library(optpart)

#list .OSU files.
files <-list.files(path =("G:/Mi unidad/1.Doctorado/1.Papers/regiones_stress/simulaciones/floracion/somero_2020"), pattern = ".OSU",all.files=T,full.names=T)  

tablaFlo_loc <- NULL
files2 <- c(1:length(files))  #length(files)
for (i in files2){
  
  dat1 <- read.csv(files[i], sep=";")
  colnames(dat1) <- "columna"

  fin <- dim(dat1)[1] 
  
  filas <- c(3:fin)

  tablaFlo <- NULL
  
  for (x in filas){
    dat2 <- dat1[x,]
    loc <- substr(dat2$columna,39,42) 
    agua <- substr(dat2$columna, 50,52)
    agua <- ifelse(agua==' 65', '65', agua)
    agua <- ifelse(agua==' 30', '30', agua)
    ciclo <- substr(dat2$columna, 55,58)
    trt <- paste(loc, agua, ciclo, sep="-")                
    fechaFLO <- substr(dat2$columna, 118,124)
    fechaEMERG <- substr(dat2$columna, 110,116)
    fechaMF <- substr(dat2$columna, 126,132)
    anio <- substr(dat2$columna, 118,121)
    rinde <- substr(dat2$columna, 159,162)
    dat3 <- data.frame(Localidad= loc, anio=anio, TRT = trt, FechaEmerg=fechaEMERG, FechaFlor = fechaFLO, FechaMF= fechaMF, Rinde = rinde)
    tablaFlo <- rbind(tablaFlo, dat3)
    
     } 
  
  print(loc)
  tablaFlo_loc <- rbind(tablaFlo_loc, tablaFlo)
 
}


#tablaFlo_loc$soil <- rep('shallow',198)
write.csv(tablaFlo_loc, 'G:/Mi unidad/1.Doctorado/1.Papers/regiones_stress/simulaciones/floracion/somero_2020/fechaFlo_Somero_-SinPEHU_Oct2020.csv')
