#!/bin/bash

chromosome=$1
boundary1=$2
boundary2=$3
a=$4


cat ./inputs/1000g_phase3_block_maf0.01.blocks.det | \
	awk -v val1="$chromosome" '{if ($1 == val1) print $0}' | \
	awk -v val2="$boundary1" '{if ($2 >= val2) print $0}' | \
	awk -v val3="$boundary2" '{if ($3 <= val3) print $6}' | \
	tr "\n" "|" | tr "|" "\n" | sort -u > "$a".snplist



b=$(cat $a.snplist | wc -l)

if [[ "$b" -eq 0 ]]

  then

echo "Retriving SNP list by search window"

bash extract_snps_by_window_p4.sh "$a"


else

echo "Haplotype mapping is complete"

fi

