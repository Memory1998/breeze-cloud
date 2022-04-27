/*
 * Copyright 2021 the original author or authors.
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

package com.breeze.cloud.security.config;

import cn.hutool.core.util.ArrayUtil;
import com.breeze.cloud.security.annotation.JoinWhiteList;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import java.lang.reflect.Method;
import java.util.Map;
import java.util.Objects;
import java.util.Set;

/**
 * 项目初始化的时候去加载使用跳过登录的注解的方法请求
 * 加入到 security.oauth2.ignore 中
 *
 * @author breeze
 * @date 2021/10/1
 */
@Slf4j
@Configuration
public class BreezeJoinTheWhiteListConfigurer implements InitializingBean {

    @Autowired
    private BreezeOauth2ClientIgnoreProperties oAuth2ClientIgnoreProperties;

    @Autowired
    private RequestMappingHandlerMapping requestMappingHandlerMapping;

    @Autowired
    private ApplicationContext applicationContext;

    @Bean
    @LoadBalanced
    public RestTemplate getInstance() {
        return new RestTemplate();
    }

    @Override
    public void afterPropertiesSet() {
        Map<RequestMappingInfo, HandlerMethod> handlerMethodMap = requestMappingHandlerMapping.getHandlerMethods();
        // 获取全部的请求方法
        handlerMethodMap.forEach((requestMappingInfo, method) -> {
            Class clazz = method.getClass();
            Set<String> methodUrls = requestMappingInfo.getPatternsCondition().getPatterns();
            if (!clazz.isAnnotationPresent(JoinWhiteList.class)) {
                this.setUrl(method, methodUrls);
            } else {
                Method[] methods = clazz.getMethods();
                if (ArrayUtil.contains(methods, method)) {
                    oAuth2ClientIgnoreProperties.getUrls().addAll(methodUrls);
                }
            }
        });
    }

    private void setUrl(HandlerMethod method, Set<String> methodUrls) {
        methodUrls.forEach(handlerMethod -> {
            if (filterHandlerMethod(method)) {
                log.info("已经加入白名单 ====> {}", handlerMethod);
                oAuth2ClientIgnoreProperties.getUrls().add(handlerMethod);
            }
        });
    }

    private Boolean filterHandlerMethod(HandlerMethod method) {
        JoinWhiteList joinWhiteList = method.getMethodAnnotation(JoinWhiteList.class);
        return Objects.isNull(joinWhiteList) ? Boolean.FALSE : Boolean.TRUE;
    }

}
