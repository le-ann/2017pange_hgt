#!/usr/local/bin/python3.5

#--------------------------------------------------------------------------------------------------------------
# This code removes any duplicate sequences in the .faa files generated from 'getmodifiedgetfeatures' code
# argv[1] = faa file
# argv[2] = outfile name
# Test file: GCA_001540845.1_SO4698_09_genomic.faa
#--------------------------------------------------------------------------------------------------------------

import re
import sys

protids=[]

compil_match = re.compile('^>')

with open(sys.argv[1], 'r') as faafile:
    for line in faafile.readlines():
        if re.match(compil_match, line) != None:
            protids.append(line)

protids = list(set(protids))

with open(sys.argv[1], 'r') as file, open(sys.argv[2],'w') as outfile:
    for seqline in file:
        if seqline.startswith('>'):
            if seqline in protids:
                inRecordingMode = True
                outfile.write(seqline)
                protids.remove(seqline)
            elif seqline not in protids: 
                inRecordingMode = False
        elif inRecordingMode:
            outfile.write(seqline)


#with open('GCA_001540845.1_SO4698_09_genomic.faa', 'r') as faafile:
#    for line in faafile.readlines():
#        if re.match(compil_match, line) != None:
#            protids.append(line)
#
#protids = list(set(protids))
#
#inRecordingMode = False
#with open('GCA_001540845.1_SO4698_09_genomic.faa', 'r') as file, open('test.faa','w') as outfile:
#    for seqline in file:
#        if seqline.startswith('>'):
#            if seqline in protids:
#                inRecordingMode = True
#                outfile.write(seqline)
#                protids.remove(seqline)
#            elif seqline not in protids: 
#                inRecordingMode = False
#        elif inRecordingMode:
#            outfile.write(seqline)
