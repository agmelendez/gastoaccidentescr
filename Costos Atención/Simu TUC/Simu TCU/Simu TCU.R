library(XLConnect)
library(tidyverse)
library(janitor)
library(plotly)

#Si el archivo no muestra tildes, reabrir el archivo con Encoding UTF-8
#File->Reopen with Encoding...->UTF-8

# Lee el archivo Excel
wb0 = loadWorkbook("./Costos Traumas Producto final.xlsx")

# Lee la hoja TCE y selecciona el costo total de cada Triage
tce=readWorksheet(wb0,sheet="TCE",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)

# Lee la hoja Cara y Cuello y selecciona el costo total de cada Triage
cara.cuello=readWorksheet(wb0,sheet="Cara y Cuello",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)

# Lee la hoja Tórax y selecciona el costo total de cada Triage
torax=readWorksheet(wb0,sheet="Tórax",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)

# Lee la hoja Abdomen y selecciona el costo total de cada Triage
abdomen=readWorksheet(wb0,sheet="Abdomen",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)

# Lee la hoja Pelvis y selecciona el costo total de cada Triage
pelvis=readWorksheet(wb0,sheet="Pelvis",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)

# Lee la hoja Columna y selecciona el costo total de cada Triage
columna=readWorksheet(wb0,sheet="Columna",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(Clasificación %in% c("Cervical","Dorso lumbar") |Modelo.Tarifario=="TOTAL") %>% select(-Modelo.Tarifario)

# La hoja columna tiene 2 tipos de Lesión (Cervical y Dorso Lumbar), cada una con 4 Triage
# Se asignan los nombres de cada una
columna[2,1]="Triage 1 Cervical"
columna[3,1]="Triage 2 Cervical"
columna[4,1]="Triage 3 Cervical"
columna[5,1]="Triage 4 Cervical"
columna[7,1]="Triage 1 Dorso Lumbar"
columna[8,1]="Triage 2 Dorso Lumbar"
columna[9,1]="Triage 3 Dorso Lumbar"
columna[10,1]="Triage 4 Dorso Lumbar"

# Escoge sólo las columnas con costos
columna=columna %>% filter(!is.na(Costo))

# Lee la hoja Apendicular y selecciona el costo total de cada Triage
apendicular=readWorksheet(wb0,sheet="Apendicular",region="A2:D") %>% fill(Clasificación) %>% select(-Manejo.de.Traumas.por.escenarios) %>% filter(str_detect(Modelo.Tarifario,"TOTAL")) %>% select(-Modelo.Tarifario)

# Apendicular, Triage 1 tiene 2 tipos: Con y Sin Protesis
apendicular[1,1]="Triage 1 Sin Protesis"
apendicular[2,1]="Triage 1 Con Protesis"

# Casos 1 y 2 son los más frecuentes 
# Caso 3 son los de mayor gravedad
# Casos 4 y 5 son los menos reiterativos

# Cada número del vector equivale a la probabilidad de ocurrencia de cada caso o escenario
p=c(0.6,0.6,0.2,0.2,0.2)

# Cantidad de accidentes a simular a simular
t=50000

# Semilla para replicar resultados
set.seed(65535)

# Se generan casos aleatorios con un número de casos posibles de combinaciones, es decir, el número de triages que pueden suceder a la vez en el caso
sim=data.frame(caso=as.factor(sample(c("Caso 1","Caso 2","Caso 3","Caso 4","Caso 5"),size=t,replace=T,prob=p))) %>% mutate(comb=ifelse(caso=="Caso 2",sample(1:2),sample(1:3)))

# Se genera aleatoriamente el tipo de combinación de triages por caso, según el número aleatorio generado anteriormente
sim=sim %>% mutate(comb1=case_when(caso=="Caso 2" & comb==1~sample(c("1","2"),1),caso=="Caso 2" & comb==2~"1-2",
                               caso=="Caso 1" & comb==1~sample(c("1","2","3"),1),caso=="Caso 1" & comb==2~sample(c("1-2","2-3","1-3"),1),caso=="Caso 1" & comb==3~"1-2-3",
                               caso=="Caso 3" & comb==1~sample(c("1","2","3"),1),caso=="Caso 3" & comb==2~sample(c("1-2","2-3","1-3"),1),caso=="Caso 3" & comb==3~"1-2-3",
                               caso=="Caso 4" & comb==1~sample(c("1","2","3"),1),caso=="Caso 4" & comb==2~sample(c("1-2","2-3","1-3"),1),caso=="Caso 4" & comb==3~"1-2-3",
                               caso=="Caso 5" & comb==1~sample(c("1","2","3"),1),caso=="Caso 5" & comb==2~sample(c("1-2","2-3","1-3"),1),caso=="Caso 5" & comb==3~"1-2-3"))

# Se separa la columna de combinaciones en 3 posibles generadas anteriormente y se ponen 0 si no tiene un segundo o tercer triage
sim=as.data.frame(sim %>% separate(comb1,c("A","B","C"),sep="-") %>% select(-comb))

# Se eliminan valores nulos
sim$B[is.na(sim$B)]=0
sim$C[is.na(sim$C)]=0
sim$A=as.numeric(sim$A)
sim$B=as.numeric(sim$B)
sim$C=as.numeric(sim$C)

# Se asignan los costos según el tipo de caso y el triage seleccionado anteriormente
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

# Se eliminan valores nulos
sim$costo1[is.na(sim$costo1)]=0
sim$costo2[is.na(sim$costo2)]=0
sim$costo3[is.na(sim$costo3)]=0

# Se hace una suma de costos por escenario
sim=sim %>% mutate(costo_final=costo1+costo2+costo3)

# Se seleccionan sólo las variables de caso y costo final
sim1=sim %>% select(caso,costo_final)

# Se realiza el resumen del número de casos simulados y el costo total de estos
sim1 %>% group_by(caso) %>% summarize(n=n(),suma=sum(costo_final))

# Se genera un gráfico de barras con los casos y los costos simulados
plot_ly(sim1 %>% group_by(caso) %>% tally(),x=~caso,y=~n,type="bar")
plot_ly(sim1 %>% group_by(caso) %>% summarize(suma=sum(costo_final)),x=~caso,y=~suma,type="bar")
