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

package com.breeze.cloud.oauth2.config;

import com.breeze.cloud.security.service.BreezeUserDetailsService;
import com.breeze.cloud.security.sms.config.BreezeSmsCodeAuthenticationSecurityConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.core.annotation.Order;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.PasswordEncoder;

/**
 * @author breeze
 * @date 2021/10/1
 */
@Order(99)
@EnableWebSecurity
public class BreezeWebSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    public BreezeSmsCodeAuthenticationSecurityConfig smsCodeAuthenticationSecurityConfig;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private BreezeUserDetailsService userDetailsService;

    /**
     * 密码授权机制，不用登录，需要配置一个认证管理器
     *
     * @return
     * @throws Exception
     */
    @Bean(name = BeanIds.AUTHENTICATION_MANAGER)
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder);
    }

    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/assets/**", "/resources/**", "/error", "/css/**", "/images/**", "/favicon.ico");
    }

    /**
     * @param http
     * @throws Exception
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.apply(smsCodeAuthenticationSecurityConfig);
        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED);

        http.formLogin()
                .loginPage("/login/page")
                .loginProcessingUrl("/login/form");
        // 过滤请求
        http.authorizeRequests()
                .antMatchers(
                        "/v2/api-docs"
                        , "/actuator/**"
                        , "/swagger-ui.html"
                        , "/doc.html"
                        , "/v2/**"
                        , "/swagger-resources"
                        , "/swagger-resources/**"
                        , "/webjars/**"
                        , "/login/**"
                ).permitAll()
                // 所有请求全部需要鉴权认证
                .anyRequest().authenticated();
        http.headers().frameOptions().disable();
        // CSRF禁用
        http.csrf().disable().cors();
    }

}
