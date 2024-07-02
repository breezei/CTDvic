setwd(readTablePath)
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
write.table(final_result,file=writeTablePath,quote = FALSE,row.names = F,col.name = T,sep ="\t" )