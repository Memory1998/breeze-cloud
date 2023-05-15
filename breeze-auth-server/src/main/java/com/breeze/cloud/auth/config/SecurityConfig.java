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

import com.breeze.cloud.auth.extend.CustomLogoutSuccessHandler;
import com.breeze.cloud.auth.extend.FormLoginFailHandler;
import com.breeze.cloud.auth.extend.FormOidcLoginSuccessHandler;
import com.breeze.cloud.auth.extend.OidcLoginBeforeStoreProcessorFilter;
import com.breeze.cloud.log.events.PublisherSaveSysLogEvent;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.ExceptionTranslationFilter;
import org.springframework.session.data.redis.RedisIndexedSessionRepository;
import org.springframework.session.security.SpringSessionBackedSessionRegistry;

/**
 * 安全配置
 *
 * @author gaoweixuan
 * @date 2023-04-14
 */
@RequiredArgsConstructor
@EnableWebSecurity(debug = true)
public class SecurityConfig {


    /**
     * 发布系统日志事件
     */
    private final PublisherSaveSysLogEvent publisherSaveSysLogEvent;

    /**
     * redis session仓库
     */
    private final RedisIndexedSessionRepository sessionRepository;

    /**
     * 默认安全过滤器链，授权服务器本身的安全配置
     *
     * @param http http
     * @return {@link SecurityFilterChain}
     * @throws Exception 异常
     */
    @Bean
    SecurityFilterChain defaultSecurityFilterChain(HttpSecurity http) throws Exception {
        // @formatter:off
       http.authorizeRequests(authorizeRequests ->
               // 开放自定义的需要开放的端点
               authorizeRequests.antMatchers("/auth/**").permitAll()
                       .anyRequest().authenticated()
       );

        //解决不允许显示在iframe的问题
        http.headers()
                .frameOptions()
                .sameOrigin();

        http.csrf().disable();

        // 登录
        http.formLogin()
                .loginPage("/auth/login")
                .loginProcessingUrl("/auth/login")
                .successHandler(new FormOidcLoginSuccessHandler(publisherSaveSysLogEvent))
                .failureHandler(new FormLoginFailHandler(publisherSaveSysLogEvent));

        // 退出登录
        http.logout()
                .logoutSuccessHandler(new CustomLogoutSuccessHandler())
                .deleteCookies("JSESSIONID")
                .invalidateHttpSession(true);

        // session
        http.sessionManagement()
                // Session的并发控制,这里设置最多一个【只允许一个用户登录】,如果同一个账户两次登录,那么第一个账户将被踢下线
                 .maximumSessions(1)
                 .maxSessionsPreventsLogin(false)
                 .sessionRegistry(sessionBackedSessionRegistry());

        // 默认是开通session fixation防护的,
        // 防护的原理为，每当用户认证过后，就会重新生成一个新的session，并抛弃旧的session
         http.sessionManagement().sessionFixation().migrateSession();

        // 增加自定义过滤器
        http.addFilterBefore(new OidcLoginBeforeStoreProcessorFilter(http), ExceptionTranslationFilter.class);
        // @formatter:on
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
     * 会话支持会话注册表
     *
     * @return {@link SpringSessionBackedSessionRegistry}
     */
    @Bean
    public SpringSessionBackedSessionRegistry<?> sessionBackedSessionRegistry() {
        return new SpringSessionBackedSessionRegistry<>(sessionRepository);
    }

    /**
     * 网络安全编辑器
     *
     * @return {@link WebSecurityCustomizer}
     */
    @Bean
    WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().antMatchers("/actuator/**", "/favicon.ico", "/resources/**", "/webjars/**", "/error");
    }

}
