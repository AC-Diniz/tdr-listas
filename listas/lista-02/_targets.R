library(targets)
library(tarchetypes)

tar_source("R")

tar_option_set(
packages = c("tidyverse", "here")
)

list(
tar_target(arquivo, "dados/airquality.csv", format = "file"),
tar_target(dados, ler_dados(arquivo)),
tar_target(medias, medias_mensais(dados)),
tar_target(modelo, ajustar_modelo(dados)),
tar_target(figura, salvar_figura(dados, modelo), format = "file"),
tar_quarto(relatorio, "relatorio.qmd")
)
