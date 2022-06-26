library(readr)
INFLUD21_20_06_2022 <- read_delim("Github/projeto-estatistica/repositorio/INFLUD21-20-06-2022.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
INFLUD22_20_06_2022 <- read_delim("Github/projeto-estatistica/repositorio/INFLUD22-20-06-2022.csv", delim = ";", escape_double = FALSE, trim_ws = TRUE)
legenda_hospital <- c('1-Sim',
                      '2-Não',
                      '9-Ignorado')
barplot(table(INFLUD21_20_06_2022$HOSPITAL), col=c('blue', 'red','seagreen'), main= 'Houve internação?')
legend('topright',legend=c(legenda_hospital))
pie(INFLUD21_20_06_2022$VACINA_COV)
legenda_evolucao <- c('1-Cura',
                  '2-Óbito',
                  '3-Óbito por outras causas',
                  '9-Ignorado')
pie(table(INFLUD21_20_06_2022$EVOLUCAO), main="Evolução dos casos")
legend('topleft',legend=c(legenda_evolucao))
#Houve um alto número de internações por SRAG, porém aproximadamente 70% dos casos evoluiram para cura

legenda_diagnostico <- c('1-SRAG por influenza',
                         '2-SRAG por outro vírus respiratório',
                         '3-SRAG por outro agente etiológico, qual:',
                         '4-SRAG não especificado',
                         '5-SRAG por covid-19')
hist(INFLUD21_20_06_2022$CLASSI_FIN, main='Diagnóstico final do caso 2021', xlab = 'Diagnóstico', ylab = 'Frequencia')
legend('topleft',legend=c(legenda_diagnostico))

hist(INFLUD22_20_06_2022$CLASSI_FIN, main='Diagnóstico final do caso 2022', xlab = 'Diagnóstico', ylab = 'Frequencia')
legend('topleft',legend=c(legenda_diagnostico))
#Houve um aumento nos casos de SRAG, sendo possível analisar um aumento nos casos de SRAGs não específicados junto ao covid-19
