# Locus annotator

Understanding the function of a locus using the knowledge available at single-nucleotide polymorphisms (SNPs)

## Description

There are situations when a biologist wants to invetigates the function of a locus. e.g.

* Does the rare varaiant X cause the disease Y?
* How is the gene Z being regulated? What would be the consequences of perturbution in its fuction?
* What is the function of this unaanotated genomic region?

This UNIX package was designed with the aim to address these issues.

For more information, please read the [manuscript](https://www.preprints.org/manuscript/202108.0084/v1).

## Getting Started

The entire package with input files/exectubales can be obtained from [here](https://filr.ottawaheart.ca/ssf/s/readFile/share/2454/2372143190551438567/publicLink/locus_annotator.zip)

then access it as:
```
unzip locus_annotator.zip

chmod -R 700 ./locus_annotator

cd ./locus_annotator

```
To conduct a search, the locus coordinate and the phenotype name must be passed to the wrapper script.

Example1 with genomic position:
```
bash wrapper.sh chr5:95734724 BMI_PMID30239722
```


Example2 with genomic range:
```
bash wrapper.sh chr19:45409039-45412650 LDL_PMID24097068
```


## Input files

Input files for functional features are automatically generated during the analysis from the SMR input files; however, you need to provided the input file (GWAS summary data) for the phenotype of interest and pass the name of the file (e.g. BMI_PMID30239722) as an agrument to the wrapper script. Below, is the header of a sample file:

```

zcat BMI_PMID30239722.gz | head

SNP A1 A2 freq b se p N
rs10 A C 0.05 -1.0E-04 0.004 0.99 639363
rs1000000 A G 0.25 -6.0E-04 0.002 0.75 716090
rs10000000 A T 0.94 9.3E-03 0.004 0.02 484680
rs10000003 A G 0.29 -1.0E-03 0.002 0.65 484680
rs10000005 A G 0.54 -3.2E-03 0.002 0.09 484680
rs10000006 T C 0.95 3.8E-03 0.004 0.37 484680
rs10000007 A C 0.99 3.4E-03 0.010 0.73 484680
rs10000008 T C 0.02 1.5E-02 0.007 0.03 484680
rs10000009 A G 1.00 -6.8E-03 0.024 0.77 484680

```

**Description of the columns:**
```

SNP: rsid

A1: Reference allele on the forward strand

A2: Alternate allele on the forward strand

freq: Frequency of reference allele

b: Estimated effect size (beta regression coefficient) of reference allele

se: Estimated standard error of beta

p: p-value (significance of estimated beta)

N: Sample size

```

GWAS summary data files can be obtained from the previous studies and they can be kept in gz format. [OpenGWAS](https://gwas.mrcieu.ac.uk/) also provides a collection of such files which can be converted to the above format, using this [script](obtain_opengwas_file.sh):

Example
```
bash obtain_opengwas_file.sh ieu-b-40
```
where ieu-b-40 is the GWAS ID file in OpenGWAS databse.


## Functional data

This pipeline requires functional data (QTLs) in [SMR](https://cnsgenomics.com/software/smr/#DataManagement) format. A number of such files for various functional features can be obtained from [here](https://filr.ottawaheart.ca/ssf/s/readFile/share/1438/6705413317368203034/publicLink/QTL_data.zip) and [SMR website](https://cnsgenomics.com/software/smr/#DataResource).

## Acknowledgments
* [Compute Canada](https://www.computecanada.ca/)
* [University of Ottawa Heart Institute](https://www.ottawaheart.ca/)
* [README Template/DomPizzie](https://gist.github.com/DomPizzie/7a5ff55ffa9081f2de27c315f5018afc)
