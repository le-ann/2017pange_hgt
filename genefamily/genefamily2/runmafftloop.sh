for a in `seq 1 50`; 
do
#echo "Gfagenome_ind_$a""seqs.fna"
mafft --auto --quiet "Gfagenome_ind_$a""seqs.fna" > "Gfagenome_ind_$a""_aligned.fna" &
done
