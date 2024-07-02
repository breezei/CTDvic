
#####针对每一个突变文件，匹配5种元件
####由于测试文件的突变是hg19
##所以基因组原件也需要用hg19
setwd(paste("D:\\ctdna mutation program\\driverpover_element\\element_",hg,"\\",sep=""))
files<-list.files()
element<-gsub(paste("_",hg,".bed",sep = ""),"",files)
####读取用户输入的突变数据
###格式一定要严格要求统一
cfDNA_mutation<-read.table("D:\\ctdna mutation program\\data\\result\\normalize\\cfDNA_mutation_result.txt",
                           header = T,sep = "\t",stringsAsFactors = F,quote = "")
#按基因名将文件分成多个list
mutation_ls<-split(cfDNA_mutation,cfDNA_mutation$Hugo_Symbol)
#####与每个元件进行匹配
i=1
for (i in 1:length(files)) {
  element_file<-read.table(paste("D:\\ctdna mutation program\\driverpover_element\\element_",hg,"\\",files[i],sep=""),
                           header=T,sep = "\t", quote = "\"'",stringsAsFactors=FALSE)
  #元件文件中基因有重复，
  #我们取最小值和最大值作为该基因对应元件的最小值和最大值
  gene_start<-aggregate(element_file$START,by=list(element_file$GENE),min)
  gene_end<-aggregate(element_file$END,by=list(element_file$GENE),max)
  #由于后面匹配用不到chr,所以只合并基因名和起始终止位点
  element_file<-cbind(gene_start,gene_end$x)
  colnames(element_file)<-c("gene","start","end")
  
  
  # mutation_file<-as.data.frame(mutation_ls[2])
  element_file_fun<-function(mutation_file){
    ###这句测试用的，可以删除
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
  ####删除掉列表中的空值项
  m<-element_file_result[vapply(element_file_result, Negate(is.null), NA)]
  ##筛选突变数>3的基因
  element_file_ls_row<-lapply(m,nrow)
  index1<-which(element_file_ls_row>=4)
  element_file<-m[index1]
  element_file_result<-do.call(rbind.data.frame,element_file)
  ##判断结果是否为空，为空则不输出
  is_empty <- function(df) {
    nrow(df) == 0 || ncol(df) == 0
  }
  if(!is_empty(element_file_result)){
  write.table(element_file_result,paste("D:\\ctdna mutation program\\data\\result\\element_mapping\\",element[i],"_length.txt",sep = ""),sep="\t",quote=FALSE,row.names = F)
  }
  print(i)
}

