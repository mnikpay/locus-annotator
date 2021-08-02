#!/bin/bash

locus=$1

a=$2


if [[ -f "$a".mr ]]

  then
echo
echo
echo "Printing MR results"

echo "SearchID Test Exposure_Probe Exposure_Source Outcome Outcome_Source B SE P N_SNPs" > \
MR_trait_results.txt

cat "$a".mr | awk '{print $1,$2,$5,$6,$7,$8}' | sed 's/__/ /ig' | \
sed 's/QTLs_example_//ig' | sed 's/_PMID/\ PMID/ig' | sed "s/^/$locus\ /ig" >> MR_trait_results.txt
echo
cat MR_trait_results.txt
echo

else

echo "No significant finding from the MR test was found"

fi


if [[ -f "$a".interaction ]]

  then

echo
echo "Printing interaction results"

echo "SearchID Test Exposure_Probe Exposure_Source Outcome_Probe Outcome_Source B SE P N_SNPs" > \
MR_interaction_results.txt

cat "$a".interaction | awk '{print $1,$2,$3,$4,$5,$6,$7}' | \
sed 's/__/ /ig' | sed 's/QTLs_example_//ig' | sed 's/_PMID/\ PMID/ig' | \
sed "s/^/$locus\ /ig" >> MR_interaction_results.txt
echo
cat MR_interaction_results.txt
echo

else

echo "No significant finding from the interaction test was found"

fi


