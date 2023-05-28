package com.breeze.cloud.xxjob.config;

import com.xxl.job.core.executor.impl.XxlJobSpringExecutor;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * xxl工作配置
 *
 * @author gaoweixuan
 * @date 2023/04/15
 */
@Slf4j
@Configuration
@RequiredArgsConstructor
@EnableConfigurationProperties(XxlJobProperties.class)
public class XxlJobConfiguration {

    private final XxlJobProperties xxlJobProperties;

    @Bean
    public XxlJobSpringExecutor xxlJobExecutor() {
        log.info("----- xxl-job config init -----");
        XxlJobSpringExecutor xxlJobSpringExecutor = new XxlJobSpringExecutor();
        xxlJobSpringExecutor.setAdminAddresses(xxlJobProperties.getAdmin().getAdminAddresses());
        XxlJobProperties.Executor executor = xxlJobProperties.getExecutor();
        xxlJobSpringExecutor.setAppname(executor.getAppName());
        xxlJobSpringExecutor.setIp(executor.getIp());
        xxlJobSpringExecutor.setAddress(executor.getAddress());
        xxlJobSpringExecutor.setPort(executor.getPort());
        xxlJobSpringExecutor.setAccessToken(executor.getAccessToken());
        xxlJobSpringExecutor.setLogPath(executor.getLogPath());
        xxlJobSpringExecutor.setLogRetentionDays(executor.getLogRetentionDays());
        log.info("----- xxl-job config end -----");
        return xxlJobSpringExecutor;
    }

}
