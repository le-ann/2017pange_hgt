rm(list=ls())

suffixes <- 0:0
j <- 1
while(j < (suffixes[length(suffixes)]+2)){
  curr_range <- suffixes[j:(j+3)]
  if(any(is.na(curr_range))) curr_range <-
as.numeric(na.omit(curr_range))
  for(i in curr_range){
    if(nchar(i) == 1){
      prefix <- "00"
    } else if(nchar(i) == 2){
      prefix <- "0"
    } else{
      prefix <- ""
    }
    system(paste("./forNRgetseqsfromblastdb.sh",paste("try",prefix,i,sep=""),sep=" "), wait = TRUE)
    if(i != curr_range[length(curr_range)]) system(paste("blastp -db /1/scratch/blastdb/nr -query", paste("try",prefix,i,"seqs.fna",sep=""), "-out", paste("try",prefix,i,"blast.out",sep=""), "-evalue 0.05 -parse_deflines -num_threads 10 -outfmt '7 qseqid qlen qstart qend length sseqid slen qcovs score bitscore evalue stitle sallseqid salltitles' -soft_masking true -use_sw_tback &"), wait = TRUE)
    if(i == curr_range[length(curr_range)]) system(paste("blastp -db /1/scratch/blastdb/nr -query", paste("try",prefix,i,"seqs.fna",sep=""), "-out", paste("try",prefix,i,"blast.out",sep=""), "-evalue 0.05 -parse_deflines -num_threads 10 -outfmt '7 qseqid qlen qstart qend length sseqid slen qcovs score bitscore evalue stitle sallseqid salltitles' -soft_masking true -use_sw_tback;"), wait = TRUE)
  }
  j <- j + 4
}
