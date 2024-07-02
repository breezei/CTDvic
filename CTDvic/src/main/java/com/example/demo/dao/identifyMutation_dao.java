package com.example.demo.dao;

import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class identifyMutation_dao {
    String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");
    String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
    public identifyMutation_dao(RConnection rConnection, String uuid, String relativePathtoData, String relativePathToPro) throws RserveException {
        //因为normalize后的不包含ref,alt等，所以只能用没有标准化之前的原始突变文件
        String readTablePath_origin_mutation = rootPath + relativePathtoData + "uploads/mutations/" + uuid +".txt";
        String readTablePath_element_filter = rootPath + relativePathtoData + "analysis/results/" + uuid +"/element_filter/";
        String writeTablePath = rootPath + relativePathtoData + "analysis/results/" + uuid + "/element_hot_mutation/";
        String programPath = rootPath + relativePathToPro + "identify_DriverMutation.R";
        rConnection.eval("rm(list=ls())");
        rConnection.assign("readTablePath_origin_mutation",readTablePath_origin_mutation);
        rConnection.assign("readTablePath_element_filter",readTablePath_element_filter);
        rConnection.assign("writeTablePath",writeTablePath);
        rConnection.assign("programPath",programPath);
        rConnection.eval("source(programPath)");
        System.out.println("Identify mutation finish...");
    }
}
