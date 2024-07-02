package com.example.demo.dao;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class mapping_dao {
    String readTablePath;
    String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");
    String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
    public mapping_dao(String readTablePath){
        this.readTablePath = readTablePath;
    }
    public void mapping(RConnection rConnection, String relativePathToData, String relativePathToPro, String uuid,String hg) throws RserveException, REXPMismatchException {
        String pathToHg19 = rootPath + relativePathToPro + "driverpover_element/element_hg19/";
        String pathToHg38 = rootPath + relativePathToPro + "driverpover_element/element_hg38/";
        String writeTablePath = rootPath + relativePathToData + "analysis/results/"+uuid+"/element_mapping/";
        String programPath = rootPath + relativePathToPro + "element_Mapping.R";
        rConnection.eval("rm(list=ls())");
        rConnection.assign("programPath",programPath);
        rConnection.assign("readTablePath",readTablePath);
        //System.out.println(rConnection.eval("test1<-1;test1").asString());
        if(hg.equals("hg19")){
            rConnection.assign("hg_bed","_hg19.bed");
            rConnection.assign("hgPath",pathToHg19);
            rConnection.assign("writeTablePath",writeTablePath);
            rConnection.eval("source(programPath)");
        }else if(hg.equals("hg38")){
            rConnection.assign("hg_bed","_hg38.bed");
            rConnection.assign("hgPath",pathToHg38);
            rConnection.assign("writeTablePath",writeTablePath);
            rConnection.eval("source(programPath)");
        }
        System.out.println("Mapping finish...");
    }
}
