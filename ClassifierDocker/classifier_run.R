

## set command line arguments ----
args <- commandArgs(trailingOnly = TRUE)
data=args[1]
type=args[2]
folder=args[3]

#stop the script if no command line argument
if(length(args)==0){
  print("Please provide a dataset")
  stop("Requires command line arguments for data, gene representation and output folder.")
}

library(multiclassPairs)
library(readr)
library(dplyr)
library(tibble)
library(biomaRt)

Process_Cohorts=function(data, type){
   if (type=="ensembl"){
    ensembl.genes <-gsub("\\..*","",colnames(data)) #rm ensembl gene version (after .)
    mart <- useDataset("hsapiens_gene_ensembl", useMart("ensembl"))
    genes <- getBM(
      filters="ensembl_gene_id",
      attributes=c("ensembl_gene_id", "entrezgene_id"),
      values=ensembl.genes,
      mart=mart)
     entrezids=genes[match(ensembl.genes, unlist(genes$ensembl_gene_id)),"entrezgene_id"]
    }

  else if (type=="hugo"){ 
    hugo.genes=colnames(data)
    mart <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
    genes <- getBM(
      filters="hgnc_symbol",
      attributes=c("hgnc_symbol", "entrezgene_id"),
      values=hugo.genes,
      mart=mart)
    entrezids=genes[match(hugo.genes, genes$hgnc_symbol), "entrezgene_id"]
  }
  else if (type=="entrez"){
     entrezids=colnames(data)
  }
  na_ent=which(is.na(entrezids))
  dup=which(duplicated(entrezids))
  rm=unique(c(na_ent,dup))
  if(length(rm)>0){
    data=data[,-rm]
    colnames(data)=entrezids[-rm]
  }
  colnames(data)=paste("T", colnames(data), sep="")
  return(data)
}
data=as.data.frame(read_tsv(data))
rownames(data)=NULL;
rownames(data)=data[,1]; data=data[,-1]


processed_data=Process_Cohorts(data, type)
best_model=readRDS("best_model.RDS")

#rownames(rem_test)=sapply(rownames(rem_test), make.names)
results <- predict_RF(classifier = best_model, 
                      Data =as.data.frame(t(processed_data)),
                      impute = TRUE)

test_pred <- results$predictions
if (is.factor(test_pred)) {
  x <- as.character(test_pred)
}
# if the classifier trained using probability   = TRUE
if (is.matrix(test_pred)) {
  x <- colnames(test_pred)[max.col(test_pred)]
}
dir.create(folder)
write_tsv(cbind.data.frame(SampleID=rownames(processed_data),Assignment=x), file=paste(folder, "assignment.tsv", sep="/"))
write_tsv(rownames_to_column(as.data.frame(test_pred), var="SampleID"), file=paste(folder,"assignment_confidence.tsv", sep="/"))

