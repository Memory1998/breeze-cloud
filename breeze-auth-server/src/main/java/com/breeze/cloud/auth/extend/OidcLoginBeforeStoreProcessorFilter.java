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
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * oidc登录之前存储处理器过滤器
 *
 * @author gaoweixuan
 * @date 2023-04-25
 */
@Slf4j
public class OidcLoginBeforeStoreProcessorFilter extends OncePerRequestFilter {
    private final HttpSecurity httpSecurity;

    public OidcLoginBeforeStoreProcessorFilter(HttpSecurity http) {
        this.httpSecurity = http;
    }

    /**
     * 进行拦截
     *
     * @param request     请求
     * @param response    响应
     * @param filterChain 过滤器链
     */
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) {
        // /oauth2/authorize?response_type=code&client_id=messaging-test&scope=openid%20profile
        // &state=WY06QMNukJogMcy3nU87Ilog82JHK_L_aPTCDNIRt60%3D
        // &redirect_uri=http://127.0.0.1:8080/login/oauth2/code/messaging-client-oidc&nonce=fJ-9NwHGPH2dDVsoicQaheBggqOzQeYuQOwKQS36mSM':
        try {
            RequestCache requestCache = httpSecurity.getSharedObject(RequestCache.class);
            SavedRequest savedRequest = requestCache.getRequest(request, response);
            String url = savedRequest.getRedirectUrl();
            if (savedRequest.getRedirectUrl().contains("/oauth2/authorize?response_type=code") && url.contains("openid")) {
                UrlThreadLocal.set(url);
            } else {
                // 不是oidc
                // TODO
            }
            filterChain.doFilter(request, response);
        } catch (IOException | ServletException e) {
            log.error("[暂存异常]", e);
        }
    }
}
