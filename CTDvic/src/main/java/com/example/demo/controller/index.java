package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

// 首页控制器
@Controller
public class index {
    @RequestMapping("/")
    public String doView() {
        return "index"; // 可访问到：src/main/webapp/pages/index.jsp
    }
}
