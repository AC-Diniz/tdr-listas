dados <- read.csv("airquality.csv")
dados$Month <- factor(dados$Month)

pdf("figura.pdf", width = 7, height = 5)
boxplot(
Ozone ~ Month,
data = dados,
main = "Distribuição do Ozônio por mês",
xlab = "Mês",
ylab = "Ozônio (ppb)",
col = "lightblue",
border = "darkblue"
)
dev.off()
