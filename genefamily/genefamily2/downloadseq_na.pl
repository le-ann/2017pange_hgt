use LWP::Simple;
#$acc_list = 'NC_002677';
#$acc_list = 'NC_000962';
#$acc_list = 'NC_002945';
#$acc_list = 'NC_022663';
#$acc_list = 'NC_015758';
#$acc_list = 'NC_015848';
#$acc_list = 'NC_008611';
#$acc_list = 'NC_021200';
#$acc_list = 'CP000656';
$acc_list = 'CP000854';
@acc_array = split(/,/, $acc_list);

#append [accn] field to each accession
for ($i=0; $i < @acc_array; $i++) {
   $acc_array[$i] .= "[accn]";
}

#join the accessions with OR
$query = join('+OR+',@acc_array);

#assemble the esearch URL
$base = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
$url = $base . "esearch.fcgi?db=nucleotide&term=$query&usehistory=y";


#post the esearch URL
$output = get($url);


#parse WebEnv, QueryKey and Count (# records retrieved)
$web = $1 if ($output =~ /<WebEnv>(\S+)<\/WebEnv>/);
$key = $1 if ($output =~ /<QueryKey>(\d+)<\/QueryKey>/);
$count = $1 if ($output =~ /<Count>(\d+)<\/Count>/);


#open output file for writing
#open(OUT, ">na_mycobacterium.africanum.gm041182.fna") || die "Can't open file!\n";
#open(OUT, ">na_mycobacterium.kansasii.atcc.12478.fna") || die "Can't open file!\n";
#open(OUT, ">na_mycobacterium.bovis.af212297.fna") || die "Can't open file!\n";
#open(OUT, ">na_mycobacterium.tuberculosis.h37rv.fna") || die "Can't open file!\n";
#open(OUT, ">na_mycobacterium.leprae.tn.fna") || die "Can't open file!\n";
open(OUT, ">na_mycobacterium.marinum.m.fna") || die "Can't open file!\n";
#open(OUT, ">na_mycobacterium.canettii.cipt.140010059.fna") || die "Can't open file!\n";
#open(OUT, ">na_mycobacterium.ulcerans.agy99.fna") || die "Can't open file!\n";
#open(OUT, ">na_mycobacterium.avium.subsp.paratuberculosis.map4.fna") || die "Can't open file!\n";
#open(OUT, ">na_mycobacterium.gilvum.pyrgck.fna") || die "Can't open file!\n";

#retrieve data in batches of 500
$retmax = 4;
for ($retstart = 0; $retstart < $count; $retstart += $retmax) {
        $efetch_url = $base ."efetch.fcgi?db=nucleotide&WebEnv=$web";
        $efetch_url .= "&query_key=$key&retstart=$retstart";
        $efetch_url .= "&retmax=$retmax&rettype=fasta_cds_na&retmode=text";
        $efetch_out = get($efetch_url);
        print OUT "$efetch_out";
} #rettype=fasta_cds_aa returns protein coding sequences
close OUT;
