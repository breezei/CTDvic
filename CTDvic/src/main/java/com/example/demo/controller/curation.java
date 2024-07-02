package com.example.demo.controller;
import com.example.demo.dao.Visual_dao;
import com.example.demo.dao.generateJson_dao;
import com.example.demo.entity.CustomException;
import com.example.demo.entity.Error_entity;
import com.example.demo.entity.Result_entity;
import com.example.demo.service.Analyse_service;
import com.example.demo.service.SurvivalAnalyse_service;
import com.example.demo.service.sendResult_service;
import com.example.demo.service.uploadFileSave_service;

import javax.servlet.http.HttpServletRequest;

import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;


@Controller
@ResponseBody
public class curation {
 /*
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

    @PostMapping("/upload")
    public String upload(MultipartFile multipartfile, HttpServletRequest request) {
        String realPath = request.getSession().getServletContext().getRealPath("/file/");
        String format = sdf.format(new Date());
        File folder = new File(realPath + format);
        if (!folder.isDirectory()) {
            folder.mkdirs();
        }
        String oldname = multipartfile.getOriginalFilename();
        String newname = UUID.randomUUID().toString() + oldname.substring(oldname.lastIndexOf("."), oldname.length());
        try {
            multipartfile.transferTo(new File(folder, newname));
            System.out.println(new File(folder, newname).getAbsolutePath());//输出（上传文件）保存的绝对路径
            String filePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + "/update/" + format + newname;
            return filePath + "上传成功";
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "上传失败!";
    }

  */

    public HashMap<String, Object> upload1(MultipartFile mutation, MultipartFile survival, HttpServletRequest request) {
        String uuid = null;
        String hg = null;
        HashMap<String,Object> analyseState = new HashMap<String, Object>();
        // 上传生存数据不为空时处理
        if (survival != null && !survival.isEmpty()) {
            try {
                //确定基因组版本
                hg = request.getParameter("hg");
                //保存mutation和survival文件
                uploadFileSave_service uploadfilesave_serivice = new uploadFileSave_service(mutation, survival, request);
                uuid = uploadfilesave_serivice.saveTwoTypeFile();
                //进行分析
                Analyse_service analyse = new Analyse_service(uuid,hg);
                List geneList = analyse.getGenelist();
                //可视化
                Map visual_result = Visual_dao.visual(uuid,hg);
                //生存分析
                SurvivalAnalyse_service S = new SurvivalAnalyse_service(uuid);
                S.survival();
                //分析成功返回状态码及不同element下载地址（json格式）
                analyseState.put("code","101");
                analyseState.put("message","success");
                analyseState.put("uuid",uuid);
                analyseState.put("visual",visual_result);
                analyseState.put("geneList",geneList);
                return analyseState;

            } catch (RuntimeException e) {
                analyseState.put("code","104");
                analyseState.put("message",e.toString());
                return analyseState;
            } catch (REXPMismatchException e) {
                analyseState.put("code","104");
                analyseState.put("message",e.toString());
                return analyseState;
            } catch (RserveException e) {
                analyseState.put("code","104");
                analyseState.put("message",e.toString());
                return analyseState;
            } catch (IOException e) {
                analyseState.put("code","104");
                analyseState.put("message",e.toString());
                return analyseState;
            } catch (CustomException e) {
                analyseState.put("code","102");
                analyseState.put("message",e.toString());
                return analyseState;
            }


        } else {
            // 生存为空，仅进行驱动突变分析
            try {
                //确定基因组版本
                hg = request.getParameter("hg");
                //保存mutation文件
                uploadFileSave_service uploadfilesave_serivice = new uploadFileSave_service(mutation, request);
                uuid = uploadfilesave_serivice.savaMutationFile();
                //进行分析
                Analyse_service analyse = new Analyse_service(uuid,hg);
                List geneList = analyse.getGenelist();
                //可视化
                Map visual_result = Visual_dao.visual(uuid,hg);
                //分析成功返回状态码及不同element下载地址（json格式）
                analyseState.put("code","100");
                analyseState.put("message","success");
                analyseState.put("uuid",uuid);
                analyseState.put("visual",visual_result);
                analyseState.put("geneList",geneList);
                return analyseState;

            } catch (RuntimeException e) {
                analyseState.put("code","104");
                analyseState.put("message",e.toString());
                return analyseState;
            } catch (REXPMismatchException e) {
                analyseState.put("code","104");
                analyseState.put("message",e.toString());
                return analyseState;
            } catch (RserveException e) {
                analyseState.put("code","104");
                analyseState.put("message",e.toString());
                return analyseState;
            } catch (IOException e) {
                analyseState.put("code","104");
                analyseState.put("message",e.toString());
                return analyseState;
            } catch (CustomException e) {
                analyseState.put("code","102");
                analyseState.put("message",e.toString());
                return analyseState;
            }
        }
        }



    @ResponseBody
    @RequestMapping(value = "/analyseResult" ,produces = MediaType.APPLICATION_JSON_VALUE , method = RequestMethod.POST)
    public Result_entity getResult(MultipartFile mutation, MultipartFile survival, HttpServletRequest request){
        HashMap state = upload1(mutation,survival,request);
        String code = (String) state.get("code");
        String mailAddress = request.getParameter("mailAddress");
        switch (code){
            //仅分析及可视化
            case "100":
                 Result_entity R = new Result_entity((String) state.get("code"), (String) state.get("message"), (String) state.get("uuid"),(Map) state.get("visual"),(List) state.get("geneList"));
                 //获取element列表
                 R.suc();
                System.out.println(mailAddress);
                //判断用户是否输入了邮箱
                if(mailAddress == null || mailAddress.isEmpty() || "undefined".equals(mailAddress)){
                    return R;
                }else {
                    //Result 对象打包成json文件
                    generateJson_dao G = new generateJson_dao(R, R.getUuid());
                    String jsonPath = G.geJ();
                    //发送邮件链接
                    sendResult_service send = new sendResult_service(R.getUuid(), mailAddress);
                    return R;
                }
            //分析，生存及可视化
            case "101":
                Result_entity R1 = new Result_entity((String) state.get("code"), (String) state.get("message"), (String) state.get("uuid"),(Map) state.get("visual"),(List) state.get("geneList"));
                R1.suc();
                System.out.println(mailAddress);
                //判断用户是否输入了邮箱
                if(mailAddress == null || mailAddress.isEmpty() || "undefined".equals(mailAddress)){
                    return R1;
                }else {
                    //Result 对象打包成json文件
                    generateJson_dao G = new generateJson_dao(R1, R1.getUuid());
                    String jsonPath = G.geJ();
                    //发送邮件链接
                    sendResult_service send = new sendResult_service(R1.getUuid(), mailAddress);
                    return R1;
                }
            //未识别出驱动基因（任意读入目录为空）
            case "102":
                Result_entity R2 = new Result_entity((String) state.get("code"), (String) state.get("message"));
                R2.error();
                return R2;
            //数据格式不正确，r脚本执行报错
            case "103":
                Result_entity R3 = new Result_entity((String) state.get("code"), (String) state.get("message"));
                R3.error();
                return R3;
            //java抛出异常
            case "104":
                Result_entity R4 = new Result_entity((String) state.get("code"), (String) state.get("message"));
                R4.error();
                return R4;
            default:
                Result_entity RDe = new Result_entity((String) state.get("code"), (String) state.get("message"));
                RDe.error();
                return RDe;
        }

    }

    //Test 测试json数据转换是否成功
    //@RequestMapping("/user")
   // public Result_entity getuser(){
   //     Map A = new HashMap();
    //    System.out.println("D:\\ctdna mutation program\\pro\\识别突变热点");
    //    Result_entity R1 = new Result_entity("100", "message","1",A);
    //    return  R1;
   // }

}

