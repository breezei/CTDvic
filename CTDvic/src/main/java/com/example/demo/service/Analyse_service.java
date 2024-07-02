package com.example.demo.service;
import com.example.demo.dao.*;
import com.example.demo.entity.*;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.List;

public class Analyse_service {
    String uuid;
    String hg;
    String rootPathWithBin = System.getProperty("user.dir").replace("\\", "/");
    String rootPath = rootPathWithBin.endsWith("/bin") ? rootPathWithBin.substring(0, rootPathWithBin.length() - 4) : rootPathWithBin;
    String relativePathToData = "/webapps/CTDvic/file/data/";
    String relativePathToPro = "/webapps/CTDvic/file/Program/";
    //创建R连接对象
    RConnection rConnection = new RConnection(); //没有关闭上一个连接新建连接会出现超时错误
    public Analyse_service(String uuid,String hg) throws REXPMismatchException ,CustomException, IOException,RserveException{
        try {
            this.uuid = uuid;
            this.hg = hg;
            createDirectory();
            String temPath = unitInputFormat();
            String filepath = temPath;
            if (!ifFileExist.fileState(filepath)) {
                throw new CustomException("Driver genes and hotspot mutations not identified");
            }
            mapping(temPath, hg);
            filepath = rootPath + relativePathToData + "analysis/results/" + uuid + "/element_mapping";
            if (!ifFileExist.fileDirectoryState(filepath)) {
                throw new CustomException("Driver genes and hotspot mutations not identified");
            }
            javaAnalyse();
            filepath = rootPath + relativePathToData + "analysis/results/" + uuid + "/element_result";
            if (!ifFileExist.fileDirectoryState(filepath)) {
                throw new CustomException("Driver genes and hotspot mutations not identified");
            }
            Filter();
            identify_mutation();
            merge();

        } catch (REXPMismatchException e) {
            throw new RuntimeException(e);
        } catch (CustomException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (RserveException e) {
            throw new RuntimeException(e);
        } finally {
            rConnection.close();
        }
    }
    //创建分析所需目录
    public void createDirectory(){
        CreateFolder_entity CF = new CreateFolder_entity(relativePathToData,uuid);
        CF.createOneAnalyseDirectory();
        System.out.println("Create One Analyse Directory finish...");
    }

    //统一输入格式
    public String unitInputFormat() throws REXPMismatchException, RserveException, CustomException {

        UnitInputFormat_dao unitInputFormatDao = new UnitInputFormat_dao();
        return unitInputFormatDao.unitInputFormat(rConnection,relativePathToData,uuid);
    }

    //基因组原件映射
    private void mapping(String readTablePath,String hg) throws RserveException, REXPMismatchException {
        mapping_dao mappingDao = new mapping_dao(readTablePath);
        mappingDao.mapping(rConnection,relativePathToData,relativePathToPro,uuid,hg);
    }

    //java分析
    private void javaAnalyse() throws IOException {
        eleMHRresult2_dao eleMHRresult2Dao = new eleMHRresult2_dao();
        eleMHRresult2Dao.analyse(relativePathToData,uuid);
    }

    //过滤和注释
    private void Filter() throws RserveException, REXPMismatchException {
        FilterAndAnnatation_dao filterAndAnnatationDao = new FilterAndAnnatation_dao();
        filterAndAnnatationDao.filterAndAnnotation(rConnection,relativePathToData,relativePathToPro,uuid);
    }
    //计算不同基因组元件的驱动突变
    private void identify_mutation() throws RserveException {
        identifyMutation_dao im = new identifyMutation_dao(rConnection,uuid,relativePathToData,relativePathToPro);
    }
    //合并filter后的文件(驱动基因，不是驱动突变)
    public void merge() throws RserveException {
        Merge_dao Md = new Merge_dao(rConnection,uuid,relativePathToData,relativePathToPro);
    }
    //得到基因list
    public List getGenelist() throws RserveException, REXPMismatchException {
        RConnection rConnectionL = new RConnection();
        try {
            List a = generateGenelist_dao.geneList(rConnectionL, uuid, relativePathToData);
            System.out.println("Get genelist finish...");
            return a;
        }
        catch (REXPMismatchException e) {
            throw new RuntimeException(e);
        }  catch (RserveException e) {
            throw new RuntimeException(e);
        }
        finally {
            rConnectionL.close();
        }
    }
}

