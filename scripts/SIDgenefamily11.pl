#!/usr/bin/perl
#Author: Dr. Golding, Dept. of Biology, McMaster University
#modified by me
#@ARGV shoud be [output file name, blastp file]
## note pearl args start at $ARGV[0], as program name is stored seperately in $0
$genefamilyNo=0;
$filledTo=0;
open(FILE2,">$ARGV[0]");
open(FILE,"<$ARGV[1]");
#for($m=0; $m<5; $m++) { $_ = <FILE>; } # first five lines are comments
# resolved by just piping grep -v ^# to this script instead
# but want to avoid an if statement inside the main while loop
while(<FILE>) {
    # File format from blastp is 
    #    0     1     2     3    4      5      6     7      8      9      10
    # qseqid qlen qstart qend length sseqid slen qcovhsp score bitscore evalue 
    #                        alignment
    @read = split(/\t+/,$_);
    if(not exists($genefamily{$read[0]})) { 
        $newNumber = &getNewNumber;
        $genefamily{$read[0]} = $newNumber;
        $numberInFamily[$newNumber]=1;
    } else {
        $newNumber = $genefamily{$read[0]};
    }
    $targetQueryProportion=$read[6]/$read[1];# if len(Query) > len(Target) want Target/Query to be similar
    $queryOnTarget=($read[3]-$read[2])/$read[6];# if len(Query) < len(Target) want Query to hit most of Target
    if($queryOnTarget > 0.85 && $targetQueryProportion > 0.85 && $read[5] ne $read[0]) { # a palatable hit (the values chose are based on pervious work, which were chosen arbitrarily) 
        if(not exists($genefamily{$read[5]})) { 
            # the target has no genefamily assigned, therefore assign it to the current one
            $genefamily{$read[5]} = $newNumber;
            $numberInFamily[$newNumber]++;
            # print "Set key $read[5] equal to value $genefamilyNo\n";
        } else { 
            # if the target has a genefamily assigned, 
            # the target genefamily equals that of the query - do nothing
            # the target genefamily exists but differs from that of the query -
            # merge the two genefamilies.
            if($genefamily{$read[0]}!=$genefamily{$read[5]}) { 
                &merge($genefamily{$read[0]},$genefamily{$read[5]}); 
            }
        }
    }
}
close(FILE);

#####################################################
#  Create a reverse hash  (Section %5.8 Cookbook)
%revGenefamily = ();   # create empty hash
foreach $key (keys %genefamily) {
    push ( @{$revGenefamily{$genefamily{$key}}}, $key);
}
foreach $value (sort {$a <=> $b} keys %revGenefamily) { # keys are now actually values
    print FILE2 "$value $numberInFamily[$value] @{$revGenefamily{$value}}\n";
}
close(FILE2);



















sub merge {
# Merge two families together.
    ($i, $j) = @_;
    # ensure $i < $j
    if($i > $j) { $less = $j; $j=$i; $i=$less; }
    foreach $key (keys %genefamily) {
        if($genefamily{$key} == $j) {
            $genefamily{$key} = $i;
        }
    }
    # the hash should no longer have any keys that point to value $j
    $numberInFamily[$i] += $numberInFamily[$j];
    $numberInFamily[$j] = -1;
    if($filledTo > $j-1) { $filledTo = $j-1; }
}

sub getNewNumber {
    for($l=$filledTo; $l<$genefamilyNo; $l++) {
        if($numberInFamily[$l] == -1) { 
            $filledTo=$l; 
            return($l); }
    }
    $filledTo=$genefamilyNo;
    $genefamilyNo++;
    return($genefamilyNo);
}








#$genefamilyNo=0;
#$filledTo=0;
#open(FILE2,">genefamily.list");
#for($k=1;$k<244;$k++) {
#    $filename = "allvsall." . $k;
#    open(FILE,"<$filename");
#    for($m=0; $m<4; $m++) { $_ = <FILE>; } # first four lines are comments
#    # but want to avoid an if statement inside the main while loop
#    while(<FILE>) {
#        # File format from Diamond is 
#        #    0     1     2     3    4      5      6     7      8      9      10
#        # qseqid qlen qstart qend length sseqid slen qcovhsp score bitscore evalue 
#        #                        alignment
#        @read = split(/\s+/,$_);
#        if(not exists($genefamily{$read[0]})) { 
#            $newNumber = &getNewNumber;
#            $genefamily{$read[0]} = $newNumber;
#            $numberInFamily[$newNumber]=1;
#        } else {
#            $newNumber = $genefamily{$read[0]};
#        }
#        $targetQueryProportion=$read[6]/$read[1];   # if len(Query) > len(Target) want Target/Query to be similar
#        $queryOnTarget=($read[3]-$read[2])/$read[6];# if len(Query) < len(Target) want Query to hit most of Target
#        if($queryOnTarget > 0.85 && $targetQueryProportion > 0.85 && $read[5] ne $read[0]) { # a palatable hit 
#            if(not exists($genefamily{$read[5]})) { 
#                # the target has no genefamily assigned, therefore assign it to the current one
#                $genefamily{$read[5]} = $newNumber;
#                $numberInFamily[$newNumber]++;
#                # print "Set key $read[5] equal to value $genefamilyNo\n";
#            } else { 
#                # if the target has a genefamily assigned, 
#                # the target genefamily equals that of the query - do nothing
#                # the target genefamily exists but differs from that of the query -
#                # merge the two genefamilies.
#                if($genefamily{$read[0]}!=$genefamily{$read[5]}) { 
#                    &merge($genefamily{$read[0]},$genefamily{$read[5]}); 
#                }
#            }
#        }
#    }
#    printf "File %3d   Gene Families $genefamilyNo    Filled to $filledTo\n", $k; 
#    close(FILE);
#}
####################################
