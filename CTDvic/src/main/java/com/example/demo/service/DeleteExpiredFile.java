package com.example.demo.service;

import org.springframework.stereotype.Service;

import java.io.File;
import java.util.Date;
@Service
public class DeleteExpiredFile {
    static String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");
    static String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
    static String relativePath = rootPath + "/webapps/CTDvic/file/data/";
    private static final String mutation = relativePath + "/uploads/mutations";
    private static final String  upSurvivals= relativePath + "/uploads/survivals";
    private static final String  results= relativePath + "/analysis/results";
    private static final String  anSurvivals= relativePath + "/analysis/survivals";
    //1充当游标的作用
    public void deleteExpiredFileTask() {
        deleteExpiredFile(new File(mutation),1);
        deleteExpiredFile(new File(upSurvivals),1);
        deleteExpiredFile(new File(results),1);
        deleteExpiredFile(new File(anSurvivals),1);
    }
//删除指定目录下的所有过期文件及过期文件夹（没有递归）
    private void deleteExpiredFile(File file,int i) {
        if (!file.exists()) return;
        if (!file.isDirectory()) {
            determineExpiredFile(file);
        } else if(file.listFiles().length == 0) {
                    if(i > 1) {
                        determineExpiredFile(file);
                    }
            }else {
            for (File f : file.listFiles()) {
                deleteExpiredFile(f,i+1);
            }
        }
    }
    //删除文件
    private void determineExpiredFile(File file) {
        long lastModifiedTime = file.lastModified();
        long currentTime = new Date().getTime();
        long timeInterval = 7*24*60*60*1000;// 正式部署时间 7*24*60*60*1000;
        if (currentTime - lastModifiedTime > timeInterval) {
            file.delete();
        }
    }

}
/* 递归删除一定目录下的所有过期文件，保留文件夹
    private void deleteExpiredFile(File file) {
        if (!file.exists()) return;

        if (!file.isDirectory()) {
            determineExpiredFile(file);
        } else {
            for (File f : file.listFiles()) {
                deleteExpiredFile(f);
            }
        }
    }
    }
 */

/* 递归删除一定目录下的所有过期文件，并删除空文件夹
private void deleteExpiredFolder(File folder) {
        if (!folder.exists()) return;
        if (folder.isDirectory()) {
            for (File subFile : folder.listFiles()) {
                if (subFile.isDirectory()) {
                    deleteExpiredFolder(subFile); // Recursively delete subfolders
                } else {
                    determineExpiredFile(subFile); // Delete expired files within the folder
                }
            }
            if (folder.list().length == 0) {
                folder.delete(); // Delete the folder if it's empty
            }
        }
    }
 */