package com.example.demo.dao;
import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REXPString;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

import java.util.ArrayList;
import java.util.List;

public class generateGenelist_dao {

    public generateGenelist_dao(){
    }
    public static List geneList(RConnection rConnection, String uuid, String relativePathtoData) throws RserveException, REXPMismatchException {
        String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");
        String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
        System.out.println(rootPath);
        String readTablePath = rootPath + relativePathtoData + "analysis/results/"+uuid+"/final_result.txt";
        rConnection.eval("rm(list=ls())\n" +
                "final_result <- read.table('" + readTablePath + "', header = T,sep=\"\\t\",stringsAsFactors=FALSE,quote = \"\")\n" +
                "driver_gene <- unique(final_result$gene)\n" +
                "driver_gene_list <- as.list(driver_gene)");
        //r中的genelist转换为Java中的list
        REXP result = rConnection.eval("driver_gene_list");
        RList rList = result.asList();

        List<String> geneList = new ArrayList<>();
        for (int i = 0; i < rList.size(); i++) {
            REXPString rexpString = (REXPString) rList.get(i);
            String gene = rexpString.asString();
            geneList.add(gene);
        }
        // 打印基因列表
        System.out.println("Gene List: " + geneList);
        return geneList;
    }


}
