
package com.example.demo.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class jspTest2 {
    @RequestMapping(value = "/index_test")
    public String doView() {
        return "index"; // 可访问到：src/main/webapp/pages/index.jsp
    }
}
