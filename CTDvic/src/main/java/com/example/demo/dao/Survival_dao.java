package com.example.demo.dao;

import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class Survival_dao{
    String uuid;
    String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");
    String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
    String relativePathtoData;
    String relativePathToPro;
    RConnection rConnection;
    public Survival_dao(RConnection rConnection, String uuid, String relativePathtoData, String relativePathToPro){
        this.uuid = uuid;
        this.relativePathtoData = relativePathtoData;
        this.relativePathToPro = relativePathToPro;
        this.rConnection = rConnection;
    }
    public  void survival() throws RserveException {
        String readTablePath_driverGene = rootPath + relativePathtoData + "analysis/results/" + uuid +"/final_result.txt";
        String readTablePath_mut = rootPath + relativePathtoData + "analysis/results/" + uuid +"/p_gene_m.txt";
        String readTablePath_sur = rootPath + relativePathtoData + "uploads/survivals/" + uuid +".txt";
        String wd = rootPath + relativePathtoData + "analysis/survivals/" + uuid + "/";
        String programPath = rootPath + relativePathToPro + "survival.R";
        rConnection.eval("rm(list=ls())");
        rConnection.assign("readTablePath_driverGene",readTablePath_driverGene);
        rConnection.assign("readTablePath_mut",readTablePath_mut);
        rConnection.assign("readTablePath_sur",readTablePath_sur);
        //指定执行脚本路径
        rConnection.assign("programPath",programPath);
        //指定脚本中输出文件路径
        rConnection.assign("wd",wd);
        rConnection.eval("source(programPath)");
        System.out.println("Survival analysis finish...");
    }
}
