#!/bin/bash

c=$1

a=$2

smr_Linux --beqtl-summary ./besds/$c \
--extract-snp $a.snplist --query 5e-8 --out "$c"_"$a"_plist


sed '1d' "$c"_"$a"_plist.txt | awk '{print $7}' | sort -u | \
sed "s/^/$c /ig" >> "$a".besd.probes



rm "$c"_"$a"_plist.*




