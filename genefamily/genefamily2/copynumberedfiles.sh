for a in `seq 45 89`; 
do
if [ ${#a} -eq 1 ]; then
    b="00";
elif [ ${#a} -eq 2 ]; then
    b="0";
elif [ ${#a} -eq 3 ]; then
    b="";
fi
cp /1/scratch/udang/gfam2/"myconohits$b$a""blast.out" .
done
