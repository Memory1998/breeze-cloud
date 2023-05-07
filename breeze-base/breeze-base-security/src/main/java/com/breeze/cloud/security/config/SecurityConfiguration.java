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

package com.breeze.cloud.security.config;

import com.breeze.cloud.security.auth.AuthAuthenticationProvider;
import com.breeze.cloud.security.email.EmailCodeAuthenticationProvider;
import com.breeze.cloud.security.init.BreezeJumpAuthPathInit;
import com.breeze.cloud.security.properties.OauthLoginProperties;
import com.breeze.cloud.security.properties.WxLoginProperties;
import com.breeze.cloud.security.service.LocalUserDetailsService;
import com.breeze.cloud.security.sms.SmsAuthenticationProvider;
import com.breeze.cloud.security.wx.WxCodeAuthenticationProvider;
import com.breeze.cloud.security.wxphone.WxPhoneAuthenticationProvider;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.ExpressionUrlAuthorizationConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.security.web.SecurityFilterChain;

/**
 * 安全配置
 *
 * @author gaoweixuan
 * @date 2022-08-31
 */
@Configuration(proxyBeanMethods = false)
@EnableConfigurationProperties({WxLoginProperties.class, OauthLoginProperties.class})
public class SecurityConfiguration {

    /**
     * 不需要认证切面类
     */
    @Autowired
    private BreezeJumpAuthPathInit noAuthenticationInit;

    /**
     * 身份验证配置
     */
    @Autowired
    private AuthenticationConfiguration authenticationConfiguration;

    /**
     * 用户详细信息服务
     */
    @Autowired
    private LocalUserDetailsService userDetailsService;

    /**
     * redis请求
     */
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * 身份验证管理器生成器
     */
    @Autowired
    private AuthenticationManagerBuilder authenticationManagerBuilder;

    /**
     * wx登录属性
     */
    @Autowired
    private WxLoginProperties wxLoginProperties;

    /**
     * 安全过滤器链
     *
     * @param http http
     * @return {@link SecurityFilterChain}
     * @throws Exception 异常
     */
    @Bean
    @Order(Ordered.HIGHEST_PRECEDENCE)
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .httpBasic().disable()
                .formLogin().disable()
                .csrf().disable()
                // 不使用session
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .oauth2ResourceServer()
                .jwt()
                // 将jwt信息转换成JwtAuthenticationToken对象
                .jwtAuthenticationConverter(jwtAuthenticationConverter())
                .and()
                .accessDeniedHandler(new CustomAccessDeniedHandler())
                .authenticationEntryPoint(new CustomAuthenticationEntryPoint())
                .and()
                .cors();

        ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry expressionInterceptUrlRegistry = http.authorizeRequests();
        // 只有{{没有登录}}可以访问
        noAuthenticationInit.ignoreAuthProperties.getIgnoreUrls()
                .forEach(url -> expressionInterceptUrlRegistry.antMatchers(url).permitAll());
        // 其余的必须登录
        expressionInterceptUrlRegistry
                .anyRequest().authenticated();
        return http.build();
    }

    /**
     * 从 JWT 的 scope 中获取的权限 取消 SCOPE_ 的前缀
     * <p>
     * 设置从 jwt claim 中那个字段获取权限
     * 若需要同多个字段中获取权限或者是通过url请求获取的权限，则需要自己提供jwtAuthenticationConverter() 方法实现
     *
     * @return JwtAuthenticationConverter
     */
    private JwtAuthenticationConverter jwtAuthenticationConverter() {
        JwtAuthenticationConverter converter = new JwtAuthenticationConverter();
        JwtGrantedAuthoritiesConverter authoritiesConverter = new JwtGrantedAuthoritiesConverter();
        // 去掉 SCOPE_ 的前缀
        authoritiesConverter.setAuthorityPrefix("");
        // 在 jwt claim 中那个字段获取权限，默认是从 scope 或 scp 字段中获取
        authoritiesConverter.setAuthoritiesClaimName("scope");
        converter.setJwtGrantedAuthoritiesConverter(authoritiesConverter);
        return converter;
    }

    /**
     * 用户身份验证管理器
     *
     * @return {@link AuthenticationManager}
     */
    @Bean
    @SneakyThrows
    public AuthenticationManager authenticationManager() {
        return authenticationConfiguration.getAuthenticationManager();
    }

    /**
     * 短信令牌身份验证提供者 Bean
     *
     * @return {@link SmsAuthenticationProvider}
     */
    @Bean
    public SmsAuthenticationProvider smsTokenAuthenticationProvider() {
        SmsAuthenticationProvider smsAuthenticationProvider = new SmsAuthenticationProvider(userDetailsService, redisTemplate);
        this.authenticationManagerBuilder.authenticationProvider(smsAuthenticationProvider);
        return smsAuthenticationProvider;
    }

    /**
     * 邮箱令牌身份验证提供者 Bean
     *
     * @return {@link EmailCodeAuthenticationProvider}
     */
    @Bean
    public EmailCodeAuthenticationProvider emailCodeAuthenticationProvider() {
        EmailCodeAuthenticationProvider emailCodeAuthenticationProvider = new EmailCodeAuthenticationProvider(userDetailsService, redisTemplate);
        this.authenticationManagerBuilder.authenticationProvider(emailCodeAuthenticationProvider);
        return emailCodeAuthenticationProvider;
    }

    /**
     * 微信令牌身份验证提供者 Bean
     *
     * @return {@link WxCodeAuthenticationProvider}
     */
    @Bean
    public WxCodeAuthenticationProvider wxCodeAuthenticationProvider() {
        WxCodeAuthenticationProvider wxCodeAuthenticationProvider = new WxCodeAuthenticationProvider(userDetailsService, wxLoginProperties);
        this.authenticationManagerBuilder.authenticationProvider(wxCodeAuthenticationProvider);
        return wxCodeAuthenticationProvider;
    }


    /**
     * 微信电话授权身份验证提供者 Bean
     *
     * @return {@link WxPhoneAuthenticationProvider}
     */
    @Bean
    public WxPhoneAuthenticationProvider wxPhoneAuthenticationProvider() {
        WxPhoneAuthenticationProvider wxPhoneAuthenticationProvider = new WxPhoneAuthenticationProvider(userDetailsService, wxLoginProperties);
        this.authenticationManagerBuilder.authenticationProvider(wxPhoneAuthenticationProvider);
        return wxPhoneAuthenticationProvider;
    }

    /**
     * 三方登录身份验证提供者 Bean
     *
     * @return {@link AuthAuthenticationProvider}
     */
    @Bean
    public AuthAuthenticationProvider authAuthenticationProvider() {
        AuthAuthenticationProvider authAuthenticationProvider = new AuthAuthenticationProvider(userDetailsService);
        this.authenticationManagerBuilder.authenticationProvider(authAuthenticationProvider);
        return authAuthenticationProvider;
    }

}
