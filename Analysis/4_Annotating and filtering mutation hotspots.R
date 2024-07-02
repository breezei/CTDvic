
####将结果文件增加chr start end 
setwd("D:\\ctdna mutation program\\data\\result\\element_result\\");
list<-list.files(pattern = ".txt");
element<-gsub("_length.txt","",list);
i=1
for (i in 1:length(list)) {
  element_result<-read.table(paste("D:\\ctdna mutation program\\data\\result\\element_result\\",list[i],sep = ""),
                             header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
  element_length<-read.table(paste("D:\\ctdna mutation program\\data\\result\\element_mapping\\",list[i],sep = ""),
                             header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
  element_length<-data.frame(element_length$Hugo_Symbol,element_length$Chromosome,element_length$ElementStart,element_length$ElementEnd,element_length$ElementLength,stringsAsFactors=FALSE)
  element_length<-unique(element_length)
  colnames(element_length)<-gsub("element_length\\.","",colnames(element_length))
  #由于识别时是按顺序对基因进行分析的，所以直接合并即可
  element_result<-data.frame(element_result,element_length$Chromosome,element_length$ElementStart,element_length$ElementEnd,element_length$ElementLength,stringsAsFactors=FALSE)
  colnames(element_result)<-gsub("element_length\\.","",colnames(element_result))
  element_result$FDR<-p.adjust(element_result$p,method = "BH")
  element_result<-element_result[element_result$FDR<0.05,]
  ###倒数第二列添加element种类
  row_num <- nrow(element_result)
  kind_rownum <- c(rep(element[i],row_num))
  kind_element <- as.data.frame(kind_rownum,row.names =NULL)
  colnames(kind_element) <- "Elementkind"
  element_result <- data.frame(element_result,kind_element)
  ###最后一列添加hg版本,自己跑程序时才需要，放到服务器上已经选定基因组版本(GRCh37/GRCh38)
  element_result <- data.frame(element_result,"Reference_Genome"=(rep(GRCH,row_num)))
  ##判断过滤完的文件是否为空
  if(nrow(element_result)>0){
    write.table(element_result,paste("D:\\ctdna mutation program\\data\\result\\element_filter\\",list[i],sep = ""),sep="\t",quote=FALSE,row.names = F)
  }
  
  print(i)
}
