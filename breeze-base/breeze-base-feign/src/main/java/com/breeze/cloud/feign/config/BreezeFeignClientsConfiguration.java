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

package com.breeze.cloud.feign.config;

import cn.hutool.core.util.StrUtil;
import feign.RequestInterceptor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.http.HttpHeaders;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;

/**
 * OpenFeign 中继器
 *
 * @author gaoweixuan
 * @date 2022/04/27
 */
@Slf4j
@Configuration
@Import(FeignLoggerConfiguration.class)
public class BreezeFeignClientsConfiguration {

    /**
     * feign 调用丢失token解决方案，新增拦截器
     *
     * @return {@link RequestInterceptor}
     */
    @Bean
    public RequestInterceptor requestInterceptor() {
        return templates -> {
            ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            if (Objects.nonNull(requestAttributes)) {
                HttpServletRequest request = requestAttributes.getRequest();
                String token = request.getHeader(HttpHeaders.AUTHORIZATION);
                templates.header(HttpHeaders.AUTHORIZATION, token);
                String tenantIdHeader = request.getHeader("TENANT_ID");
                log.debug("[租户ID header]： {}", tenantIdHeader);
                if (StrUtil.isAllNotBlank(tenantIdHeader)) {
                    templates.header("TENANT_ID", tenantIdHeader);
                }
                String tenantIdParam = request.getParameter("TENANT_ID");
                log.debug("[租户ID param]： {}", tenantIdParam);
                if (StrUtil.isAllNotBlank(tenantIdParam)) {
                    templates.header("TENANT_ID", tenantIdParam);
                }
            }
        };
    }

}
