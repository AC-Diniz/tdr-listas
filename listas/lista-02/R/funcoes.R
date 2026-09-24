## Lê o CSV e acrescenta o nome do mês, que as tabelas e os gráficos usam.
ler_dados <- function(arquivo) {
  dados <- read.csv(arquivo)
  dados$Mes <- factor(dados$Month, levels = 5:9,
                      labels = c("Maio", "Junho", "Julho", "Agosto",
                                 "Setembro"))
  dados
}

## Média mensal de cada variável, com os dias em que ela foi medida.
medias_mensais <- function(dados) {
  medias <- aggregate(cbind(Ozone, Solar.R) ~ Mes, data = dados, FUN = mean,
                      na.action = na.pass, na.rm = TRUE)
  medias[, -1] <- round(medias[, -1], 1)
  medias
}

## Regressão do ozônio sobre a temperatura, nos dias com as duas medidas.
ajustar_modelo <- function(dados) {
  lm(Ozone ~ Solar.R, data = dados)
}

## Desenha a dispersão com a reta ajustada e devolve o caminho do arquivo,
## que é o que o alvo com format = "file" registra.
salvar_figura <- function(dados, modelo, arquivo = "saidas/dispersao.png") {
  dir.create(dirname(arquivo), showWarnings = FALSE, recursive = TRUE)
  png(arquivo, width = 1400, height = 900, res = 180)
  on.exit(dev.off())
  plot(Ozone ~ Temp, data = dados, pch = 20, col = "steelblue",
       xlab = "Radiação Solar (lang)", ylab = "Ozônio (ppb)")
  abline(modelo, col = "purple", lwd = 2)
  arquivo
}


## Salva o quadro de médias mensais em ums CSV e devolve o caminho do arquivo
salva_tabela <- function(medias, arquivo ="saidas/medias.csv"){
  dir.create(dirname(arquivo), showWarnings = FALSE, recursive = TRUE)
  write.csv(medias, arquivo, row.names = FALSE)
  arquivo
}
