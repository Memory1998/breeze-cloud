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

package com.breeze.cloud.auth.config;

import com.breeze.cloud.auth.authentication.password.UsernamePasswordFormLoginBeforeProcessorFilter;
import com.breeze.cloud.auth.service.UserPrincipalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 安全配置
 *
 * @author gaoweixuan
 * @date 2023-04-14
 */
@EnableWebSecurity(debug = true)
public class SecurityConfig {

    /**
     * 身份验证管理器生成器
     */
    @Autowired
    private AuthenticationManagerBuilder authenticationManagerBuilder;

    /**
     * 用户详细信息服务
     */
    @Autowired
    private UserPrincipalService userDetailsService;

    /**
     * 默认安全过滤器链，授权服务器本身的安全配置
     *
     * @param http http
     * @return {@link SecurityFilterChain}
     * @throws Exception 异常
     */
    @Bean
    SecurityFilterChain defaultSecurityFilterChain(HttpSecurity http) throws Exception {
        http.authorizeRequests(authorizeRequests ->
                // 开放自定义的需要开放的端点
                authorizeRequests
                        .antMatchers("/login").permitAll()
                        .anyRequest().authenticated()
        );

        http.headers()
                .frameOptions()
                .sameOrigin();
        // 设置登录表单页面
        http.formLogin().loginPage("/login")
                .loginProcessingUrl("/custom/auth/login")
                .successHandler(new AuthenticationSuccessHandler() {
                    @Override
                    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                        String url = "http://localhost:8000/oauth2/authorize" +
                                "?response_type=code" +
                                "&client_id=messaging-client" +
                                "&scope=openid%20profile" +
                                "&state=Tuh4Jf_MoLkJn6C9Iga8qWUraoHZgiAok0TXk6eWgNc%3D" +
                                "&redirect_uri=http://127.0.0.1:8080/login/oauth2/code/messaging-client-oidc" +
                                "&nonce=e8_WBpeuUCN5gf0UH5TfL9tkwsXIV08aW3RePI6ptsM" +
                                "&tenantId=" + request.getParameter("tenantId");
                        response.sendRedirect(url);
                    }
                });
        http.logout().logoutSuccessUrl("/logout").logoutSuccessUrl("/custom/auth/logout").invalidateHttpSession(true).deleteCookies("JSESSIONID");

        http.addFilterBefore(new UsernamePasswordFormLoginBeforeProcessorFilter("/custom/auth/login", authenticationManagerBuilder.getObject()),
                UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    /**
     * 密码编码器
     *
     * @return {@link PasswordEncoder}
     */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

    /**
     * 网络安全编辑器
     *
     * @return {@link WebSecurityCustomizer}
     */
    @Bean
    WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().antMatchers("/favicon.ico", "/resources/**", "/webjars/**", "/error");
    }

}
