library(readr)
library(dplyr)
library(ggplot2)
srag2021 <- read.table("https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/SRAG/2021/INFLUD21-20-06-2022.csv", header=TRUE, sep=";")
srag2022 <- read.table("https://s3.sa-east-1.amazonaws.com/ckan.saude.gov.br/SRAG/2022/INFLUD22-20-06-2022.csv", header=TRUE, sep=";")
options(scipen = 999)
pessoasSp <- srag2021[srag2021$SG_UF == 'SP',]
pessoasSp2022 <- srag2022[srag2022$SG_UF == 'SP',]

spVacinadas <- pessoasSp[pessoasSp$VACINA_COV == 1,]
spNaoVacinadas <- pessoasSp[pessoasSp$VACINA_COV == 2,]

colResultados = c("Curados","Óbitos", "Ób. Out. Causas", "Ignorado")

#Tabela de numero de curados, obitos, etc de 2021, a maioria foi curada
barplot(proportions(table(pessoasSp$EVOLUCAO))*100, ylab = "% de pessoas", col="#69b3a2", 
        names.arg = colResultados, main = "Classificação final do caso")

#Tabela de numero de curados, obitos, etc de 2022, a maioria foi curada
barplot(proportions(table(pessoasSp2022$EVOLUCAO))*100, ylab = "% de pessoas", col="#69b3a2", 
        names.arg = colResultados, main = "Classificação final do caso")

#Tabela dos que tomaram vacina ou nao, muitas pessoas que responderam
# a ficha, não tinham tomado a vacina do covid em 2021
barplot(proportions(table(pessoasSp$VACINA_COV))*100,ylab = "% de pessoas",col="#69b3a2", 
        names.arg = c("Sim","Não", "Ignorado"), main = "Tomou vacina contra covid? 2021")

#Tabela dos que tomaram vacina ou nao em 2022, aqui a maioria das pessoas já
#tinham tomado vacina contra o covid
barplot(proportions(table(pessoasSp2022$VACINA_COV))*100,ylab = "% de pessoas",col="#69b3a2", 
        names.arg = c("Sim","Não", "Ignorado"), main = "Tomou vacina contra covid? 2022")

# Tabela de classificação final do caso, podemos ver que a maioria das pessoas tiveram
# srag por conta do covid
colClass <- c("Influenza","Outro vírus", "Outro agente etiológico","N Especificado", "Covid-19")
barplot(proportions(table(pessoasSp$CLASSI_FIN))*100,ylab = "% de pessoas", 
        col="#69b3a2", names.arg = colClass,
        main="Classificação final - 2021")

barplot(proportions(table(pessoasSp2022$CLASSI_FIN))*100,ylab = "% de pessoas", 
        col="#69b3a2", names.arg = colClass,
        main="Classificação final - 2022")

curados <- pessoasSp[pessoasSp$EVOLUCAO == 1,]

cLegend <- c("Tomou vacina", "Não tomou vacina", "Ignorado")
cColors <- c("green", "red", "gray")
tabVacinaEvolucao2021 <- table(pessoasSp$VACINA_COV, pessoasSp$EVOLUCAO)
barplot(tabVacinaEvolucao2021, 
        beside = T, 
        legend=cLegend, 
        col= cColors, 
        names.arg = colResultados)
chisq.test(tabVacinaEvolucao2021) #Rejeitamos a hipotese nula
# ou seja, há relação entre tomar vacina e o resultado final

tabVacinaEvolucao2022 <- table(pessoasSp2022$VACINA_COV, pessoasSp2022$EVOLUCAO)
barplot(tabVacinaEvolucao2022, 
        beside = T, 
        legend=cLegend, 
        col= cColors, 
        names.arg = colResultados)
chisq.test(tabVacinaEvolucao2022) #Rejeitamos a hipotese nula
# ou seja, há relação entre tomar vacina e o resultado final - 2022

# Homens foram mais afetados pelos sintomas em 2021
barplot(proportions(table(pessoasSp$CS_SEXO))*100,ylab = "% de pessoas",col="#69b3a2", 
        names.arg = c("Feminino","Ignorado", "Masculino"), main = "Sexo das pessoas")
# Os homens também foram mais afetados durante 2022, porém a porcentagem de mulheres
# Quase se iguala ao dos homens
barplot(proportions(table(pessoasSp2022$CS_SEXO))*100,ylab = "% de pessoas",col="#69b3a2", 
        names.arg = c("Feminino","Ignorado", "Masculino"), main = "Sexo das pessoas")