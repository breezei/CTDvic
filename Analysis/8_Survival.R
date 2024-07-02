##生存分析

 
 wd <- paste("D:\\ctdna mutation program\\survival\\分析结果\\",filename,"\\",sep="")
 #driver_gene_path <- paste("D:\\ctdna mutation program\\data\\结果汇总_基因去重_暂时无用\\",filename,".txt",sep="")
 mut_path <- paste("D:\\ctdna mutation program\\survival\\分析结果\\",filename,"\\p_gene_m.txt",sep="")
 sur_path <- paste("D:\\ctdna mutation program\\survival\\分析结果\\",filename,"\\survival.txt",sep="")
 
 setwd(wd)
 driver_gene_assem <- read.table("D:\\ctdna mutation program\\data\\result\\result_bind\\final_result.txt", header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
 mut <- read.table(mut_path, header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
 sur <- read.table(sur_path, header = T,sep="\t",stringsAsFactors=FALSE,quote = "")
 library(ggplot2)
 library(survival)
 library("survminer")
 ##两个表取根据patient_id取交集，可以排除无突变和无临床信息的患者
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
 ##把某个基因两个分组都有（患者既有突变，又有不突变），全部患者突变，全部患者不突变三种情况分开作图
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

 path <- paste(filename,"_",i,".png",sep="")
 ggsave(path,width = 6,height = 5)  ##ggplot 中直接保存
 }