library(rJava)
library(XLConnect)
library(XLConnectJars)
library(tidyverse)
library(janitor)
library(plotly)

wb0 = loadWorkbook("./Costos Traumas Producto final.xlsx")

tce=readWorksheet(wb0,sheet="TCE",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)
cara.cuello=readWorksheet(wb0,sheet="Cara y Cuello",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)
torax=readWorksheet(wb0,sheet="Tórax",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)
abdomen=readWorksheet(wb0,sheet="Abdomen",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)
pelvis=readWorksheet(wb0,sheet="Pelvis",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)
columna=readWorksheet(wb0,sheet="Columna",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Clasificación %in% c("Cervical","Dorso lumbar") |Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)
columna[2,1]="Triage 1 Cervical"
columna[3,1]="Triage 2 Cervical"
columna[4,1]="Triage 3 Cervical"
columna[5,1]="Triage 4 Cervical"
columna[7,1]="Triage 1 Dorso Lumbar"
columna[8,1]="Triage 2 Dorso Lumbar"
columna[9,1]="Triage 3 Dorso Lumbar"
columna[10,1]="Triage 4 Dorso Lumbar"
columna=columna %>% filter(!is.na(Costo))
apendicular=readWorksheet(wb0,sheet="Apendicular",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(str_detect(Modelo.Tarifario,"TOTAL")) %>% select(-Modelo.Tarifario)
apendicular[1,1]="Triage 1 Sin Protesis"
apendicular[2,1]="Triage 1 Con Protesis"

# Casos 1 y 2 son los más frecuentes 
# Caso 3 son los de mayor gravedad
# Casos 4 y 5 son los menos reiterativos

p=c(0.6,0.6,0.2,0.2,0.2)

set.seed(65535)
sim=data.frame(caso=as.factor(sample(c("Caso 1","Caso 2","Caso 3","Caso 4","Caso 5"),size=50000,replace=T,prob=p))) %>% mutate(comb=ifelse(caso=="Caso 2",sample(1:2),sample(1:3)))
sim=sim %>% mutate(comb1=case_when(caso=="Caso 2" & comb==1~sample(c("1","2"),1),caso=="Caso 2" & comb==2~"1-2",
                               caso=="Caso 1" & comb==1~sample(c("1","2","3"),1),caso=="Caso 1" & comb==2~sample(c("1-2","2-3","1-3"),1),caso=="Caso 1" & comb==3~"1-2-3",
                               caso=="Caso 3" & comb==1~sample(c("1","2","3"),1),caso=="Caso 3" & comb==2~sample(c("1-2","2-3","1-3"),1),caso=="Caso 3" & comb==3~"1-2-3",
                               caso=="Caso 4" & comb==1~sample(c("1","2","3"),1),caso=="Caso 4" & comb==2~sample(c("1-2","2-3","1-3"),1),caso=="Caso 4" & comb==3~"1-2-3",
                               caso=="Caso 5" & comb==1~sample(c("1","2","3"),1),caso=="Caso 5" & comb==2~sample(c("1-2","2-3","1-3"),1),caso=="Caso 5" & comb==3~"1-2-3"))

sim=as.data.frame(sim %>% separate(comb1,c("A","B","C"),sep="-") %>% select(-comb))
sim$B[is.na(sim$B)]=0
sim$C[is.na(sim$C)]=0
sim$A=as.numeric(sim$A)
sim$B=as.numeric(sim$B)
sim$C=as.numeric(sim$C)

sim=sim %>% mutate(costo1=case_when(caso=="Caso 1" & A==1~apendicular[sample(1:2,1),2],caso=="Caso 1" & A==2~tce[3,2],caso=="Caso 1" & A==3~abdomen[2,2],
                                caso=="Caso 2" & A==1~tce[4,2],caso=="Caso 2" & A==2~cara.cuello[4,2],
                                caso=="Caso 3" & A==1~cara.cuello[1,2],caso=="Caso 3" & A==2~torax[2,2],caso=="Caso 3" & A==3~apendicular[sample(1:2,1),2],
                                caso=="Caso 4" & A==1~abdomen[1,2],caso=="Caso 4" & A==2~pelvis[4,2],caso=="Caso 4" & A==3~torax[4,2],
                                caso=="Caso 5" & A==1~pelvis[3,2],caso=="Caso 5" & A==2~abdomen[3,2],caso=="Caso 5" & A==3~apendicular[4,2]),
               costo2=case_when(caso=="Caso 1" & B==1~apendicular[sample(1:2,1),2],caso=="Caso 1" & B==2~tce[3,2],caso=="Caso 1" & B==3~abdomen[2,2],
                                caso=="Caso 2" & B==1~tce[4,2],caso=="Caso 2" & B==2~cara.cuello[4,2],
                                caso=="Caso 3" & B==1~cara.cuello[1,2],caso=="Caso 3" & B==2~torax[2,2],caso=="Caso 3" & B==3~apendicular[sample(1:2,1),2],
                                caso=="Caso 4" & B==1~abdomen[1,2],caso=="Caso 4" & B==2~pelvis[4,2],caso=="Caso 4" & B==3~torax[4,2],
                                caso=="Caso 5" & B==1~pelvis[3,2],caso=="Caso 5" & B==2~abdomen[3,2],caso=="Caso 5" & B==3~apendicular[4,2]),
               costo3=case_when(caso=="Caso 1" & C==1~apendicular[sample(1:2,1),2],caso=="Caso 1" & C==2~tce[3,2],caso=="Caso 1" & C==3~abdomen[2,2],
                                caso=="Caso 2" & C==1~tce[4,2],caso=="Caso 2" & C==2~cara.cuello[4,2],
                                caso=="Caso 3" & C==1~cara.cuello[1,2],caso=="Caso 3" & C==2~torax[2,2],caso=="Caso 3" & C==3~apendicular[sample(1:2,1),2],
                                caso=="Caso 4" & C==1~abdomen[1,2],caso=="Caso 4" & C==2~pelvis[4,2],caso=="Caso 4" & C==3~torax[4,2],
                                caso=="Caso 5" & C==1~pelvis[3,2],caso=="Caso 5" & C==2~abdomen[3,2],caso=="Caso 5" & C==3~apendicular[4,2]))

sim$costo1[is.na(sim$costo1)]=0
sim$costo2[is.na(sim$costo2)]=0
sim$costo3[is.na(sim$costo3)]=0

sim=sim %>% mutate(costo_final=costo1+costo2+costo3)

sim1=sim %>% select(caso,costo_final)

sim1 %>% group_by(caso) %>% summarize(n=n(),suma=sum(costo_final))

plot_ly(sim1 %>% group_by(caso) %>% tally(),x=~caso,y=~n,type="bar")
plot_ly(sim1 %>% group_by(caso) %>% summarize(suma=sum(costo_final)),x=~caso,y=~suma,type="bar")
