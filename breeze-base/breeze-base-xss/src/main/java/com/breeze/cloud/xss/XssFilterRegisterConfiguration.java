/*
 * Copyright (c) 2023, gaoweixuan (breeze-cloud@foxmail.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.breeze.cloud.xss;

import com.breeze.cloud.xss.config.XssProperties;
import com.breeze.cloud.xss.filters.XssFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;

/**
 * xxs过滤器注册配置
 *
 * @author gaoweixuan
 * @date 2022-10-21
 */
@Configuration
@EnableConfigurationProperties(XssProperties.class)
public class XssFilterRegisterConfiguration {

    /**
     * xss属性
     */
    @Autowired
    private XssProperties xssProperties;

    @Autowired
    private RequestMappingHandlerMapping requestMappingHandlerMapping;

    @Autowired
    private ApplicationContext applicationContext;

    /**
     * xss过滤器登记
     *
     * @return {@link FilterRegistrationBean}<{@link Filter}>
     */
    @Bean
    public FilterRegistrationBean<Filter> xssFilterRegistration() {
        FilterRegistrationBean<Filter> registration = new FilterRegistrationBean<>();
        // 过滤器要设置最先执行
        registration.setOrder(Integer.MAX_VALUE);
        registration.setDispatcherTypes(DispatcherType.REQUEST);
        registration.setFilter(new XssFilter(this.xssProperties,
                this.requestMappingHandlerMapping,
                this.applicationContext
        ));
        registration.addUrlPatterns("/*");
        registration.setName("xssFilter");
        return registration;
    }

}
