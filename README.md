# Amostragem Aleatória Simples (AAS)
A amostragem aleatória simples em análises de Business Intelligence (BI) é útil para economizar tempo e recursos ao trabalhar com conjuntos de dados grandes, explorar inicialmente dados, testar hipóteses, melhorar o desempenho em sistemas interativos, e lidar com limitações de recursos. Ela permite uma análise eficiente, desde que a amostra seja verdadeiramente aleatória e representativa do conjunto de dados original. No entanto, a escolha entre amostragem e análise completa depende dos objetivos específicos do projeto de BI e do contexto da análise. Para conhecer alguns outros tipos de amostragens podem conferir nesse [artigo](https://medium.com/@mecoaliza/o-poder-da-amostragem-decis%C3%B5es-de-neg%C3%B3cios-mais-inteligentes-com-poucos-dados-36b70359ef64) que escrevi.

 ## O objetivo desse projeto é:
✅ A utilização de pacotes como o Sampling, Survey e Ggplot2.

✅ Amostragem Aleatória Simples (AAS) com uma base de dados do próprio R.

✅ Estimação de Média, Variância e Erro Padrão. 

✅ Visualizações dos dados com gráficos de barras e boxplot.

✅ Utilização de funções svymean e svytotal.


### Inicialmente vamos instalar os pacotes  e carregar as bibliotecas que são utilizadas: 

````
install.packages("sampling")
library(sampling)
install.packages("survey")
library(survey)
install.packages("ggplot2")
library(ggplot2)
````

### Vamos carregar uma base de dados do próprio R, que possui 11 variáveis diferentes descritas para os 284 municípios na Suécia. 

Variável | Descrição
---------|-----------
ID | Identificador de cada município.
P85 | População de 1985 (em milhares). 
P75 | População de 1975 (em milhares). 
RMT85 | Receitas da tributação municipal de 1985 (em milhões de coroas suecas). 
CS82 | Número de políticos conservadores no conselho municipal. 
SS82 | Número de políticos sociais-democratas no conselho municipal. 
S82 | Número total de políticos no conselho municipal. 
ME84 | Número de funcionários municipais em 1984. 
REV84 | Valores imobiliários de acordo com a avaliação de 1984 (em milhões de coroas suecas). 
REG | Indicador de região geográfica. 
CL | Indicador de cluster (um cluster consiste em um conjunto de municípios vizinhos). 

```` 
data("MU284")
````

### Vamos definir N como o total de número de linhas

````
N = nrow(MU284)
N
````
### Vou querer uma amostragem com 80 municípios sem reposição

````
n = 80
set.seed(8)
selec = sample(1:N, n)
amostra = MU284[selec,]
amostra
````
### Fazer estimações utilizando a função **svydesign** do pacote Survey

````
amostra$N = N
AAS = svydesign(id = ~0, data = amostra, fpc = ~N)
AAS
````
id = ~0: Define a identificação da unidade amostral como zero, pois não há estratificação ou clustering considerados no plano amostral, indicando que a amostra foi obtida por amostragem aleatória simples.

data = amostra: Indica que os dados da amostra serão usados para realizar as estimativas.

fpc = ~N: Especifica o efeito de correção de população finita (fpc) para levar em consideração o tamanho da população. O argumento "~N" indica que o tamanho da população "N" será usado como fpc.

### Calculando a Média populacional (P85) e o erro padrão com svymean

````
svymean(~P85, AAS)
````

### Calculando a variância da média populacional

````
(1-n/N)*var(amostra$P85)/n
````

### Calculando a estimação do total populacional (P85) e o erro padrão com svytotal

````
svytotal(~P85, AAS)
````

### Calculandoa variância do total populacional 

````
N^2*(1/n-1/N)*var(amostra$P85)
````

### Agora vamos utilizar o ggplot2 para criar um gráfico de barras e visualizar quais a Regiões Geográficas ficaram com mais amostras

````
ggplot(amostra, aes(x = factor(REG))) +
  geom_bar() +
  labs(x = "Região Geográfica", y = "Contagem") +
  ggtitle("Distribuição das Regiões Geográficas na Amostra")
````
![](https://github.com/Mecoaliza/sampling/blob/main/3.png)



### E visualizar um gráfico boxplt para saber a Distribuição da População por Região na Amostra

````
ggplot(amostra, aes(x = factor(REG), y = P85)) +
  geom_boxplot() +
  labs(x = "Região Geográfica", y = "População de 1985") +
  ggtitle("Distribuição da População de 1985 por Região na Amostra")
````
![Saída](https://github.com/Mecoaliza/sampling/blob/main/2.png)
