#!/bin/bash

#To start a search, please specify the coordinate of a locus (a single position or a range)
# and the name of the trait

#The scripts assume the trait/QTL files are in the inputs directory 

#Example1 with a genomic position: bash wrapper.sh chr5:95665720 BMI_PMID30239722

#Example2 with a genomic range: bash wrapper.sh chr19:45409039-45412650 LDL_PMID24097068

locus=$1


trait=$2


bash locus_assigner_p2.sh $locus


a=$(echo $locus | sed 's/chr//' | sed 's/\:/__/' | sed 's/\-/__/')

#Haplotype mapping
while read line; do echo $line;bash haplotype_finder_p3.sh $line; done < $a

#QTL mapping
#New QTL files can be added to the end of the QTLs_file.list
while read line; do echo $line;bash probe_finder_p5.sh $line $a; done < QTLs_file.list

#MR test (Probe-Trait)
while read line; do echo $line;bash MR_test_p6.sh $line $trait $a; done < $a.besd.probes


#Test of interaction between probes
b=$(cat $a.besd.probes | wc -l)

if [[ $b -gt 1 ]]

then

echo "Examining interaction between probes"

bash interaction_p7.sh $a

fi


#Prepare result files
bash report_results_p9.sh $locus $a

rm $a $a.*


