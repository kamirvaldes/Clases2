library(readxl)
library(data.table)

casos<-data.table(read_excel('Class_02/2020-03-17-Casos-confirmados.xlsx', na = '-', col_names = T, trim_ws= T), stringsAsFactors = FALSE)


casos<-casos[Región=='Metropolitana']

names(casos)

casos[,table(Sexo)]

casos[`Centro de salud`== 'Clínica Alemana', `Centro de salud`:= 'Clinica Alemana']

casosRM[Sexo== 'Fememino', Sexo:= "Femenino"]

casosRM<-fread("Class_03/CasosCovid_RM.csv",header = T, showProgress = T,data.table = T)


casosRM[,.(sum(as.numeric(Edad),na.rm = T)), by= 'Sexo']
a<-casosRM[,.(promEdad= mean(as.numeric(Edad), na.rm = T)), by= 'Centro de salud']
b<-casosRM[,.(numerocentros=.N), by= 'Centro de salud']
c<-casosRM[Sexo=='Femenino',.(total_mujeres=.N), by= 'Centro de salud']
d<-casosRM[Sexo=='Masculino',.(total_hombres=.N), by= 'Centro de salud']

ab<-merge(a,b,by = 'Centro de salud')
abc<-merge(ab,c,by = 'Centro de salud')
abcd<-merge(abc,d,by = 'Centro de salud')
