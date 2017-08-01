for a in `seq 1 50`; 
do
#echo "Gfagenome_ind_$a""seqs.fna"
perl removecarriagereturns.pl "Gfagenome_ind_$a""_aligned.fna" &
done
