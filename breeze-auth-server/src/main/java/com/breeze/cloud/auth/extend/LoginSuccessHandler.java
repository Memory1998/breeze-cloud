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

import lombok.SneakyThrows;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 登录成功处理程序
 *
 * @author gaoweixuan
 * @date 2023/05/11
 */
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    @SneakyThrows
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        String url = "http://localhost:8000/oauth2/authorize" +
                "?response_type=code" +
                "&client_id=messaging-test" +
                "&scope=openid%20profile" +
                "&state=Tuh4Jf_MoLkJn6C9Iga8qWUraoHZgiAok0TXk6eWgNc%3D" +
                "&redirect_uri=http://127.0.0.1:8080/login/oauth2/code/messaging-client-oidc" +
                "&nonce=e8_WBpeuUCN5gf0UH5TfL9tkwsXIV08aW3RePI6ptsM" +
                "&tenantId=" + request.getParameter("tenantId");
        response.sendRedirect(url);
    }

}
