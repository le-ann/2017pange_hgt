for x in *.gbff; 
	do 
		echo -e `grep -oP '(?<=ACCESSION)\s{3}[A-Z]{2}\d{6}' $x` '\t' $x  >> namelist.txt
	done
