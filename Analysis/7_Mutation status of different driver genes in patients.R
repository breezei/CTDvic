##得到患者各个驱动基因突变情况

##读入驱动基因突变文件
driver_gene_assem <- read.table("D:\\ctdna mutation program\\data\\result\\result_bind\\final_result.txt", header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
##读入原始突变文件
judge_table <- read.table("D:\\ctdna mutation program\\data\\result\\normalize\\cfDNA_mutation_result.txt",
                          header = T,sep = "\t",stringsAsFactors = F,quote = "")
 driver_gene <- unique(driver_gene_assem$gene)
 ##这里不用临床信息表的原因是有的患者不存在突变,这部分患者无法确定驱动突变是否与预后相关(保证每个基因至少一个患者突变)
 patients_id <- unique(judge_table$Tumor_Sample_Barcode)
 ##
 colname <- c('patient_id',driver_gene)
 ##创建空的行列数分别为患者数和基因数的数据框
 patients_driver<-data.frame(matrix(nrow = length(patients_id), ncol = length(colname)))
 colnames(patients_driver)=c(colname)
 patients_driver[,1] <- patients_id
 
 ##每个患者从第一行开始匹配到，匹配上后再确定基因是否相同，相同的即为突变基因 > 不严谨，需要这个
 num <- dim(judge_table)
 r_num <- num[1]
 c_num <- num[2]
 for(i in patients_id){
   #查找患者对应行号
   r_n <- which(grepl(i, patients_driver$patient_id))
   for(j in driver_gene){
     patients_driver[r_n,j] <- 0
     
     
     ####创建每个element驱动基因热点突变区域集合表
     gene_hotregion_colname <- c('gene','startposition','endposition')
     gene_hotregion <- data.frame(matrix(ncol = length(gene_hotregion_colname),nrow = 0))
     colnames(gene_hotregion) <- gene_hotregion_colname
     ##这里which匹配可能匹配上多行，所以返回的索引是一个数组
     UTR3_rn<- which(driver_gene_assem$Elementkind == "3UTR" & driver_gene_assem$gene == j)
     ##这里的话driver_gene_assem中一个element中应该只有一个基因，也就是返回数组要么为空要么只有一个数，但是为了确保不出现错误，还是判断一下并且取第一个数
     if (length(UTR3_rn) > 0) {
       UTR3_rn <- UTR3_rn[1]
       new_row_df<-as.data.frame(t(c(driver_gene_assem[UTR3_rn,"Elementkind"],driver_gene_assem[UTR3_rn,"minpos"],driver_gene_assem[UTR3_rn,"maxpos"])))
       colnames(new_row_df) <- gene_hotregion_colname
       gene_hotregion<-rbind(gene_hotregion,new_row_df)
     } 
     
     UTR5_rn<- which(driver_gene_assem$Elementkind == "5UTR" & driver_gene_assem$gene == j)
     if (length(UTR5_rn) > 0) {
       UTR5_rn <- UTR5_rn[1]
       new_row_df<-as.data.frame(t(c(driver_gene_assem[UTR5_rn,"Elementkind"],driver_gene_assem[UTR5_rn,"minpos"],driver_gene_assem[UTR5_rn,"maxpos"])))
       colnames(new_row_df) <- gene_hotregion_colname
       gene_hotregion<-rbind(gene_hotregion,new_row_df)
     }
     
     
     CDS_rn<- which(driver_gene_assem$Elementkind == "CDS" & driver_gene_assem$gene == j)
     if (length(CDS_rn) > 0) {
       CDS_rn <- CDS_rn[1]
       new_row_df<-as.data.frame(t(c(driver_gene_assem[CDS_rn,"Elementkind"],driver_gene_assem[CDS_rn,"minpos"],driver_gene_assem[CDS_rn,"maxpos"])))
       colnames(new_row_df) <- gene_hotregion_colname
       gene_hotregion<-rbind(gene_hotregion,new_row_df)
     }
     
     promoter_rn<- which(driver_gene_assem$Elementkind == "promoter" & driver_gene_assem$gene == j)
     if (length(promoter_rn) > 0) {
       promoter_rn <- promoter_rn[1]
       new_row_df<-as.data.frame(t(c(driver_gene_assem[promoter_rn,"Elementkind"],driver_gene_assem[promoter_rn,"minpos"],driver_gene_assem[promoter_rn,"maxpos"])))
       colnames(new_row_df) <- gene_hotregion_colname
       gene_hotregion<-rbind(gene_hotregion,new_row_df)
     }
     
     splice_site_rn<- which(driver_gene_assem$Elementkind == "splice_site" & driver_gene_assem$gene == j)
     if (length(splice_site_rn) > 0) {
       splice_site_rn <- splice_site_rn[1]
       new_row_df<-as.data.frame(t(c(driver_gene_assem[splice_site_rn,"Elementkind"],driver_gene_assem[splice_site_rn,"minpos"],driver_gene_assem[splice_site_rn,"maxpos"])))
       colnames(new_row_df) <- gene_hotregion_colname
       gene_hotregion<-rbind(gene_hotregion,new_row_df)
     }
     
     ##
     # 在循环开始之前，确保将相关列转换为数值类型
     judge_table$Start_Position <- as.numeric(as.character(judge_table$Start_Position))
     judge_table$End_Position <- as.numeric(as.character(judge_table$End_Position))
     gene_hotregion$startposition <- as.numeric(as.character(gene_hotregion$startposition))
     gene_hotregion$endposition <- as.numeric(as.character(gene_hotregion$endposition))
     
     ##
     for(z in 1:r_num){
       cursor <- 0;
       ######判断原始表中的一行gene和患者是否和patients_driver中的一个单元行列对得上
       if(judge_table[z,"Hugo_Symbol"]==j && judge_table[z,"Tumor_Sample_Barcode"]==i){
        #####对上后再判断是否满足gene_hotregion中的任意一列
         for(x in 1:nrow(gene_hotregion)){
           if(gene_hotregion[x,"startposition"]<judge_table[z,"Start_Position"] && gene_hotregion[x,"endposition"]>judge_table[z,"End_Position"])
             {
             patients_driver[r_n,j] <- 1;
             cursor <- 1;
             break
           }
         }
        
       }
        if(cursor == 1){
          break
        }
     }
     
     }
   }
 write.table(patients_driver,file=paste('D:\\ctdna mutation program\\survival\\Analysis result\\',filename,'\\p_gene_m.txt',sep=""),quote = FALSE,row.names = F,sep ="\t" )
 