#!/bin/bash

#We have 24 barcodes, sequenced using MinION
for i in {01..24}
do
#Concatenate all long-read fastq.gz files into one and uncompressing it
cat barcode$i/FAW*.fastq.gz > barcode$i/reads.fastq.gz;
gunzip -c barcode$i/reads.fastq.gz > barcode$i/reads.fastq;

#Running NanoFilt to filter and trim the long reads, and compressing the resultant file
NanoFilt barcode$i/reads.fastq -q 10 -l 500 | gzip > barcode$i/trimmed.fastq.gz;

#Running unicycler for hybrid assembly of short- and long-read files; we have 2 short-read files for each sample
unicycler -1 barcode$i/JUNP*R1*.fastq.gz -2 barcode$i/JUNP*R2*.fastq.gz -l barcode$i/trimmed.fastq.gz -o barcode$i/results --spades_path ~/SPAdes-3.15.5/bin/spades.py 

done





