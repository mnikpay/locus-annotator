#!/bin/bash

c=$1

d=$2

e=$3

a=$4

echo "$c"_"$d"_"$e".sm "$c"_"$d"_"$e".sm > b1_"$c"_"$d"_"$e".gs


echo $e ./inputs/$e.gz > b2_"$c"_"$d"_"$e".gs


./tools/smr_Linux --beqtl-summary ./inputs/"$c" \
--query 1 --probe "$d" --out "$c"_"$d"_"$e"


echo "SNP A1 A2 freq b se p N" > "$c"_"$d"_"$e".sm

awk '{print $1,$4,$5,"NA",$12,$13,$14,20000}' "$c"_"$d"_"$e".txt | sed '1d' >> "$c"_"$d"_"$e".sm


./tools/gcta64 --bfile ./inputs/1000g_phase3.eur \
--gsmr-file b1_"$c"_"$d"_"$e".gs b2_"$c"_"$d"_"$e".gs \
--gsmr-direction 0 --out aa1_"$c"_"$d"_"$e" --gwas-thresh 5e-8 --gsmr-snp-min 3





STUDY="$d"__"$c"__"$e"


sed "s/^/$STUDY\ /ig" aa1_"$c"_"$d"_"$e".gsmr | awk '$6<0.05' | sed 's/^/Causality /ig' >> "$a".mr

rm b1_"$c"_"$d"_"$e".gs b2_"$c"_"$d"_"$e".gs

rm aa1_"$c"_"$d"_"$e".*

rm "$c"_"$d"_"$e".*


