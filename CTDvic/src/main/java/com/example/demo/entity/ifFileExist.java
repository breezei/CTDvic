package com.example.demo.entity;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
public class ifFileExist {
    public ifFileExist(){
    }
    public static boolean fileState(String filePath){
        Path filepath = Paths.get(filePath);
        if (Files.exists(filepath)) {
            return true;
        } else {
            System.out.println("File does not exist.");
            return false;
        }
    }
    public static boolean fileDirectoryState(String filePath){
        // 指定目录路径
        String directoryPath = filePath;

        // 创建File对象
        File directory = new File(directoryPath);

        // 检查目录是否存在
        if (directory.exists() && directory.isDirectory()) {
            // 获取目录下的文件列表
            String[] fileList = directory.list();

            // 判断文件数量是否为0
            if (fileList != null && fileList.length == 0) {
                System.out.println("Directory is null !");
                return false;
            } else {
                System.out.println("Directory not null, files number: " + fileList.length);
                return true;
            }
        } else {
            System.out.println("The specified directory does not exist or is not a directory !");
            return false;
        }
    }

}
