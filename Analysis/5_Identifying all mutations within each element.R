
####将结果文件增加chr Hot_Position_Start  Hot_Position_End 
setwd("D:\\ctdna mutation program\\data\\result\\element_filter\\");
##读入未标准化的突变文件(包含ref,alt,mutation_type)
origin_mutation <- read.table(paste("D:\\ctdna mutation program\\data\\mutation_txt\\",filename,'.txt',sep=""),
                              header = T,sep = "\t",stringsAsFactors = F,quote = "")
origin_mutation <- origin_mutation[!duplicated(origin_mutation[c("Hugo_Symbol", "Start_Position","End_Position")]), ]
list<-list.files(pattern = ".txt");
element<-gsub("_length.txt","",list);
i=1
for (i in 1:length(list)) {
  element_filter<-read.table(paste("D:\\ctdna mutation program\\data\\result\\element_filter\\",list[i],sep = ""),
                             header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
  driver_mutation_colnames <- c(colnames(element_filter))
  driver_mutation <- data.frame(matrix(nrow = 0, ncol = length(driver_mutation_colnames)))
  colnames(driver_mutation) <- driver_mutation_colnames
  for(j in 1:nrow(element_filter)){
    ###temple表实际用到的只有起始终止两列
    temple <- origin_mutation[origin_mutation$Hugo_Symbol==element_filter[j,"gene"] & origin_mutation$Start_Position >= element_filter[j,"minpos"]
              & origin_mutation$End_Position <= element_filter[j,"maxpos"],]
    repeated_row <- element_filter[j, ]  #
    repeated_rows <- do.call(rbind,replicate(nrow(temple), repeated_row, simplify = FALSE))
    ##将重复行构成的数据框和起始终止位点的数据框合并
    repeated_rows <- data.frame(repeated_rows,data.frame(Hot_Position_Start=temple$Start_Position,Hot_Position_End=temple$End_Position,Reference=temple$Reference,Alteration=temple$Alteration,Mutation_type=temple$Mutation_type))
  
    # 将一个热点基因热点区域内的所有热点突变添加到突变集合
    driver_mutation <-rbind(driver_mutation,repeated_rows)
    }
  if(nrow(driver_mutation)>0){
    write.table(driver_mutation,paste("D:\\ctdna mutation program\\data\\result\\element_hot_mutation\\",list[i],sep = ""),sep="\t",quote=FALSE,row.names = F)
  }
  
}