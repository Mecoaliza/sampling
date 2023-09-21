

library(sampling)
data(belgianmunicipalities)
fix(belgianmunicipalities)
N=nrow(belgianmunicipalities)
n=200

# Selecionar nossa amostra de tamanho 200 com a semente de valor 2.

set.seed(2)
selec = sample(1:N, n)
amostra = belgianmunicipalities[selec,]

#vamos utilizar o pacote survey para fazer a estimação dos dados

library(survey)
amostra$N = N
AAS = svydesign(id = ~1, data = amostra, fpc = ~N)
AAS

# Estimar a média e seu erro padrão
svymean(~averageincome, AAS)