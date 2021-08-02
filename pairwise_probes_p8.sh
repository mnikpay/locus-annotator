#!/bin/bash

k=$1

i=$2

x=$3

y=$4

a=$5

j="$i"__"$k"

z="$y"__"$x"

STUDY="$j"__"$z"

echo "$j" "$STUDY"_v1.sm > b1_"$STUDY"_v1.gs

echo "$z" "$STUDY"_v2.sm > b1_"$STUDY"_v2.gs

./tools/smr_Linux --beqtl-summary ./inputs/"$k" --query 1 --probe "$i" --out "$STUDY"_v1

./tools/smr_Linux --beqtl-summary ./inputs/"$x" --query 1 --probe "$y" --out "$STUDY"_v2

############
echo "SNP A1 A2 freq b se p N" > "$STUDY"_v1.sm

awk '{print $1,$4,$5,"NA",$12,$13,$14,20000}' "$STUDY"_v1.txt | sed '1d' >> "$STUDY"_v1.sm

echo "SNP A1 A2 freq b se p N" > "$STUDY"_v2.sm

awk '{print $1,$4,$5,"NA",$12,$13,$14,20000}' "$STUDY"_v2.txt | sed '1d' >> "$STUDY"_v2.sm
####################

./tools/gcta64 --bfile ./inputs/1000g_phase3.eur \
--gsmr-file b1_"$STUDY"_v1.gs b1_"$STUDY"_v2.gs \
--gsmr-direction 2 --out out_"$STUDY"_besd --gwas-thresh 5e-8 \
--gsmr-snp-min 3 --heidi-thresh 0

awk '$5<0.05' out_"$STUDY"_besd.gsmr | sed 's/^/Pleiotropy /ig' >> "$a".interaction

rm out_"$STUDY"_besd.*

./tools/gcta64 --bfile ./inputs/1000g_phase3.eur \
--gsmr-file b1_"$STUDY"_v1.gs b1_"$STUDY"_v2.gs \
--gsmr-direction 2 --out out_"$STUDY"_besd --gwas-thresh 5e-8 \
--gsmr-snp-min 3

awk '$5<0.05' out_"$STUDY"_besd.gsmr | sed 's/^/Causality /ig' >> "$a".interaction

rm out_"$STUDY"_besd.*

rm b1_"$STUDY"_v1.gs b1_"$STUDY"_v2.gs

rm "$STUDY"_v1.* "$STUDY"_v2.*



