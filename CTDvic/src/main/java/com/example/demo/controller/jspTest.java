package com.example.demo.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;


import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;

@Controller
@ResponseBody
public class jspTest {
    @RequestMapping("/TEST")
    public String t(){
        return "test";
    }

    @RequestMapping(value = "/upload_test",method = RequestMethod.POST)
    public String t2(HttpServletRequest rq) {
        String u = rq.getParameter("username");
        System.out.println(u);
        return u;

    }
}
