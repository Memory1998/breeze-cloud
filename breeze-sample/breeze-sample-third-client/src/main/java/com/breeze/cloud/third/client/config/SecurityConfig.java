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

package com.breeze.cloud.third.client.config;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.SecurityFilterChain;

import java.net.URLEncoder;

/**
 * 安全配置
 *
 * @author gaoweixuan
 * @date 2023-04-23
 */
@EnableWebSecurity
public class SecurityConfig {

    /**
     * 网络安全编辑器
     *
     * @return {@link WebSecurityCustomizer}
     */
    @Bean
    WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().antMatchers("/webjars/**");
    }

    /**
     * 安全过滤器链
     *
     * @param http http
     * @return {@link SecurityFilterChain}
     * @throws Exception 异常
     */
    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        return http
                .antMatcher("/**").authorizeRequests()
                // 访问权限
                .antMatchers("/oauth2Login", "/static").permitAll()
                .anyRequest().authenticated()
                .and()
                // 支持 OAuth2 登录
                .oauth2Login()
                //登录页面
                .loginPage("/oauth2Login")
                //登录成功后调转页面
                .defaultSuccessUrl("/index")
                //登录失败调转页面
                .failureUrl("/oauth2Login")
                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/oauth2Login")
                .logoutSuccessHandler((request, response, authentication)
                        -> response.sendRedirect("oathLogin/msg=" + URLEncoder.encode("退出成功", "UTF-8")))
                .and().build();

    }

}
