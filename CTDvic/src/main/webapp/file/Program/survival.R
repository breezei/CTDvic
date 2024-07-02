#pub_id <- "34799585_sur_non-small cell lung cancer"
#wd <- paste("D:\\ctdna mutation program\\survival\\分析结果\\",pub_id,"\\",sep="")
#driver_gene_path <- paste("D:\\ctdna mutation program\\data\\结果汇总_基因去重_暂时无用\\",pub_id,".txt",sep="")
#mut_path <- paste("D:\\ctdna mutation program\\survival\\分析结果\\",pub_id,"\\p_gene_m.txt",sep="")
#sur_path <- paste("D:\\ctdna mutation program\\survival\\分析结果\\",pub_id,"\\survival.txt",sep="")

setwd(wd)
driver_gene_assem <- read.table(readTablePath_driverGene, header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
mut <- read.table(readTablePath_mut, header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
sur <- read.table(readTablePath_sur, header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
library(ggplot2)
library(survival)
library("survminer")

#colnames(sur)[1] <- "patient_id"
sur_data <- merge(sur,mut,by = "patient_id")
#coxph(Surv(OS,status)~EGFR,data=sur_data)
#可视化
driver_gene <- unique(driver_gene_assem$gene)
for(i in driver_gene){
  group <- sapply(sur_data[[i]],function(x){
    if(x==1){return("variant")}else{return("non_variant")}
  })

  #,ylab = "Probability of progression-free survival"

  if(colnames(sur)[3]=="OS"){
  result <- survfit(Surv(OS,status)~group,data=data.frame(sur_data,group))
    if(!is.na(table(group)["variant"]) && !is.na(table(group)["non_variant"])){
      ggsurvplot(result,pval = T,xlab = "Time",ylab = "Survival probability(OS)",pval.method=TRUE,legend.title = paste(i,"Variant condition"),legend.labs = c("non_variant","variant"))
    }else if(is.na(table(group)["non_variant"])){
      ggsurvplot(result,pval = T,xlab = "Time",ylab = "Survival probability(OS)",pval.method=TRUE,legend.title = paste(i,"Variant condition"),legend.labs = c("variant"))
    }else if(is.na(table(group)["variant"])){
      ggsurvplot(result,pval = T,xlab = "Time",ylab = "Survival probability(OS)",pval.method=TRUE,legend.title = paste(i,"Variant condition"),legend.labs = c("non_variant"))
    }
  }else{
  result <- survfit(Surv(PFS,status)~group,data=data.frame(sur_data,group))
    if(!is.na(table(group)["variant"]) && !is.na(table(group)["non_variant"])){
      ggsurvplot(result,pval = T,xlab = "Time",ylab = "Survival probability(PFS)",pval.method=TRUE,legend.title = paste(i,"Variant condition"),legend.labs = c("non_variant","variant"))
    }else if(is.na(table(group)["non_variant"])){
      ggsurvplot(result,pval = T,xlab = "Time",ylab = "Survival probability(PFS)",pval.method=TRUE,legend.title = paste(i,"Variant condition"),legend.labs = c("variant"))
    }else if(is.na(table(group)["variant"])){
      ggsurvplot(result,pval = T,xlab = "Time",ylab = "Survival probability(PFS)",pval.method=TRUE,legend.title = paste(i,"Variant condition"),legend.labs = c("non_variant"))
    }
  }
  
  name <- paste(i,".png",sep="")
  ggsave(name,width = 6,height = 5)  ##ggplot 中直接保存
}