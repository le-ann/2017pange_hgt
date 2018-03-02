#!/usr/local/bin/python3

# Simple code for extracting titles of faa files. For troubleshooting purposes.

import re
import sys

compil_match = re.compile('^>')

with open(sys.argv[1],'r') as file:
    for line in file:
        if re.match(compil_match,line) != None:
            print(line, end="")


