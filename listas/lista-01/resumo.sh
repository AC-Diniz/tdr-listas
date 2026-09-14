#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 2 ]; then
echo "Uso: $0 <arquivo.csv> <numero_coluna>" >&2
exit 1
fi

arquivo="$1"
coluna="$2"

nome_coluna=$(head -n 1 "$arquivo" | awk -F',' -v c="$coluna" '{print $c}' | tr -d '"\r') 
echo "Coluna: $nome_coluna"

obs=$(tail -n +2 "$arquivo" | wc -l | tr -d ' ')
echo "Observaçoes: $obs"

nas=$(tail -n +2 "$arquivo" | awk -F',' -v c="$coluna" '$c ~ /^"?NA"?$/ {count++} END {print count+0}')
echo "Valores NA: $nas"


echo "Media por mes:"
tail -n +2 "$arquivo" | awk -F',' -v c="$coluna" '
BEGIN { FS=","}
$c !~/^"?NA"?$/ && $c != "" {
mes = $5
soma[mes] += $c
qtd[mes]++
}
END {
for (m in soma) {
printf "Mes %s: media = %.2f (%d dias medidos)\n", m, soma[m]/qtd[m], qtd[m]
}
}' | sort -n -k2


