#!/bin/bash

c=$1

d=$2

e=$3

a=$4

echo "$c"_"$d"_"$e".sm "$c"_"$d"_"$e".sm > b1_"$c"_"$d"_"$e".gs


echo "$e" ./inputs/"$e" > b2_"$c"_"$d"_"$e".gs


smr_Linux --beqtl-summary ./besds/"$c" \
--query 1 --probe "$d" --out "$c"_"$d"_"$e"


echo "SNP A1 A2 freq b se p N" > "$c"_"$d"_"$e".sm

awk '{print $1,$4,$5,"NA",$12,$13,$14,20000}' "$c"_"$d"_"$e".txt | sed '1d' >> "$c"_"$d"_"$e".sm


gcta64 --bfile ./inputs/1000g_phase3.eur \
--gsmr-file b1_"$c"_"$d"_"$e".gs b2_"$c"_"$d"_"$e".gs \
--gsmr-direction 2 --out aa1_"$c"_"$d"_"$e" --gwas-thresh 5e-8 --gsmr-snp-min 3





STUDY="$a"__"$c"__"$d"__"$e"


cat aa1_"$c"_"$d"_"$e".gsmr | sed "s/^/$STUDY\ /ig" >> all.aa

rm b1_"$c"_"$d"_"$e".gs b2_"$c"_"$d"_"$e".gs

rm aa1_"$c"_"$d"_"$e".*

rm "$c"_"$d"_"$e".*


