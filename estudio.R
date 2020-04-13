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


View(abcd)
names(abcd)


abcd[,.(pacientes= sum(total_mujeres,total_hombres)),by= 'Centro de salud']
casosRM[Edad=='â€”', Edad== 0]

casosRM[Sexo=='Femenino', .(promedioEdadMujer= mean(as.numeric(Edad),na.rm = T)), by='Centro de salud']
casosRM[Sexo=='Masculino',.(maxEdadHombre= max(as.numeric(Edad),na.rm = T)), by= 'Centro de salud']



library(readxl)

casos <- data.table(read_excel('Ayud_02/COVID_19_up_to_29_02_2020_cases.xlsx'), stringsAsFactors = F)

muertes <- data.table(read_excel('Ayud_02/COVID_19_up_to_29_02_2020_deaths.xlsx'), stringsAsFactors = F)

mas_dias <- data.table(read_excel('Ayud_02/COVID_19_from_01_03_2020_to_29_03_2020_all.xlsx'), stringsAsFactors = F)


casosymuertes<-merge(casos,muertes,by = c('day', 'month', 'year', 'countriesAndTerritories'), all = T, sort = F) 

casosymuertes[countriesAndTerritories== "Brazil",.(countriesAndTerritories)]
 
casosymuertes[,.(popData2018), by= 'countriesAndTerritories']  

al_29_03_2020 <- rbind(casosymuertes,mas_dias)  
  
al_29_03_2020[, .(sumacasos= sum(cases)), by= 'countriesAndTerritories']  


al_29_03_2020[cases,.(countriesAndTerritories)]  
