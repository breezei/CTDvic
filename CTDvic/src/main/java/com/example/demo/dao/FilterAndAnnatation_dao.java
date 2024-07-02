package com.example.demo.dao;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class FilterAndAnnatation_dao {
    String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");
    String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
    public FilterAndAnnatation_dao(){}
    public void filterAndAnnotation(RConnection rConnection, String relativePathToData, String relativePathToPro, String uuid) throws RserveException, REXPMismatchException {
        String readTablePath = rootPath + relativePathToData + "analysis/results/"+uuid+"/element_result/";
        String writeTablePath = rootPath + relativePathToData + "analysis/results/"+uuid+"/element_filter/";
        String readMappingPath = rootPath + relativePathToData + "analysis/results/"+uuid+"/element_mapping/";
        String programPath = rootPath + relativePathToPro + "filter_Annotation.R";
        rConnection.eval("rm(list=ls())");
        //指定脚本中读入文件路径
        rConnection.assign("readTablePath",readTablePath);
        rConnection.assign("readMappingPath",readMappingPath);
        //指定执行脚本路径
        rConnection.assign("programPath",programPath);
        //指定脚本中输出文件路径
        rConnection.assign("writeTablePath",writeTablePath);
        rConnection.eval("source(programPath)");
        //System.out.println(rConnection.eval("test2<-2;test2").asString());
        System.out.println("FilterAndAnnatation finish...");
    }
}
