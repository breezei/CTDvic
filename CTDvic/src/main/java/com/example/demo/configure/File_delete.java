package com.example.demo.configure;

import com.example.demo.service.DeleteExpiredFile;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

import javax.annotation.Resource;
import java.util.Date;

@Configuration
@EnableScheduling
@EnableAsync
public class File_delete{


@Resource
DeleteExpiredFile deleteExpiredFile;
//正式用的定时器
    @Scheduled(cron = "0/10 * * * * ?")
    private void fileExpiredControll(){
        //十秒执行一次删除任务
        deleteExpiredFile.deleteExpiredFileTask();
            System.out.println("删除时间：" + new Date());
    }
}
