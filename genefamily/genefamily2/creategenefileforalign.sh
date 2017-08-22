for a in `seq 1 50`; 
do
blastdbcmd -db ~/genefamily/genomes/myco_analysis/na_parsed10genomes -entry_batch "Gfagenome_ind_$a" > "Gfagenome_ind_$a""seqs.fna"
done

