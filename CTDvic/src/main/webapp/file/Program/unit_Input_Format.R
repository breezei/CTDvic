
#check and install package
check_and_install_package <- function(package_name) {

  if (!requireNamespace(package_name)) {
    install.packages(package_name, dependencies = TRUE)
    if (!requireNamespace(package_name)) {
      stop(paste("Package", package_name, "could not be installed. Please check your internet connection and try again."))
    }
  }
  print(paste(package_name,"existed..."))
  library(package_name, character.only = TRUE)
}
check_and_install_package("tidyr")
check_and_install_package("ggplot2")
check_and_install_package("survival")
check_and_install_package("car")
check_and_install_package("survminer")


cfDNA_mutation<-read.table(readTablePath,header = T,sep = "\t",stringsAsFactors = F,quote = "")
cfDNA_mutation_result<-data.frame(cfDNA_mutation$Hugo_Symbol,cfDNA_mutation$Chromosome,
                                  cfDNA_mutation$Start_Position,cfDNA_mutation$End_Position,
                                  cfDNA_mutation$Tumor_Sample_Barcode,stringsAsFactors = F);
colnames(cfDNA_mutation_result)<-gsub("cfDNA_mutation\\.","",colnames(cfDNA_mutation_result))
write.table(cfDNA_mutation_result,writeTablePath,sep="\t",quote=FALSE,row.names = F)