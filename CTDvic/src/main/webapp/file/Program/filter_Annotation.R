setwd(readTablePath)
list<-list.files(pattern = ".txt")
element<-gsub("_length.txt","",list)
i=1
for (i in 1:length(list)) {
  element_result<-read.table(paste(readTablePath,list[i],sep = ""),
                             header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
  
  element_length<-read.table(paste(readMappingPath,list[i],sep = ""),
                             header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
  element_length<-data.frame(element_length$Hugo_Symbol,element_length$Chromosome,element_length$ElementStart,element_length$ElementEnd,element_length$ElementLength,stringsAsFactors=FALSE)
  element_length<-unique(element_length)
  colnames(element_length)<-gsub("element_length\\.","",colnames(element_length))
  element_result<-data.frame(element_result,element_length$Chromosome,element_length$ElementStart,element_length$ElementEnd,element_length$ElementLength,stringsAsFactors=FALSE)
  colnames(element_result)<-gsub("element_length\\.","",colnames(element_result))
  element_result$FDR<-p.adjust(element_result$p,method = "BH")
  element_result<-element_result[element_result$FDR<0.05,]
  row_num <- nrow(element_result)
  kind_rownum <- c(rep(element[i],row_num))
  kind_element <- as.data.frame(kind_rownum,row.names =NULL)
  colnames(kind_element) <- "Elementkind"
  element_result <- data.frame(element_result,kind_element)
  if(nrow(element_result)>0){
    write.table(element_result,paste(writeTablePath,list[i],sep = ""),sep="\t",quote=FALSE,row.names = F)
  }
  
  print(i)
}
rm(list = ls())