#Um restaurante deseja conhecer melhor o perfil de seus clientes e 
#tem condições de entrevistar aproximadamente 20% dos mesmos. 
#Em média, 30 clientes passam pelo restaurante ao longo do dia 
#num processo de fila bastante ordenada. Como fazer a seleção dessas amostras?

set.seed(10)
# encontraremos nosso K(intervalo de retirada)
(k<- round((1/20)*100))

# sortear o ponto de partida r
(r<- sample(seq(1,k,1),1))

# indicar quais serão as amostras que deverão ser selecionadas
c(r,r+k,r+2*k, r+3*k, r+4*k, r+5*k)


# Uma pesquisa encomendada por uma empresa de show será realizada 
#por meio da amostragem sistemática. Pela estimativa de 
#ingressos vendidos, 7.900 pessoas (enumeradas de 1 a 7.900) 
#passarão pela fila do espetáculo. Uma amostra sistemática será 
#feita com 10% desse total. Qual é a numeração das 3 primeiras e 
#das 3 últimas pessoas entrevistadas (utilize uma semente igual a 5)?

set.seed(5)
(k<- round((1/10)*100))

(r<- sample(seq(1,k,1),1))

c(r,r+k,r+2*k, r+787*k, r+788*k, r+789*k)

