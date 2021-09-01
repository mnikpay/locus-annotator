#!/bin/bash

#To download and generate GWAS data file for the locus annotator from the OpenGWAS database
 
#this package assumes bcftools is accessible through your path

i=$1


wget https://gwas.mrcieu.ac.uk/files/"$i"/"$i".vcf.gz

echo SNP A1 A2 freq b se p N > "$i"
bcftools \
query -e 'ID == "."' -f '%ID\t[%LP]\t%CHROM\t%POS\t%ALT\t%REF\t%AF\t[%ES\t%SE]\n' \
"$i".vcf.gz | \
awk 'BEGIN {print "variant_id\tp_value\tchromosome\tbase_pair_location\teffect_allele\tother_allele\teffect_allele_frequency\tbeta\tstandard_error"}; \
{OFS="\t"; if ($2==0) $2=1; else if ($2==999) $2=0; else $2=10^-$2; print}' | \
sed '1d' | awk '{print $1,$5,$6,$7,$8,$9,$2,"10000"}' | sort -uk1,1 >> "$i"

gzip "$i"

