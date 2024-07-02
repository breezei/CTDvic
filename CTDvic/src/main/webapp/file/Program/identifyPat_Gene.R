driver_gene_assem <- read.table(readTablePath_driverGene, header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
judge_table <- read.table(readTablePath_normalize,
                          header = T,sep = "\t",stringsAsFactors = F,quote = "")
driver_gene <- unique(driver_gene_assem$gene)

patients_id <- unique(judge_table$Tumor_Sample_Barcode)

colname <- c('patient_id',driver_gene)

patients_driver<-data.frame(matrix(nrow = length(patients_id), ncol = length(colname)))
colnames(patients_driver)=c(colname)
patients_driver[,1] <- patients_id

num <- dim(judge_table)
r_num <- num[1]
c_num <- num[2]
for(i in patients_id){

  r_n <- which(grepl(i, patients_driver$patient_id))
  for(j in driver_gene){
    patients_driver[r_n,j] <- 0
    
    

    gene_hotregion_colname <- c('gene','startposition','endposition')
    gene_hotregion <- data.frame(matrix(ncol = length(gene_hotregion_colname),nrow = 0))
    colnames(gene_hotregion) <- gene_hotregion_colname
    UTR3_rn<- which(driver_gene_assem$Elementkind == "3UTR" & driver_gene_assem$gene == j)
    
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

   # transfer relative column as numeric;    R3.6.3 report error if remove
     judge_table$Start_Position <- as.numeric(as.character(judge_table$Start_Position))
     judge_table$End_Position <- as.numeric(as.character(judge_table$End_Position))
     gene_hotregion$startposition <- as.numeric(as.character(gene_hotregion$startposition))
     gene_hotregion$endposition <- as.numeric(as.character(gene_hotregion$endposition))


    for(z in 1:r_num){
     
      if(judge_table[z,"Hugo_Symbol"]==j && judge_table[z,"Tumor_Sample_Barcode"]==i){
        
        for(x in 1:nrow(gene_hotregion)){
          if(gene_hotregion[x,"startposition"]<judge_table[z,"Start_Position"] && gene_hotregion[x,"endposition"]>judge_table[z,"End_Position"]){
            patients_driver[r_n,j] <- 1;
          }
        }
        
      }
      
    }
  }
}
write.table(patients_driver,file=writeTablePath,quote = FALSE,row.names = F,sep ="\t" )
