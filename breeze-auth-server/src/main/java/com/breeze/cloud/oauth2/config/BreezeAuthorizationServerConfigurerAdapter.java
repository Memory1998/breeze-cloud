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
import com.breeze.cloud.security.filter.BreezeClientCredentialsTokenEndpointFilter;
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
import org.springframework.security.oauth2.provider.token.AuthorizationServerTokenServices;
import org.springframework.security.oauth2.provider.token.TokenEnhancer;
import org.springframework.security.oauth2.provider.token.TokenStore;

import java.util.List;

/**
 * @author breeze
 * @date 2021/10/1
 * <p>
 * extents AuthorizationServerConfigurerAdapter
 */
@Configuration
@EnableAuthorizationServer
public class BreezeAuthorizationServerConfigurerAdapter extends AuthorizationServerConfigurerAdapter {

    @Autowired
    public AuthorizationServerTokenServices breezeTokenService;

    @Autowired
    private BreezeOauthServerAuthenticationEntryPoint clientCredentialsTokenEndpointFilter;

    @Autowired
    private SysOauthClientDetailsFeign sysOauthClientDetailsFeign;

    @Autowired
    private BreezeUserDetailsService breezeUserDetailsService;

    @Autowired
    private AuthenticationManager authenticationManagerBean;

    @Autowired
    private TokenStore redisTokenStore;

    @Autowired
    private TokenEnhancer breezeTokenEnhancer;

    /**
     * ?????? ClientDetails??????
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
        // clients.inMemory()
        //      .withClient("web")
        //      .secret(passwordEncoder.encode("web-secret"))
        //      .scopes("all")
        //      .authorizedGrantTypes("authorization_code") //code??????
        //      .accessTokenValiditySeconds(7200)
        //      .redirectUris("https://www.baidu.com")

        //      .and()
        //      .withClient("wx")
        //      .secret(passwordEncoder.encode("wx-secret"))
        //      .scopes("readOnly")
        //      .authorizedGrantTypes("implicit") //????????????
        //      .accessTokenValiditySeconds(7200)
        //      .redirectUris("https://www.baidu.com")

        //      .and()
        //      .withClient("qq")
        //      .secret(passwordEncoder.encode("qq-secret"))
        //      .scopes("all")
        //      .authorizedGrantTypes("password") //??????????????????
        //      .accessTokenValiditySeconds(7200)
        //      .redirectUris("https://www.baidu.com")

        //      .and()
        //      .withClient("client")
        //      .secret(passwordEncoder.encode("client-secret"))
        //      .scopes("readOnly")
        //      .authorizedGrantTypes("client_credentials") //??????????????????
        //      .accessTokenValiditySeconds(3600)
        //      .redirectUris("https://www.baidu.com");

        clients.withClientDetails(clientDetailsService());
    }

    @Override
    public void configure(AuthorizationServerSecurityConfigurer security) {
        // ????????? BreezeClientCredentialsTokenEndpointFilter????????????????????????id????????????????????????
        BreezeClientCredentialsTokenEndpointFilter endpointFilter
                = new BreezeClientCredentialsTokenEndpointFilter(security, clientCredentialsTokenEndpointFilter);
        endpointFilter.afterPropertiesSet();
        security.addTokenEndpointAuthenticationFilter(endpointFilter);

        security
                .authenticationEntryPoint(clientCredentialsTokenEndpointFilter)
                // ??????/oauth/token_key??????????????????????????????
                .tokenKeyAccess("isAuthenticated()")
                //  ??????/oauth/check_token??????????????????????????????
                .checkTokenAccess("permitAll()");
    }

    /**
     * ???????????????????????????????????????
     *
     * @param endpoints
     */
    @Override
    public void configure(AuthorizationServerEndpointsConfigurer endpoints) {
        TokenGranter tokenGranter = endpoints.getTokenGranter();
        List<TokenGranter> granterList = Lists.newArrayList(tokenGranter);
        BreezeSmsCodeTokenGranter smsCodeTokenGranter = new BreezeSmsCodeTokenGranter(authenticationManagerBean,
                breezeTokenService, clientDetailsService(), new DefaultOAuth2RequestFactory(clientDetailsService()));
        granterList.add(smsCodeTokenGranter);
        CompositeTokenGranter compositeTokenGranter = new CompositeTokenGranter(granterList);
        endpoints
                // ????????????
                .allowedTokenEndpointRequestMethods(HttpMethod.POST)
                // ??????token????????????
                .tokenStore(redisTokenStore)
                .tokenEnhancer(breezeTokenEnhancer)
                // ????????????????????????
                .userDetailsService(breezeUserDetailsService)
                // ?????????????????????
                .authenticationManager(authenticationManagerBean)
                .tokenGranter(compositeTokenGranter)
                // ?????????????????? refresh_token
                .reuseRefreshTokens(Boolean.FALSE)
                .exceptionTranslator(new BreezeOauthServerWebResponseExceptionTranslator())
        ;
    }

}
