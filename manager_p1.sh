#!/bin/bash

# To start the analysis, you need to specify a locus ( a genomic position/range) and 
#the name of your trait file. 

#This analysis pipeline assumes trait files are in ./inputs directory and besd files are in ./besds/ directory

#Example1 with genomic position: bash manager_m1.sh chr5:95665720 BMI_PMID_30239722.gz

#Example2 with genomic range: bash manager_m1.sh chr15:48888460-48905309 Standing_height_UKBB.gz


locus=$1


trait=$2


bash locus_assigner_p2.sh $locus


a=$(echo $locus | sed 's/chr//' | sed 's/\:/__/' | sed 's/\-/__/')


while read line; do echo $line;bash haplotype_finder_p3.sh $line; done < $a

#New besd files can be added to the end of besd_files.list

while read line; do echo $line;bash probe_finder_p5.sh $line $a; done < ./inputs/besd.list


while read line; do echo $line;bash MR_test_p6.sh $line $trait $a; done < $a.besd.probes


rm $a $a.*
