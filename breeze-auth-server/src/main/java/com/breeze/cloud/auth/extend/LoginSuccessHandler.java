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

package com.breeze.cloud.auth.extend;

import com.breeze.cloud.auth.utils.UrlThreadLocal;
import lombok.SneakyThrows;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录成功处理程序
 *
 * @author gaoweixuan
 * @date 2023/05/11
 */
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    private final HttpSecurity httpSecurity;

    public LoginSuccessHandler(HttpSecurity http) {
        httpSecurity = http;
    }

    /**
     * 身份验证成功
     *
     * @param request        请求
     * @param response       响应
     * @param authentication 身份验证
     */
    @SneakyThrows
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        try {
            RequestCache requestCache = httpSecurity.getSharedObject(RequestCache.class);
            SavedRequest savedRequest = requestCache.getRequest(request, response);
            String redirectUrl = savedRequest.getRedirectUrl();
            // 由于RequestCache保存了上一次的请求地址，我们中转了一下页面导致上一次地址被覆盖，使用拦截器暂存
            String url = UrlThreadLocal.get();
            response.sendRedirect(url);
        } finally {
            UrlThreadLocal.remove();
        }
    }

}
