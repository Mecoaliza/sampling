# Amostragem Aleatória Simples (AAS)
A amostragem aleatória simples em análises de Business Intelligence (BI) é útil para economizar tempo e recursos ao trabalhar com conjuntos de dados grandes, explorar inicialmente dados, testar hipóteses, melhorar o desempenho em sistemas interativos, e lidar com limitações de recursos. Ela permite uma análise eficiente, desde que a amostra seja verdadeiramente aleatória e representativa do conjunto de dados original. No entanto, a escolha entre amostragem e análise completa depende dos objetivos específicos do projeto de BI e do contexto da análise.

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
### 


