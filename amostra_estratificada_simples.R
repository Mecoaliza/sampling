# amostra estratificada (AE) simples sem reposição de tamanho 80 

#Cria uma tabela de frequência dos valores na coluna "REG" do dataframe "MU284". 
#Isso conta quantas vezes cada valor aparece na coluna "REG" e organiza os resultados em uma tabela.

library(sampling)
data(MU284)
View(MU284)
# Regiões possíveis para fazermos a estratificação
table(MU284$REG)  #variável REG, que é o indicador da região geográfica. Gera uma tabela de frequência.

# Para encontrar o fator de ponderação dos estratos, ou seja, proporção de cada região em relação ao total

prop.table(table(MU284$REG))

# Amostra definida de tamanho n é distribuída proporcionalmente ao tamanho dos estratos. 
# tamanho de amostra em cada estrato
80*prop.table(table(MU284$REG))


# Strata -> argumento para dizer qual a variável utilizada para fazer a estratificação.
set.seed(3) #Com a semente, encontraremos as mesmas unidades selecionada
selec = strata(MU284, stratanames = "REG", size = c(8,14,10,11,16,12,5,9), method = "srswor")
selec
head(selec,10)
selec$Prob #$ simbolo para filtrar

# Utilizar o banco de dados original para criar um novo objeto com todas as variáveis para aquelas unidades amostrais.

amostra = getdata(MU284, selec) # getdata vai completar os dados amostrais com as informações da população MU284.
head(amostra, 8)

# Construir um plano amostral e depois realizar a estimação dos dados. 
# Criar um vetor de fpc com os totais populacionais.

fpc=rep(c(25,48,32,38,56,41,15,29),c(8,14,10,11,16,12,5,9)) # regiões possíveis para fazermos a estratificação e tamanho de amostra em cada estrato, dados pegos acima
fpc

# Para especificarmos o plano amostral, usaremos o comando svydesign, em que diremos a variável de estratificação, 
#as probabilidades de seleção e o fpc.

library(survey)
plano_est = svydesign(id = ~1, strata = ~Stratum, probs = ~selec$Prob, data = amostra, fpc=~fpc)

# Estimativa da média e de seu erro padrão para a variável P85 considerando o plano amostral estratificado

svymean(~P85, plano_est) # resultado dos dados estão em milhares

# Estimativa do total e de seu erro padrão para a variável P85 considerando o plano amostral estratificado

svytotal(~P85, plano_est)

# Estimativas ignorando o fator de correção de população finita (FCP)
# A utilização do fpc faz com que seja possível diminuir o erro padrão da estimação

plano_est3 = svydesign(id = ~1, strata = ~Stratum, probs = ~selec$Prob, data = amostra)
svymean(~P85, plano_est3)
svytotal(~P85, plano_est3)

# ESTIMAÇÃO POR ESTRATO
svyby(~P85, by = ~Stratum, design = plano_est, FUN = svymean) #Média

svyby(~P85, by = ~Stratum, design = plano_est, FUN = svytotal) #Total