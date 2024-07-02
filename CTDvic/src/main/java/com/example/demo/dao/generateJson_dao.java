package com.example.demo.dao;
import com.example.demo.entity.Result_entity;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.io.IOException;
public class generateJson_dao {
    String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");
    String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
    String relativePathToResults = "/webapps/CTDvic/file/data/analysis/results/";
    Result_entity R;
    String UUID;
    public generateJson_dao(Result_entity R, String UUID){
        this.R = R;
        this.UUID = UUID;
    }
    public String geJ(){
        String path = rootPath + relativePathToResults + UUID + "/visual.json";
        // 创建ObjectMapper实例
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            // 将对象序列化为JSON，并保存到文件中
            objectMapper.writeValue(new File(path), R);
            System.out.println("Generate json finish...");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return path;
    }
}
