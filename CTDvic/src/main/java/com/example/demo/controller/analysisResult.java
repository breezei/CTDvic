package com.example.demo.controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class analysisResult {
    @RequestMapping("/analysisResult")
    public String doView(@RequestParam(name = "id", required = false) String id, Model model) {
        // 将id添加到Model中
        model.addAttribute("id", id);
        return "analysisResult"; // 返回视图名称
    }
}

