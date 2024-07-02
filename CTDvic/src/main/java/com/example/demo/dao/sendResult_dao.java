package com.example.demo.dao;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class sendResult_dao {

    public static void sendEmail(String to, String from, String host, String username, String password, String UUID) {
        // 设置邮件服务器
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.port", "25"); // SMTP 端口号
        properties.put("mail.smtp.starttls.enable", "true"); // 启用TLS

        // 获取默认的 Session 对象，并传入用户名和密码进行认证
        Session session = Session.getDefaultInstance(properties,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {
            // 创建默认的 MimeMessage 对象
            MimeMessage message = new MimeMessage(session);

            // 设置 From: 头部字段
            message.setFrom(new InternetAddress(from));

            // 设置 To: 头部字段
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

            // 设置 Subject: 头部字段
            message.setSubject("Analysis result");

            // 设置邮件的内容类型为 text/html，并写入HTML内容
            String htmlContent =
                    "<h5>JobID: "+UUID+"</h5>"
                    + "<p>The analysis you submitted in CTDvic has been completed, Click the link or copy it into your browser to view the analysis results. If the 'Visualization' section does not load successfully, refresh the page and try again. </p>"
                    + "<a href='http://bio-bigdata.hrbmu.edu.cn/CTDvic/analysisResult?id=" + UUID + "'>http://bio-bigdata.hrbmu.edu.cn/CTDvic/analysisResult?id=" + UUID +"</a>";
            message.setContent(htmlContent, "text/html; charset=utf-8");
            System.out.println(htmlContent);
            // 发送消息
            Transport.send(message);
            System.out.println("Send mail finish...");
        } catch (MessagingException mex) {
            mex.printStackTrace();
        }
    }
}