#!/bin/bash

a=$1

for i in {5000..45000..10000}; do

echo "$i"

cat "$a" | awk -v j="$i" '{print $1,$2-j,$3+j,$4}' | \
awk '{if ($2 < 0) print $1,0,$3,$4; else print $0}' > range_"$i"."$a"

cat range_"$i"."$a"


echo

./tools/plink --bfile ./inputs/1000g_phase3.eur \
--extract range range_"$i"."$a" --write-snplist --out "$a"

b=$(cat $a.snplist | wc -l)

echo "$b"

if [[ "$b" -gt 0 ]]; then

echo Search was completed at "$i" bp

rm range_*."$a"

break

fi

done


