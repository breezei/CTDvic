package com.example.demo.configure;
/**
import com.example.demo.dao.quartz;
import org.quartz.JobBuilder;
import org.quartz.*;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.quartz.JobDetailFactoryBean;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;
import org.springframework.scheduling.quartz.SimpleTriggerFactoryBean;


 * 定义任务描述和具体的执行时间
 */

/*
 * quartz的配置类：
 *

@Configuration
public class quartzConfig {

    // 定义要执行的EmailTask任务类，这里是quartz.java
    @Bean
    public JobDetail test() {
        return JobBuilder.newJob(quartz.class).withIdentity("test").storeDurably().build();
    }

    // Simple触发器定义与设置
    @Bean
    public SimpleTrigger testTrigger() {
        // Simple类型：可设置时间间隔、是否重复、触发频率（misfire机制）等
        // 这里我设置的10s的定时任务
        SimpleScheduleBuilder ssb = SimpleScheduleBuilder.simpleSchedule()
                .withIntervalInSeconds(10).repeatForever();

        // 一个Trigger只对应一个Job，Schedule调度器调度Trigger执行对应的Job
        SimpleTrigger sTrigger = TriggerBuilder.newTrigger().forJob(test()).
                withIdentity("testTrigger").withDescription("simple类型的触发器").withSchedule(ssb).build();
        return sTrigger;

    }
}
*/