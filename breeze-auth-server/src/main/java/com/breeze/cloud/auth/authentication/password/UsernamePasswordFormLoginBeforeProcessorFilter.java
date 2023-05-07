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

package com.breeze.cloud.auth.authentication.password;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 用户名密码登录前处理器滤波器形式
 *
 * @author gaoweixuan
 * @date 2023-04-25
 */
@Slf4j
public class UsernamePasswordFormLoginBeforeProcessorFilter extends UsernamePasswordAuthenticationFilter {

    public UsernamePasswordFormLoginBeforeProcessorFilter(String defaultFilterProcessingUrl, AuthenticationManager authenticationManager) {
        super.setFilterProcessesUrl(defaultFilterProcessingUrl);
        super.setAuthenticationManager(authenticationManager);
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
        log.debug("[用户名密码表单登录前置处理器]：{}", request.getRequestURL());
        return super.attemptAuthentication(request, response);
    }

}
