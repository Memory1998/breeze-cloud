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

package com.breeze.security.filter;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.oauth2.common.exceptions.BadClientCredentialsException;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.client.ClientCredentialsTokenEndpointFilter;
import org.springframework.security.web.AuthenticationEntryPoint;

/**
 * 重写过滤器自定义客户端ID、秘钥异常异常处理
 *
 * @author breeze
 * @date 2021/10/1
 */
public class BreezeOAuthServerClientCredentialsTokenEndpointFilter extends ClientCredentialsTokenEndpointFilter {

    private AuthorizationServerSecurityConfigurer configurer;

    private AuthenticationEntryPoint authenticationEntryPoint;

    /**
     * @param configurer               AuthorizationServerSecurityConfigurer
     * @param authenticationEntryPoint 自定义的 AuthenticationEntryPoint
     */
    public BreezeOAuthServerClientCredentialsTokenEndpointFilter(AuthorizationServerSecurityConfigurer configurer,
                                                                 AuthenticationEntryPoint authenticationEntryPoint) {
        this.configurer = configurer;
        this.authenticationEntryPoint = authenticationEntryPoint;
    }

    @Override
    public void setAuthenticationEntryPoint(AuthenticationEntryPoint authenticationEntryPoint) {
        super.setAuthenticationEntryPoint(null);
        this.authenticationEntryPoint = authenticationEntryPoint;
    }

    /**
     * 重写这个方法返回 AuthenticationManager
     */
    @Override
    protected AuthenticationManager getAuthenticationManager() {
        return configurer.and().getSharedObject(AuthenticationManager.class);
    }

    /**
     * 设置 AuthenticationEntryPoint 成功或者失败的处理
     */
    @Override
    public void afterPropertiesSet() {
        // 定制认证失败处理器
        setAuthenticationFailureHandler((request, response, exception) -> {
            if (exception instanceof BadCredentialsException) {
                exception = new BadCredentialsException(exception.getMessage(), new BadClientCredentialsException());
            }
            authenticationEntryPoint.commence(request, response, exception);
            // TODO 可以增加 监听器 进行异步操作 比如 保存日志
        });

        // 成功处理器
        setAuthenticationSuccessHandler((request, response, authentication) -> {
            // TODO 可以增加 监听器 进行异步操作 比如 保存日志
        });
    }
}
