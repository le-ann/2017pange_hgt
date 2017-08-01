#!/bin/bash

# given a fasta file that has been filtered with dr. Goldings 'get_featuremodified.pl" code (it strips transposase elements)
# this code creates a series of files, where each file names is an organism accession number and the contents of each file is a list of protein ID extracted from the fasta file

for file in $1/*.fasta;
do
    acc=$(head -1 "$file" | cut -d' ' -f2)
    while read line
    do
        if [ "$(echo $line | grep '^>')" != "" ]
        then
            echo $line| rev | cut -d' ' -f1 | rev >> $acc'.prots'
        fi
    done <$file
done

#    greped=$(grep '^>' $file)
#    while read line
#    do
#        echo $line | rev | cut -d' ' -f1 | rev >> $acc'.prots'
#    done <"$greped"
#done
