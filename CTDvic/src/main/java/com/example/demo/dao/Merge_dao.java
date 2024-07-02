package com.example.demo.dao;

import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

import java.sql.Connection;

public class Merge_dao {
    String uuid;
    String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");
    String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
    public Merge_dao(RConnection rConnection, String uuid, String relativePathtoData,String relativePathToPro) throws RserveException {
        this.uuid = uuid;
        String readTablePath = rootPath + relativePathtoData + "analysis/results/" + uuid +"/element_filter/";
        String writeTablePath = rootPath + relativePathtoData + "analysis/results/" + uuid + "/final_result.txt";
        String programPath = rootPath + relativePathToPro + "merge_result.R";
        rConnection.eval("rm(list=ls())");
        rConnection.assign("readTablePath",readTablePath);
        //指定执行脚本路径
        rConnection.assign("programPath",programPath);
        //指定脚本中输出文件路径
        rConnection.assign("writeTablePath",writeTablePath);
        rConnection.eval("source(programPath)");
        System.out.println("Merge result finish...");
    }
}
