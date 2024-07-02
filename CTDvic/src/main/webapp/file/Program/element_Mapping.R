
setwd(hgPath)
files<-list.files()
element<-gsub(hg_bed,"",files)
cfDNA_mutation<-read.table(readTablePath,
                           header = T,sep = "\t",stringsAsFactors = F,quote = "")
mutation_ls<-split(cfDNA_mutation,cfDNA_mutation$Hugo_Symbol)
i=1
for (i in 1:length(files)) {
  element_file<-read.table(paste(hgPath,files[i],sep=""),
                           header=T,sep = "\t", quote = "\"'",stringsAsFactors=FALSE)
  gene_start<-aggregate(element_file$START,by=list(element_file$GENE),min)
  gene_end<-aggregate(element_file$END,by=list(element_file$GENE),max)
  element_file<-cbind(gene_start,gene_end$x)
  colnames(element_file)<-c("gene","start","end")
  
  
  # mutation_file<-as.data.frame(mutation_ls[2])
  element_file_fun<-function(mutation_file){
    #colnames(mutation_file)<-colnames(cfDNA_mutation)
    element_file_index<-which(element_file$gene%in%mutation_file$Hugo_Symbol[1])
    if(length(element_file_index)>0){
      element_file_index1<-which(mutation_file$Start_Position>=element_file$start[element_file_index] &
                                   mutation_file$End_Position<=element_file$end[element_file_index] )
      if(length(element_file_index1)>0){
        element_file_mut<-mutation_file[element_file_index1,]
        ElementLength<-element_file$end[element_file_index]-element_file$start[element_file_index]+1
        ElementStart<-element_file$start[element_file_index]
        ElementEnd<-element_file$end[element_file_index]
        element_file_mut<-data.frame(ElementStart,ElementEnd,ElementLength,element_file_mut)
        return(element_file_mut)  
      }
      
    }
  }
  element_file_result<-lapply(mutation_ls,element_file_fun)
  m<-element_file_result[vapply(element_file_result, Negate(is.null), NA)]
  element_file_ls_row<-lapply(m,nrow)
  index1<-which(element_file_ls_row>=4)
  element_file<-m[index1]
  element_file_result<-do.call(rbind.data.frame,element_file)
  is_empty <- function(df) {
    nrow(df) == 0 || ncol(df) == 0
  }
  if(!is_empty(element_file_result)){
  write.table(element_file_result,paste(writeTablePath,element[i],"_length.txt",sep = ""),sep="\t",quote=FALSE,row.names = F)
  }
  print(i)
}

