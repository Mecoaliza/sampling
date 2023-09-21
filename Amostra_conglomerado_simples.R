View(MU284)
library(dplyr)
library(sampling)
data(MU284)
dados=MU284

# quantos clusters nossa população está dividida
table(MU284$CL) # Usar a variável CL pois delimita o cluster para cada registro da base
# 284/50= 5,68. Amostra de 80/5,68

# 
set.seed(5)
ACS = cluster(MU284, clustername = c("CL"), size = 14 , method = c("srswor"))
head(ACS,10)
ACSs=getdata(MU284,ACS)
fix(ACSs) # ver os cluster selecionado
fpc2=rep(50,dim(ACSs)[1])
fpc2

library(survey)
PlanoC=svydesign(id=~CL,data=ACSs,probs=~ACS$Prob,fpc=~fpc2)
PlanoC

# Estimativa da média e de seu erro padrão para a variável P85 
#considerando o plano amostral conglomerado em 1 estágio

svymean(~P85,PlanoC)

svytotal(~P85,PlanoC) # Estimativa do total e de seu erro padrão 

# Resultado sem o FPC

planoC_sem_fpc = svydesign(id=~CL,data=ACSs,probs=~ACS$Prob)

svymean(~P85, planoC_sem_fpc)
svytotal(~P85, planoC_sem_fpc)