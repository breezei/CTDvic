
setwd("D:\\ctdna mutation program\\data\\result\\element_hot_mutation\\")
filest <- list.files(pattern = ".txt")
filelent <- length(filest)
if(filelent>=1){
for (i in 1:filelent) {
  if(i==1){
    final_result <- read.table(filest[i],header = T,sep = "\t",stringsAsFactors = F,quote = "")
  }
 else{ temp <- read.table(filest[i],header = T,sep = "\t",stringsAsFactors = F,quote = "")
 final_result=rbind(final_result,temp)
 }}
}

write.table(final_result,file='D:\\ctdna mutation program\\data\\result\\result_bind\\final_result.txt',quote = FALSE,row.names = F,col.name = T,sep ="\t" )
write.table(final_result,file=paste('D:\\ctdna mutation program\\data\\Integrate result\\',filename,'.txt',sep=""),quote = FALSE,row.names = F,col.name = T,sep ="\t" )