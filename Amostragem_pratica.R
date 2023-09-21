# Utilizando o pacote sample, quero 10 resultados de uma amostra aleatória de um dado comum de seis faces.
# Replace TRUE pois é com reposição, ou seja, os números selecionados podem ser escolhidos mais de uma vez. 
install.packages("sampling")
library(sampling)
sample(1:6, 10, replace = TRUE)

#Sorteio de duas TVS e 9780 cupons
#seleção pelo método de amostragem aleatória simples sem reposição
sample(1:9780, 2, replace = FALSE)

# Para que especificar o valor inicial da semente e não números aleatórios
set.seed(5)
sample(1:9780, 2, replace=FALSE)

# Sorteio de 5 viagens,  45965 cupons, semente 7, sem reposição
set.seed(7)
sample(1:45965, 5, replace=FALSE)

#Com reposição, amostra de tam 20 de uma população de tam 100
#Os valores iguais a 1 foram selecionado 1 vez e os 2 duas vezes
set.seed(9)
s=srswor(20,100)
s
#Ver as unidades selecionadas
(1:100)[s!=0] #Que foi selecionado 1 vez
(1:100)[s==2] #Que foi selecionado 2 vezes

#Amostragem aleatória simples sem reposição
set.seed(10)
s=srswor(20,100)
(1:100)[s!=0]

# Outro exemplo de amostragem aleatória simples sem reposição
library(sampling)
set.seed(7)
s=srswor(5,45965)
(1:45965)[s!=0]

#ESTIMAÇÃO POR AMOSTRAGEM ALEATÓRIA SIMPLES
#Base de dados municipios na suécia e bélgica
data()
data("MU284")
fix(MU284)

library(sampling)
data(belgianmunicipalities)
fix(belgianmunicipalities)
N=nrow(belgianmunicipalities)
n=200

#Ver número de linhas
N = nrow(MU284)
N

#AAS sem reposição composta por 80 municípios
n = 80
set.seed(8)
selec = sample(1:N, n)
amostra = MU284[selec,]
amostra

#Estimação da média populacional
sum(amostra$P85/n)

#Estimação da variância da estimativa da média populacional
(1-n/N)*var(amostra$P85)/n

#Erro padrão ou desvio padrão da estimativa da média populacional
sqrt((1-n/N)*var(amostra$P85)/n)

#Estimação do total populacional
N*sum(amostra$P85)/n

#Estimação da variância da estimativa do total populacional

N^2*(1/n-1/N)*var(amostra$P85)

#Erro padrão da estimação do total populacional

sqrt(N^2*(1/n-1/N)*var(amostra$P85))


# Pacote Survey faz estimações só com os parâmetros do plano amostral

install.packages("survey")
library(survey)
amostra$N = N
AAS = svydesign(id = ~0, data = amostra, fpc = ~N)
AAS

# Estimação da média populacional (svymean)

svymean(~P85, AAS)


#Estimação do total populacional (svytotal)

svytotal(~P85, AAS)