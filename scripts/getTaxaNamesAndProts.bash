#!/bin/bash
# given a fasta file that has been filtered with dr. Goldings 'get_featuremodified.pl" code (it strips transposase elements)
# this code creates a series of files, where each file names is an organism accession number and the contents of each file is a list of protein ID extracted from the fasta file
# the header of each fasta entry can be in the following formats:
#> CP003452 ;  this is a desscription of the protein DWQa476 AE012231.1
# or 
# >CP0003452:AE012231.1
# the code will figure it out
#$1 is the directory which contains the fasta files you want to work on


if [ "$(echo $1 | grep 'faa')" != "" ]
then 
    echo condition passes
    while read line
    do
        if [ "$(echo $line | grep '^>')" != "" ]
        then
            acc=$(echo $line | cut -d':' -f1 | tr -d '>')
            outt="$acc:$(echo $line | cut -d':' -f2)"
            echo $outt >> $acc'.prots' 
        fi
    done <$1
else
    for file in $1/*.faa;
    do
        if [ "$(head -1 $file | cut -d' ' -f1)" != "$(head -1 $file)" ]
        then
            acc=$(head -1 "$file" | cut -d' ' -f2)
            while read line
            do
                if [ "$(echo $line | grep '^>')" != "" ]
                then
                    outt="$acc:$(echo $line | rev | cut -d' ' -f1 | rev)"
                    echo $outt >> $acc'.prots'
                fi
            done <$file
        else
            acc=$(head -1 "$file" | cut -d':' -f1 | tr -d '>')
            while read line
            do
                if [ "$(echo $line | grep '^>')" != "" ]
                then
                    outt="$acc:$(echo $line | cut -d':' -f2)"
                    echo $outt >> $acc'.prots' 
                fi
            done <$file
        fi
    done
fi







