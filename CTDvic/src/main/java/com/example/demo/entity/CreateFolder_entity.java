package com.example.demo.entity;

import java.io.File;

public class CreateFolder_entity {
    String targetPath;
    String uuid;
    String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");;
    String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
    public CreateFolder_entity(String targetPath,String uuid){
        this.targetPath = targetPath;
        this.uuid = uuid;
    }
    public CreateFolder_entity(String targetPath){
        this.targetPath = targetPath;
    }
    public void createFolder(){

        File folder = new File(rootPath + targetPath);
        if (!folder.isDirectory()) {
            folder.mkdirs();
        }
    }
    public void createOneAnalyseDirectory() {
        String[] all = new String[]{"normalize", "element_mapping", "element_result", "element_filter","element_hot_mutation"};
        for(int i=0;i<all.length;i++){
            File folder = new File(rootPath + targetPath +"analysis/results/" + uuid + "/" + all[i]);
            if (!folder.isDirectory()) {
                folder.mkdirs();
            }
        }
    }
}
