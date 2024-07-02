package com.example.demo;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;
/*
@SpringBootApplication(scanBasePackages={"com.example.demo"})
public class CtApplication{
	public static void main(String[] args) {
		SpringApplication.run(CtApplication.class, args);
	}

}
*/
/**/

@SpringBootApplication
public class CtApplication extends SpringBootServletInitializer {
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(CtApplication.class);
	}
	public static void main(String[] args) {
		SpringApplication.run(CtApplication.class, args);
	}

}

