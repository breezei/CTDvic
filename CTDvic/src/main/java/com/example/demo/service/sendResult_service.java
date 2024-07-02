package com.example.demo.service;

import static com.example.demo.dao.sendResult_dao.sendEmail;

public class sendResult_service {

    // 发件人电子邮箱
    final String from = "ctdvic_bio@163.com";
    // 指定发送邮件的主机为 example.com
    final String host = "smtp.163.com";
    // 发件人的邮箱用户名和密码
    final String username = "ctdvic_bio@163.com";
    final String password = "";

    public sendResult_service(String uuid, String mailAddress) {
        // 收件人电子邮箱
        String to = mailAddress;
        sendEmail(to, from, host, username, password, uuid);
    }
}
