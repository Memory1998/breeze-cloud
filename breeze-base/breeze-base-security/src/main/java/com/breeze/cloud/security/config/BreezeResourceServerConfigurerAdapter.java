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

package com.breeze.cloud.security.config;

import com.breeze.cloud.security.properties.BreezeOauth2ClientIgnoreProperties;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.oauth2.OAuth2ClientProperties;
import org.springframework.boot.autoconfigure.security.oauth2.resource.ResourceServerProperties;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.ExpressionUrlAuthorizationConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.oauth2.config.annotation.web.configuration.ResourceServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configurers.ResourceServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.token.*;
import org.springframework.web.client.RestTemplate;

/**
 * @author breeze
 * @date 2021/10/1
 */
@Slf4j
@Configuration
public class BreezeResourceServerConfigurerAdapter extends ResourceServerConfigurerAdapter {

    /**
     * 注入服务认证忽略配置
     */
    @Autowired
    public BreezeOauth2ClientIgnoreProperties auth2ClientIgnoreProperties;

    /**
     * token失效的处理器
     */
    @Autowired
    private BreezeOauthResourceAuthenticationEntryPoint authResourceAuthenticationEntryPoint;

    /**
     * 使用starter自带的配置
     */
    @Autowired
    private ResourceServerProperties resourceServerProperties;

    /**
     * 使用starter自带的配置
     */
    @Autowired
    private OAuth2ClientProperties oAuth2ClientProperties;

    /**
     * token的存放 RedisTokenStore
     */
    @Autowired
    private TokenStore redisTokenStore;

    /**
     * 权限不足的异常处理
     */
    @Autowired
    private BreezeAccessDeniedHandler requestAccessDeniedHandler;

    @Bean
    @LoadBalanced
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

    @Bean
    @Primary
    public ResourceServerTokenServices resourceServerTokenServices() {
        RemoteTokenServices remoteTokenServices = new RemoteTokenServices();
        remoteTokenServices.setCheckTokenEndpointUrl(resourceServerProperties.getTokenInfoUri());
        remoteTokenServices.setClientId(oAuth2ClientProperties.getClientId());
        remoteTokenServices.setClientSecret(oAuth2ClientProperties.getClientSecret());
        remoteTokenServices.setRestTemplate(restTemplate());
        DefaultAccessTokenConverter accessTokenConverter = new DefaultAccessTokenConverter();
        UserAuthenticationConverter breezeDefaultUserAuthenticationConverter = new BreezeDefaultUserAuthenticationConverter();
        accessTokenConverter.setUserTokenConverter(breezeDefaultUserAuthenticationConverter);
        remoteTokenServices.setAccessTokenConverter(accessTokenConverter);
        return remoteTokenServices;
    }

    @Override
    public void configure(HttpSecurity http) throws Exception {
        http.csrf().disable();
        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry registry = this.setExpressionInterceptUrlRegistry(http);
        registry.anyRequest().authenticated();
    }

    public ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry setExpressionInterceptUrlRegistry(HttpSecurity http) throws Exception {
        ExpressionUrlAuthorizationConfigurer<HttpSecurity>.ExpressionInterceptUrlRegistry registry = http
                .authorizeRequests();
        auth2ClientIgnoreProperties.getUrls().forEach(url -> registry.antMatchers(url).permitAll());
        return registry;
    }

    /**
     * @param resources
     */
    @Override
    public void configure(ResourceServerSecurityConfigurer resources) {
        resources
                .tokenStore(redisTokenStore)
                // 令牌失效处理器
                .authenticationEntryPoint(authResourceAuthenticationEntryPoint)
                .tokenServices(resourceServerTokenServices())
                // 权限不足处理器
                .accessDeniedHandler(requestAccessDeniedHandler)
                .stateless(Boolean.TRUE);
    }

}
