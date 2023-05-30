package com.breeze.cloud.flow;

import com.breeze.cloud.feign.EnableBreezeFeignClients;
import com.breeze.cloud.security.annotation.EnableResourceServer;
import com.breeze.cloud.validater.EnableFastValidator;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

/**
 * 工作流应用程序
 *
 * @author gaoweixuan
 * @date 2023-04-11
 */
@EnableCaching
@EnableResourceServer
@EnableFastValidator
@EnableBreezeFeignClients
@SpringBootApplication
public class BreezeFlowApplication {

    public static void main(String[] args) {
        SpringApplication.run(BreezeFlowApplication.class, args);
    }

}
