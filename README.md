Together this pakage provides an analysis pipeline to examine whether a locus (mutation,genomic region, gene) has an impact on a phenotype. If a significant association is detected. Molecular insight will be provided for the path whereby the locus contributes to the phenotype.

To do a serach, enter the locus coordinate and trait file name to the wrapper script.

Example1 with genomic position: 
bash manager_p1.sh chr5:95665720 BMI_PMID_30239722.gz

Example2 with genomic range:
bash manager_p1.sh chr15:48888460-48905309 Standing_height_UKBB.gz

- This analysis pipeline assumes access to PLINK, GCTA and SMR programs is possible through your $PATH



