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

import com.breeze.cloud.admin.api.SysOauthClientDetailsFeign;
import com.breeze.cloud.security.config.BreezeOauthServerAuthenticationEntryPoint;
import com.breeze.cloud.security.config.BreezeOauthServerWebResponseExceptionTranslator;
import com.breeze.cloud.security.filter.BreezeOAuthServerClientCredentialsTokenEndpointFilter;
import com.breeze.cloud.security.service.BreezeUserDetailsService;
import com.breeze.cloud.security.sms.config.BreezeSmsCodeTokenGranter;
import com.google.common.collect.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.oauth2.config.annotation.configurers.ClientDetailsServiceConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerConfigurerAdapter;
import org.springframework.security.oauth2.config.annotation.web.configuration.EnableAuthorizationServer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer;
import org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer;
import org.springframework.security.oauth2.provider.CompositeTokenGranter;
import org.springframework.security.oauth2.provider.TokenGranter;
import org.springframework.security.oauth2.provider.request.DefaultOAuth2RequestFactory;
import org.springframework.security.oauth2.provider.token.DefaultTokenServices;
import org.springframework.security.oauth2.provider.token.TokenEnhancer;
import org.springframework.security.oauth2.provider.token.TokenStore;

import java.util.List;

/**
 * @author breeze
 * @date 2021/10/1
 * <p>
 * extents AuthorizationServerConfigurerAdapter
 */
@EnableAuthorizationServer
@Configuration
public class BreezeAuthorizationServerConfig extends AuthorizationServerConfigurerAdapter {

    @Autowired
    public DefaultTokenServices tokenService;

    @Autowired
    private BreezeOauthServerAuthenticationEntryPoint authServerAuthenticationEntryPoint;

    @Autowired
    private SysOauthClientDetailsFeign sysOauthClientDetailsFeign;

    @Autowired
    private BreezeUserDetailsService userDetailsService;

    @Autowired
    private AuthenticationManager authenticationManagerBean;

    @Autowired
    private TokenStore redisTokenStore;

    @Autowired
    private TokenEnhancer breezeTokenEnhancer;

    /**
     * 声明 ClientDetails实现
     */
    public BreezeRedisClientDetailsService clientDetailsService() {
        BreezeRedisClientDetailsService clientDetailsService = new BreezeRedisClientDetailsService(sysOauthClientDetailsFeign);
        return clientDetailsService;
    }

    /**
     * "authorization_code", "password", "client_credentials", "implicit", "refresh_token"
     *
     * @param clients
     * @throws Exception
     */
    @Override
    public void configure(ClientDetailsServiceConfigurer clients) throws Exception {
//        clients.inMemory()
//                .withClient("web")
//                .secret(passwordEncoder.encode("web-secret"))
//                .scopes("all")
//                .authorizedGrantTypes("authorization_code") //code授权
//                .accessTokenValiditySeconds(7200)
//                .redirectUris("https://www.baidu.com")
//
//                .and()
//                .withClient("wx")
//                .secret(passwordEncoder.encode("wx-secret"))
//                .scopes("readOnly")
//                .authorizedGrantTypes("implicit") //静默授权
//                .accessTokenValiditySeconds(7200)
//                .redirectUris("https://www.baidu.com")
//
//                .and()
//                .withClient("qq")
//                .secret(passwordEncoder.encode("qq-secret"))
//                .scopes("all")
//                .authorizedGrantTypes("password") //授权模式标识
//                .accessTokenValiditySeconds(7200)
//                .redirectUris("https://www.baidu.com")
//
//
//                .and()
//                .withClient("client")
//                .secret(passwordEncoder.encode("client-secret"))
//                .scopes("readOnly")
//                .authorizedGrantTypes("client_credentials") //授权模式标识
//                .accessTokenValiditySeconds(3600)
//                .redirectUris("https://www.baidu.com")        ;
        clients.withClientDetails(clientDetailsService());
    }

    @Override
    public void configure(AuthorizationServerSecurityConfigurer security) {
        // 自定义 BreezeClientCredentialsTokenEndpointFilter，用于处理客户端id，密码错误的异常
        BreezeOAuthServerClientCredentialsTokenEndpointFilter endpointFilter
                = new BreezeOAuthServerClientCredentialsTokenEndpointFilter(security, authServerAuthenticationEntryPoint);
        endpointFilter.afterPropertiesSet();
        security.addTokenEndpointAuthenticationFilter(endpointFilter);

        security
                .authenticationEntryPoint(authServerAuthenticationEntryPoint)
                // 开启/oauth/token_key验证端口认证权限访问
                .tokenKeyAccess("isAuthenticated()")
                //  开启/oauth/check_token验证端口认证权限访问
                .checkTokenAccess("permitAll()");
    }

    /**
     * 暴露授权服务器给认证管理器
     *
     * @param endpoints
     */
    @Override
    public void configure(AuthorizationServerEndpointsConfigurer endpoints) {
        TokenGranter tokenGranter = endpoints.getTokenGranter();
        List<TokenGranter> granterList = Lists.newArrayList(tokenGranter);
        BreezeSmsCodeTokenGranter smsCodeTokenGranter = new BreezeSmsCodeTokenGranter(authenticationManagerBean,
                tokenService, clientDetailsService(), new DefaultOAuth2RequestFactory(clientDetailsService()));
        granterList.add(smsCodeTokenGranter);
        CompositeTokenGranter compositeTokenGranter = new CompositeTokenGranter(granterList);
        endpoints
                // 请求方式
                .allowedTokenEndpointRequestMethods(HttpMethod.POST)
                // 指定token存储位置
                .tokenStore(redisTokenStore)
                .tokenEnhancer(breezeTokenEnhancer)
                // 用户账号密码认证
                .userDetailsService(userDetailsService)
                // 指定认证管理器
                .authenticationManager(authenticationManagerBean)
                .tokenGranter(compositeTokenGranter)
                // 是否重复使用 refresh_token
                .reuseRefreshTokens(Boolean.FALSE)
                .exceptionTranslator(new BreezeOauthServerWebResponseExceptionTranslator())
        ;
    }

}
