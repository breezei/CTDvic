#总流程
#一段
rm(list=ls())
filename <- "variant" 
source("D:\\ctdna mutation program\\source_pro\\1_Uniform input format.R")
rm(list=ls())
hg <- "hg19"
source("D:\\ctdna mutation program\\source_pro\\2_Mapping to different genomic elements.R")

#java


#二段
rm(list=ls())
##GRCh37/GRCh38
GRCH <- "GRCh37"
source("D:\\ctdna mutation program\\source_pro\\4_Annotating and filtering mutation hotspots.R")
rm(list=ls())
filename <- "variant"
source("D:\\ctdna mutation program\\source_pro\\5_Identifying all mutations within each element.R")
rm(list=ls())
filename <- "variant"
source("D:\\ctdna mutation program\\source_pro\\6_Merging different sets.R")##结果同时写入了统计文档汇总

##生存
rm(list=ls())
filename <- "variant"
source("D:\\ctdna mutation program\\source_pro\\7_Mutation status of different driver genes in patients.R")
rm(list=ls())
filename <- "variant"
source("D:\\ctdna mutation program\\source_pro\\8_Survival.R")

