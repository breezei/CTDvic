package com.example.demo.dao;

import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class IdentifyPat_Gene_dao {

    String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");
    String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
    public IdentifyPat_Gene_dao(RConnection rConnection, String uuid, String relativePathtoData, String relativePathToPro) throws RserveException {
        String readTablePath_driverGene = rootPath + relativePathtoData + "analysis/results/" + uuid +"/final_result.txt";
        String readTablePath_normalize = rootPath + relativePathtoData + "analysis/results/" + uuid +"/normalize/cfDNA_mutation_result.txt";
        String writeTablePath = rootPath + relativePathtoData + "analysis/results/" + uuid + "/p_gene_m.txt";
        String programPath = rootPath + relativePathToPro + "identifyPat_Gene.R";
        rConnection.eval("rm(list=ls())");
        rConnection.assign("readTablePath_driverGene",readTablePath_driverGene);
        rConnection.assign("readTablePath_normalize",readTablePath_normalize);
        //指定执行脚本路径
        rConnection.assign("programPath",programPath);
        //指定脚本中输出文件路径
        rConnection.assign("writeTablePath",writeTablePath);
        rConnection.eval("source(programPath)");
        System.out.println("Indentify Pat_Gene finish...");
    }

}
