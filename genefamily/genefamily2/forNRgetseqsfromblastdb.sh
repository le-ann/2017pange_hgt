#!/bin/bash

blastdbcmd -db ~/genefamily/genomes/myco_analysis/parsed10genomes -entry_batch "$1" > "$1seqs.fna"
