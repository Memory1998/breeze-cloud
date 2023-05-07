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

import cn.hutool.core.util.RandomUtil;
import com.breeze.cloud.auth.authentication.constants.CustomAuthorizationGrantType;
import com.breeze.cloud.auth.authentication.password.OAuth2ResourceOwnerPasswordAuthenticationConverter;
import com.breeze.cloud.auth.authentication.password.OAuth2ResourceOwnerPasswordAuthenticationProvider;
import com.breeze.cloud.auth.authentication.sms.OAuth2ResourceOwnerSmsAuthenticationConverter;
import com.breeze.cloud.auth.authentication.sms.OAuth2ResourceOwnerSmsAuthenticationProvider;
import com.breeze.cloud.auth.authentication.sms.SmsAuthenticationProvider;
import com.breeze.cloud.auth.extend.InRedisOAuth2AuthorizationConsentService;
import com.breeze.cloud.auth.extend.InRedisOAuth2AuthorizationService;
import com.breeze.cloud.auth.jose.Jwks;
import com.breeze.cloud.auth.service.UserPrincipalService;
import com.nimbusds.jose.jwk.JWKSet;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jose.jwk.source.JWKSource;
import com.nimbusds.jose.proc.SecurityContext;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.oauth2.server.resource.OAuth2ResourceServerConfigurer;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;
import org.springframework.security.oauth2.core.OAuth2Token;
import org.springframework.security.oauth2.core.oidc.OidcScopes;
import org.springframework.security.oauth2.jose.jws.SignatureAlgorithm;
import org.springframework.security.oauth2.jwt.JwtClaimsSet;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.server.authorization.OAuth2AuthorizationConsentService;
import org.springframework.security.oauth2.server.authorization.OAuth2AuthorizationService;
import org.springframework.security.oauth2.server.authorization.client.JdbcRegisteredClientRepository;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClient;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClientRepository;
import org.springframework.security.oauth2.server.authorization.config.annotation.web.configuration.OAuth2AuthorizationServerConfiguration;
import org.springframework.security.oauth2.server.authorization.config.annotation.web.configurers.OAuth2AuthorizationServerConfigurer;
import org.springframework.security.oauth2.server.authorization.settings.AuthorizationServerSettings;
import org.springframework.security.oauth2.server.authorization.settings.ClientSettings;
import org.springframework.security.oauth2.server.authorization.settings.OAuth2TokenFormat;
import org.springframework.security.oauth2.server.authorization.settings.TokenSettings;
import org.springframework.security.oauth2.server.authorization.token.JwtEncodingContext;
import org.springframework.security.oauth2.server.authorization.token.OAuth2TokenCustomizer;
import org.springframework.security.oauth2.server.authorization.token.OAuth2TokenGenerator;
import org.springframework.security.oauth2.server.authorization.web.authentication.DelegatingAuthenticationConverter;
import org.springframework.security.oauth2.server.authorization.web.authentication.OAuth2AuthorizationCodeAuthenticationConverter;
import org.springframework.security.oauth2.server.authorization.web.authentication.OAuth2ClientCredentialsAuthenticationConverter;
import org.springframework.security.oauth2.server.authorization.web.authentication.OAuth2RefreshTokenAuthenticationConverter;
import org.springframework.security.web.DefaultSecurityFilterChain;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;
import org.springframework.security.web.util.matcher.RequestMatcher;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 授权服务器配置
 *
 * @author gaoweixuan
 * @date 2023-04-10
 */
@SuppressWarnings("ALL")
@Slf4j
@AllArgsConstructor
@Configuration(proxyBeanMethods = false)
public class AuthorizationServerConfiguration {

    /**
     * 自定义授权页
     */
    private static final String CUSTOM_CONSENT_PAGE_URI = "/oauth2/consent";

    /**
     * 密码编码器
     */
    private final PasswordEncoder passwordEncoder;

    /**
     * 用户详细信息服务
     */
    private final UserPrincipalService userDetailsService;


    private final RedisTemplate<String, String> redisTemplate;

    /**
     * 授权服务器安全过滤器链
     *
     * @param http http
     * @return {@link SecurityFilterChain}
     * @throws Exception 异常
     */
    @Bean
    @Order(Ordered.HIGHEST_PRECEDENCE)
    public SecurityFilterChain authorizationServerSecurityFilterChain(HttpSecurity http) throws Exception {
        OAuth2AuthorizationServerConfigurer authorizationServerConfigurer = new OAuth2AuthorizationServerConfigurer();

        http.apply(authorizationServerConfigurer.tokenEndpoint((tokenEndpoint) -> tokenEndpoint.accessTokenRequestConverter(
                new DelegatingAuthenticationConverter(Arrays.asList(
                        new OAuth2AuthorizationCodeAuthenticationConverter(),
                        new OAuth2RefreshTokenAuthenticationConverter(),
                        new OAuth2ClientCredentialsAuthenticationConverter(),
                        new OAuth2ResourceOwnerPasswordAuthenticationConverter(),
                        new OAuth2ResourceOwnerSmsAuthenticationConverter()))
        )));

        authorizationServerConfigurer
                .authorizationEndpoint(authorizationEndpoint -> authorizationEndpoint.consentPage(CUSTOM_CONSENT_PAGE_URI))
                // Enable OpenID Connect 1.0
                .oidc(Customizer.withDefaults());

        // 可以根据需求对 authorizationServerConfigurer 进行一些个性化配置
        RequestMatcher endpointsMatcher = authorizationServerConfigurer.getEndpointsMatcher();
        DefaultSecurityFilterChain securityFilterChain = http
                // 拦截对授权服务器相关端点的请求
                .requestMatcher(endpointsMatcher)
                // 拦截对授权服务器相关端点的请求
                .authorizeRequests(authorizeRequests ->
                        authorizeRequests.anyRequest().authenticated()
                )
                // 忽略掉相关端点的 CSRF(跨站请求): 对授权端点的访问可以是跨站的
                .csrf(csrf -> csrf.ignoringRequestMatchers(endpointsMatcher))
                .exceptionHandling(exceptions ->
                        exceptions.authenticationEntryPoint(new LoginUrlAuthenticationEntryPoint("/login"))
                )
                .formLogin()
                .and().logout()
                .and().oauth2ResourceServer(OAuth2ResourceServerConfigurer::jwt)
                // 应用授权服务器的配置
                .apply(authorizationServerConfigurer).and().build();

        addCustomOAuth2ResourceOwnerAuthenticationProvider(http);
        return securityFilterChain;
    }

    /**
     * 注册客户端库
     *
     * @param jdbcTemplate jdbc模板
     * @return {@link RegisteredClientRepository}
     */
    @Bean
    public RegisteredClientRepository registeredClientRepository(JdbcTemplate jdbcTemplate) {
        RegisteredClient registeredClient = RegisteredClient
                .withId("messaging-client" + RandomUtil.randomString(6))
                // clientId客户端标识符
                .clientId("messaging-client")
                // 名称可不定义
                .clientName("messaging").clientSecretExpiresAt(LocalDateTime.now().plusDays(1).toInstant(ZoneOffset.UTC))
                // clientSecret客户端密钥
                .clientSecret(passwordEncoder.encode("secret"))
                // clientAuthenticationMethod 客户端使用的身份验证方法
                // params: [client_secret_basic, client_secret_post, private_key_jwt, client_secret_jwt, none]
                .clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_POST)
                .clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC)
                // authorizationGrantType 客户端可以使用的授权类型
                // params: [authorization_code, client_credentials, refresh_token]
                .authorizationGrantType(CustomAuthorizationGrantType.SMS_CODE)
                .authorizationGrantType(AuthorizationGrantType.PASSWORD).authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE).authorizationGrantType(AuthorizationGrantType.REFRESH_TOKEN).authorizationGrantType(AuthorizationGrantType.CLIENT_CREDENTIALS)
                // redirectUri客户端已注册重定向的URI，不在此列将被拒绝，使用IP或者域名，不能使用localhost
                .redirectUri("http://127.0.0.1:8080/login/oauth2/code/messaging-client-oidc")
                .redirectUri("http://127.0.0.1:8080/authorized").redirectUri("http://www.baidu.com")
                // scope允许客户端请求的范围
                // 开启支持OIDC
                .scope(OidcScopes.OPENID).scope(OidcScopes.PROFILE).scope("message.read").scope("message.write")
                // clientSetting 客户端自定义设置，包括验证密钥或者是否需要授权页面
                .clientSettings(ClientSettings.builder()
                        .requireAuthorizationConsent(true)
                        .requireProofKey(false)
                        .tokenEndpointAuthenticationSigningAlgorithm(SignatureAlgorithm.RS256)
                        .build())

                // tokenSetting发布给客户端的 OAuth2 令牌的自定义设置
                .tokenSettings(TokenSettings.builder()
                        .idTokenSignatureAlgorithm(SignatureAlgorithm.RS256)
                        // 是否可重用刷新令牌
                        .accessTokenTimeToLive(Duration.ofSeconds(30 * 60))
                        // refreshToken 的有效期
                        .refreshTokenTimeToLive(Duration.ofSeconds(60 * 60))
                        // 是否可重用刷新令牌
                        .reuseRefreshTokens(true)
                        .build())
                .build();


        RegisteredClient registeredClientPkce = RegisteredClient.withId("pkce-client" + RandomUtil.randomString(6))
                .clientId("pkce-client")
                //客户端认证模式为none
                .clientAuthenticationMethod(ClientAuthenticationMethod.NONE)
                .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
                .redirectUri("http://127.0.0.1:8070/login/oauth2/code/messaging-client-pkce")
                .redirectUri("http://www.baidu.com")
                .scope("message.read")
                .clientSettings(
                        ClientSettings.builder()
                                .requireAuthorizationConsent(true)
                                //仅支持PKCE
                                .requireProofKey(true)
                                .build())
                .tokenSettings(
                        TokenSettings.builder()
                                // 生成JWT令牌
                                .accessTokenFormat(OAuth2TokenFormat.SELF_CONTAINED)
                                .idTokenSignatureAlgorithm(SignatureAlgorithm.RS256)
                                .accessTokenTimeToLive(Duration.ofSeconds(30 * 60))
                                .refreshTokenTimeToLive(Duration.ofSeconds(60 * 60))
                                .reuseRefreshTokens(true)
                                .build())
                .build();


        JdbcRegisteredClientRepository registeredClientRepository = new JdbcRegisteredClientRepository(jdbcTemplate);
        if (null == registeredClientRepository.findByClientId("messaging-client")) {
            registeredClientRepository.save(registeredClient);
        }
        if (null == registeredClientRepository.findByClientId("pkce-client")) {
            registeredClientRepository.save(registeredClientPkce);
        }

        return new JdbcRegisteredClientRepository(jdbcTemplate);
    }

    @Bean
    @SuppressWarnings("unused")
    OAuth2TokenCustomizer<JwtEncodingContext> jwtCustomizer() {
        return context -> {
            JwtClaimsSet.Builder claims = context.getClaims();
            Authentication principal = context.getPrincipal();
            Set<String> authorities = principal.getAuthorities().stream().map(GrantedAuthority::getAuthority).collect(Collectors.toSet());
            claims.claim("clientId", context.getRegisteredClient().getClientId());
            Set<String> authorizedScopes = context.getAuthorizedScopes();
            authorities.addAll(authorizedScopes);
            claims.claim("scope", authorities);
        };
    }

    /**
     * 授权服务
     *
     * @param clientRepository 客户端库
     * @param beanFactory      bean工厂
     * @return {@link OAuth2AuthorizationService}
     */
    @Bean
    public OAuth2AuthorizationService authorizationService(RegisteredClientRepository clientRepository,
                                                           AutowireCapableBeanFactory beanFactory) {
        return new InRedisOAuth2AuthorizationService(redisTemplate, clientRepository, beanFactory);
    }

    /**
     * 授权同意服务
     *
     * @param jdbcTemplate jdbc模板
     * @param beanFactory  bean工厂
     * @return {@link OAuth2AuthorizationConsentService}
     */
    @Bean
    public OAuth2AuthorizationConsentService authorizationConsentService(JdbcTemplate jdbcTemplate,
                                                                         AutowireCapableBeanFactory beanFactory) {
        return new InRedisOAuth2AuthorizationConsentService(redisTemplate, beanFactory);
    }

    /**
     * jwk源
     *
     * @return {@link JWKSource}<{@link SecurityContext}>
     */
    @Bean
    public JWKSource<SecurityContext> jwkSource() {
        RSAKey rsaKey = Jwks.generateRsa();
        JWKSet jwkSet = new JWKSet(rsaKey);
        return (jwkSelector, securityContext) -> jwkSelector.select(jwkSet);
    }

    /**
     * 授权服务器元信息配置，大多数使用默认配置即可，唯一需要配置的只有授权服务器的地址issuer
     *
     * <p>
     * 在生产中这个地方应该配置为域名
     * </p>
     *
     * @return {@link AuthorizationServerSettings}
     */
    @Bean
    public AuthorizationServerSettings authorizationServerSettings() {
        return AuthorizationServerSettings.builder().issuer("http://localhost:8000").build();
    }

    /**
     * jwt译码器
     *
     * @param jwkSource jwk源
     * @return {@link JwtDecoder}
     */
    @Bean
    public JwtDecoder jwtDecoder(JWKSource<SecurityContext> jwkSource) {
        return OAuth2AuthorizationServerConfiguration.jwtDecoder(jwkSource);
    }

    /**
     * 添加自定义oauth2资源所有者密码身份验证提供者
     *
     * @param http http
     */
    @SuppressWarnings("unchecked")
    private void addCustomOAuth2ResourceOwnerAuthenticationProvider(HttpSecurity http) {
        AuthenticationManager authenticationManager = http.getSharedObject(AuthenticationManager.class);
        OAuth2AuthorizationService authorizationService = http.getSharedObject(OAuth2AuthorizationService.class);
        OAuth2TokenGenerator<? extends OAuth2Token> tokenGenerator = http.getSharedObject(OAuth2TokenGenerator.class);

        OAuth2ResourceOwnerPasswordAuthenticationProvider resourceOwnerPasswordAuthenticationProvider = new OAuth2ResourceOwnerPasswordAuthenticationProvider(authenticationManager, authorizationService, tokenGenerator);
        http.authenticationProvider(resourceOwnerPasswordAuthenticationProvider);

        OAuth2ResourceOwnerSmsAuthenticationProvider resourceOwnerSmsAuthenticationProvider = new OAuth2ResourceOwnerSmsAuthenticationProvider(authenticationManager, authorizationService, tokenGenerator);
        http.authenticationProvider(resourceOwnerSmsAuthenticationProvider);
        SmsAuthenticationProvider smsAuthenticationProvider = new SmsAuthenticationProvider(userDetailsService, redisTemplate);
        http.authenticationProvider(smsAuthenticationProvider);
    }

}
