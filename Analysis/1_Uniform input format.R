
####读取用户输入的突变数据
###格式一定要严格要求统一
cfDNA_mutation<-read.table(paste("D:\\ctdna mutation program\\data\\mutation_txt\\",filename,'.txt',sep=""),
                           header = T,sep = "\t",stringsAsFactors = F,quote = "")
####第一列：基因名  
library(tidyr)
cfDNA_mutation_result<-data.frame(cfDNA_mutation$Hugo_Symbol,cfDNA_mutation$Chromosome,
                                  cfDNA_mutation$Start_Position,cfDNA_mutation$End_Position,
                                  cfDNA_mutation$Tumor_Sample_Barcode,stringsAsFactors = F)
colnames(cfDNA_mutation_result)<-gsub("cfDNA_mutation\\.","",colnames(cfDNA_mutation_result))
write.table(cfDNA_mutation_result,"D:\\ctdna mutation program\\data\\result\\normalize\\cfDNA_mutation_result.txt",sep="\t",quote=FALSE,row.names = F)
