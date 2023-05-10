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

import cn.hutool.json.JSONUtil;
import com.breeze.cloud.auth.authentication.constants.CustomAuthorizationGrantType;
import com.breeze.cloud.auth.authentication.utils.OAuth2EndpointUtils;
import com.breeze.cloud.core.utils.Utils;
import com.breeze.cloud.system.client.SysRegisterClientFeign;
import com.breeze.cloud.system.domain.SysRegisteredClient;
import com.fasterxml.jackson.databind.Module;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.jackson2.SecurityJackson2Modules;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.security.oauth2.core.ClientAuthenticationMethod;
import org.springframework.security.oauth2.core.OAuth2ErrorCodes;
import org.springframework.security.oauth2.core.endpoint.OAuth2ParameterNames;
import org.springframework.security.oauth2.core.oidc.OidcScopes;
import org.springframework.security.oauth2.jose.jws.SignatureAlgorithm;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClient;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClientRepository;
import org.springframework.security.oauth2.server.authorization.jackson2.OAuth2AuthorizationServerJackson2Module;
import org.springframework.security.oauth2.server.authorization.settings.ClientSettings;
import org.springframework.security.oauth2.server.authorization.settings.OAuth2TokenFormat;
import org.springframework.security.oauth2.server.authorization.settings.TokenSettings;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.springframework.security.oauth2.core.AuthorizationGrantType.*;
import static org.springframework.security.oauth2.core.ClientAuthenticationMethod.*;
import static org.springframework.security.oauth2.jose.jws.SignatureAlgorithm.*;
import static org.springframework.security.oauth2.server.authorization.settings.ConfigurationSettingNames.Client.TOKEN_ENDPOINT_AUTHENTICATION_SIGNING_ALGORITHM;
import static org.springframework.security.oauth2.server.authorization.settings.ConfigurationSettingNames.Token.*;
import static org.springframework.security.oauth2.server.authorization.settings.OAuth2TokenFormat.SELF_CONTAINED;

/**
 * 重写auth注册客户端库
 *
 * @author gaoweixuan
 * @date 2023/05/09
 */
@Slf4j
public class RemoteRegisterClientService implements RegisteredClientRepository {

    /**
     * 密码编码器
     */
    private final PasswordEncoder passwordEncoder;

    /**
     * 注册客户端装
     */
    private final SysRegisterClientFeign registerClientFeign;

    /**
     * 工具
     */
    Utils<Map<String, Object>> utils = new Utils<>(new ObjectMapper());

    Utils<Map<String, Object>> mapper = new Utils<>(new ObjectMapper());

    /**
     * 构造方法  身份验证注册客户服务
     *
     * @param passwordEncoder     密码编码器
     * @param registerClientFeign 注册客户端装
     */
    public RemoteRegisterClientService(PasswordEncoder passwordEncoder, SysRegisterClientFeign registerClientFeign) {
        this.passwordEncoder = passwordEncoder;
        this.registerClientFeign = registerClientFeign;
        ClassLoader classLoader = RemoteRegisterClientService.class.getClassLoader();
        List<Module> securityModules = SecurityJackson2Modules.getModules(classLoader);
        utils.register(securityModules);
        utils.register(new OAuth2AuthorizationServerJackson2Module());
    }

    /**
     * 初始化 客户端注册数据，测试使用
     */
    public void init() {
        // @formatter:off
        RegisteredClient registeredClient =
                RegisteredClient.withId("messaging-client")
                        // clientId客户端标识符
                        .clientId("messaging-client")
                        // 名称可不定义
                        .clientName("messaging")
                        //
                        .clientSecretExpiresAt(LocalDateTime.now().plusDays(1).toInstant(ZoneOffset.UTC))
                        // clientSecret客户端密钥
                        .clientSecret("{bcrypt}" + passwordEncoder.encode("secret"))
                        // clientAuthenticationMethod 客户端使用的身份验证方法
                        // params: [client_secret_basic, client_secret_post, private_key_jwt, client_secret_jwt, none]
                        .clientAuthenticationMethod(CLIENT_SECRET_POST)
                        .clientAuthenticationMethod(CLIENT_SECRET_BASIC)
                        // authorizationGrantType 客户端可以使用的授权类型
                        // params: [authorization_code, client_credentials, refresh_token, sms_code, password]
                        .authorizationGrantType(CustomAuthorizationGrantType.SMS_CODE)
                        .authorizationGrantType(PASSWORD)
                        .authorizationGrantType(AUTHORIZATION_CODE)
                        .authorizationGrantType(REFRESH_TOKEN)
                        .authorizationGrantType(CLIENT_CREDENTIALS)
                        // redirectUri客户端已注册重定向的URI，不在此列将被拒绝，使用IP或者域名，不能使用localhost
                        .redirectUri("http://127.0.0.1:8080/login/oauth2/code/messaging-client-oidc")
                        .redirectUri("http://127.0.0.1:8080/authorized")
                        .redirectUri("http://www.baidu.com")
                        // scope允许客户端请求的范围
                        // 开启支持OIDC
                        .scope(OidcScopes.OPENID)
                        .scope(OidcScopes.PROFILE)
                        .scope("message.read")
                        .scope("message.write")
                        // clientSetting 客户端自定义设置，包括验证密钥或者是否需要授权页面
                        .clientSettings(ClientSettings.builder()
                                .requireAuthorizationConsent(true)
                                .requireProofKey(false)
                                .tokenEndpointAuthenticationSigningAlgorithm(RS256)
                                .build())

                        // tokenSetting发布给客户端的 OAuth2 令牌的自定义设置
                        .tokenSettings(TokenSettings.builder()
                                .idTokenSignatureAlgorithm(RS256)
                                // 是否可重用刷新令牌
                                .accessTokenTimeToLive(Duration.ofSeconds(30 * 60))
                                // refreshToken 的有效期
                                .refreshTokenTimeToLive(Duration.ofSeconds(60 * 60))
                                // 是否可重用刷新令牌
                                .reuseRefreshTokens(true)
                                .build())
                        .build();


        RegisteredClient registeredClientPkce = RegisteredClient.withId("pkce-client").clientId("pkce-client")
                //客户端认证模式为none
                .clientAuthenticationMethod(NONE)
                .authorizationGrantType(AUTHORIZATION_CODE)
                .redirectUri("http://127.0.0.1:8070/login/oauth2/code/messaging-client-pkce")
                .redirectUri("http://www.baidu.com")
                .scope("message.read")
                .clientSettings(ClientSettings.builder()
                        .requireAuthorizationConsent(true)
                        //仅支持PKCE
                        .requireProofKey(true)
                        .build())
                .tokenSettings(TokenSettings.builder()
                        // 生成JWT令牌
                        .accessTokenFormat(SELF_CONTAINED)
                        .idTokenSignatureAlgorithm(RS256)
                        .accessTokenTimeToLive(Duration.ofSeconds(30 * 60))
                        .refreshTokenTimeToLive(Duration.ofSeconds(60 * 60))
                        .reuseRefreshTokens(true)
                        .build())
                .build();
        // @formatter:on
        log.info(JSONUtil.toJsonStr(registeredClient));
        log.info(JSONUtil.toJsonStr(registeredClientPkce));
    }

    /**
     * 保存
     *
     * @param registeredClient 注册客户端
     */
    @Override
    public void save(RegisteredClient registeredClient) {
    }

    /**
     * 获取客户端通过id
     *
     * @param id id
     * @return {@link RegisteredClient}
     */
    @Override
    public RegisteredClient findById(String id) {
        SysRegisteredClient registeredClient = registerClientFeign.getById(id);
        return convertRegisteredClient(registeredClient);
    }

    /**
     * 获取客户端由客户端id
     *
     * @param clientId 客户端id
     * @return {@link RegisteredClient}
     */
    @Override
    public RegisteredClient findByClientId(String clientId) {
        SysRegisteredClient registeredClient = registerClientFeign.getByClientId(clientId);
        return convertRegisteredClient(registeredClient);
    }

    private RegisteredClient convertRegisteredClient(SysRegisteredClient registeredClient) {
        // @formatter:off
        Optional.ofNullable(registeredClient).orElseThrow(() ->
                OAuth2EndpointUtils.newError(OAuth2ErrorCodes.INVALID_CLIENT,
                        OAuth2ParameterNames.CLIENT_ID,
                        OAuth2EndpointUtils.ACCESS_TOKEN_REQUEST_ERROR_URI));

        RegisteredClient.Builder build = RegisteredClient.withId(registeredClient.getId())
                // clientId客户端标识符
                .clientId(registeredClient.getClientId())
                // 名称可不定义
                .clientName(registeredClient.getClientName())
                .clientIdIssuedAt(registeredClient.getClientIdIssuedAt().toInstant(ZoneOffset.UTC))
                .clientSecretExpiresAt(registeredClient.getClientSecretExpiresAt().toInstant(ZoneOffset.UTC))
                // clientSecret客户端密钥
                .clientSecret(registeredClient.getClientSecret())
                // clientAuthenticationMethod 客户端使用的身份验证方法
                // params: [client_secret_basic, client_secret_post, private_key_jwt, client_secret_jwt, none]
                .clientAuthenticationMethods((authenticationMethods) ->
                        Arrays.asList(registeredClient.getClientAuthenticationMethods().split(","))
                                .forEach(authenticationMethod -> authenticationMethods.add(resolveClientAuthenticationMethod(authenticationMethod)))
                )

                // authorizationGrantType 客户端可以使用的授权类型
                // params: [authorization_code, client_credentials, refresh_token, sms_code, password]
                .authorizationGrantTypes((grantTypes) ->
                        Arrays.asList(registeredClient.getAuthorizationGrantTypes().split(","))
                                .forEach(grantType -> grantTypes.add(resolveAuthorizationGrantType(grantType))))

                // redirectUri客户端已注册重定向的URI，不在此列将被拒绝，使用IP或者域名，不能使用localhost
                .redirectUris((uris) -> uris.addAll(Arrays.asList(registeredClient.getRedirectUris().split(","))))
                // scope允许客户端请求的范围
                .scopes((scopes) -> scopes.addAll(Arrays.asList(registeredClient.getScopes().split(","))));

        // clientSetting 客户端自定义设置，包括验证密钥或者是否需要授权页面
        Map<String, Object> clientSettingsMap = mapper.parse(registeredClient.getClientSettings());

        Optional.ofNullable(clientSettingsMap.get(TOKEN_ENDPOINT_AUTHENTICATION_SIGNING_ALGORITHM))
                .map(signatureAlgorithm -> this.convertSignatureAlgorithm(clientSettingsMap, signatureAlgorithm))
                .orElseGet(() -> this.convertSignatureAlgorithm(clientSettingsMap, RS256));

        build.clientSettings(ClientSettings.withSettings(clientSettingsMap).build());

        // tokenSetting发布给客户端的 OAuth2 令牌的自定义设置
        Map<String, Object> tokenSettingsMap = mapper.parse(registeredClient.getTokenSettings());

        Optional.ofNullable(tokenSettingsMap.get(ACCESS_TOKEN_TIME_TO_LIVE))
                .map(time -> this.putValue(tokenSettingsMap, ACCESS_TOKEN_TIME_TO_LIVE, time))
                .orElseGet(() -> this.putValue(tokenSettingsMap, ACCESS_TOKEN_TIME_TO_LIVE, 20 * 60));

        Optional.ofNullable(tokenSettingsMap.get(REFRESH_TOKEN_TIME_TO_LIVE))
                .map(time -> this.putValue(tokenSettingsMap, REFRESH_TOKEN_TIME_TO_LIVE, time))
                .orElseGet(() -> this.putValue(tokenSettingsMap, REFRESH_TOKEN_TIME_TO_LIVE, 20 * 60));

        Optional.ofNullable(tokenSettingsMap.get(AUTHORIZATION_CODE_TIME_TO_LIVE))
                .map(time -> this.putValue(tokenSettingsMap, AUTHORIZATION_CODE_TIME_TO_LIVE, time))
                .orElseGet(() -> this.putValue(tokenSettingsMap, AUTHORIZATION_CODE_TIME_TO_LIVE, 10 * 60));

        Optional.ofNullable(tokenSettingsMap.get(ACCESS_TOKEN_FORMAT))
                .map(accessTokenFormat -> this.putValue(tokenSettingsMap, ACCESS_TOKEN_FORMAT, accessTokenFormat))
                .orElseGet(() -> this.putValue(tokenSettingsMap, ACCESS_TOKEN_FORMAT, SELF_CONTAINED));

        Optional.ofNullable(tokenSettingsMap.get(ID_TOKEN_SIGNATURE_ALGORITHM))
                .map(signatureAlgorithm -> this.convertSignatureAlgorithm(tokenSettingsMap, signatureAlgorithm))
                .orElseGet(() -> this.convertSignatureAlgorithm(tokenSettingsMap, RS256));
        // @formatter:on

        build.tokenSettings(TokenSettings.withSettings(tokenSettingsMap).build());
        RegisteredClient client = build.build();
        log.info(JSONUtil.toJsonStr(client));
        return client;
    }

    private SignatureAlgorithm convertSignatureAlgorithm(Map<String, Object> tokenSettingsMap, Object signatureAlgorithm) {
        if (signatureAlgorithm instanceof SignatureAlgorithm) {
            return (SignatureAlgorithm) signatureAlgorithm;
        } else if (RS256.getName().equals(signatureAlgorithm)) {
            tokenSettingsMap.put(ID_TOKEN_SIGNATURE_ALGORITHM, RS256);
            return RS256;
        } else if (RS512.getName().equals(signatureAlgorithm)) {
            tokenSettingsMap.put(ID_TOKEN_SIGNATURE_ALGORITHM, RS256);
            return RS512;
        } else if (RS384.getName().equals(signatureAlgorithm)) {
            tokenSettingsMap.put(ID_TOKEN_SIGNATURE_ALGORITHM, RS256);
            return RS384;
        } else if (ES256.getName().equals(signatureAlgorithm)) {
            tokenSettingsMap.put(ID_TOKEN_SIGNATURE_ALGORITHM, RS256);
            return ES256;
        } else if (ES512.getName().equals(signatureAlgorithm)) {
            tokenSettingsMap.put(ID_TOKEN_SIGNATURE_ALGORITHM, RS256);
            return ES512;
        } else if (ES384.getName().equals(signatureAlgorithm)) {
            tokenSettingsMap.put(ID_TOKEN_SIGNATURE_ALGORITHM, RS256);
            return ES384;
        } else if (PS256.getName().equals(signatureAlgorithm)) {
            tokenSettingsMap.put(ID_TOKEN_SIGNATURE_ALGORITHM, RS256);
            return PS256;
        } else if (PS512.getName().equals(signatureAlgorithm)) {
            tokenSettingsMap.put(ID_TOKEN_SIGNATURE_ALGORITHM, RS256);
            return PS512;
        } else if (PS384.getName().equals(signatureAlgorithm)) {
            tokenSettingsMap.put(ID_TOKEN_SIGNATURE_ALGORITHM, RS256);
            return PS384;
        }
        return RS256;
        // Custom client signature algorithm
    }

    private Object putValue(Map<String, Object> tokenSettingsMap, String key, Object value) {
        if (value instanceof Integer) {
            return tokenSettingsMap.put(key, Duration.ofHours((Integer) value));
        } else if (value instanceof String) {
            return tokenSettingsMap.put(key, new OAuth2TokenFormat((String) value));
        } else if (value instanceof OAuth2TokenFormat) {
            return tokenSettingsMap.put(key, value);
        }else if (value instanceof Duration) {
            return tokenSettingsMap.put(key, value);
        }
        return tokenSettingsMap;
    }

    /**
     * 获得注册客户端
     *
     * @param registeredClient 注册客户端
     * @return {@link RegisteredClient}
     */
    @Deprecated
    private RegisteredClient getRegisteredClient(SysRegisteredClient registeredClient) {
        // @formatter:off
        Optional.ofNullable(registeredClient).orElseThrow(() ->
                OAuth2EndpointUtils.newError(OAuth2ErrorCodes.INVALID_CLIENT,
                OAuth2ParameterNames.CLIENT_ID,
                OAuth2EndpointUtils.ACCESS_TOKEN_REQUEST_ERROR_URI));
        RegisteredClient.Builder build = RegisteredClient.withId(registeredClient.getId())
                // clientId客户端标识符
                .clientId(registeredClient.getClientId())
                // 名称可不定义
                .clientName(registeredClient.getClientName())
                //
                .clientIdIssuedAt(registeredClient.getClientIdIssuedAt().toInstant(ZoneOffset.UTC))
                .clientSecretExpiresAt(registeredClient.getClientSecretExpiresAt().toInstant(ZoneOffset.UTC))
                // clientSecret客户端密钥
                .clientSecret(registeredClient.getClientSecret())
                // clientAuthenticationMethod 客户端使用的身份验证方法
                // params: [client_secret_basic, client_secret_post, private_key_jwt, client_secret_jwt, none]
                .clientAuthenticationMethods((authenticationMethods) ->
                        Arrays.asList(registeredClient.getClientAuthenticationMethods().split(","))
                        .forEach(authenticationMethod -> authenticationMethods.add(resolveClientAuthenticationMethod(authenticationMethod)))
                )

                // authorizationGrantType 客户端可以使用的授权类型
                // params: [authorization_code, client_credentials, refresh_token, sms_code, password]
                .authorizationGrantTypes((grantTypes) ->
                        Arrays.asList(registeredClient.getAuthorizationGrantTypes().split(","))
                                .forEach(grantType -> grantTypes.add(resolveAuthorizationGrantType(grantType))))

                // redirectUri客户端已注册重定向的URI，不在此列将被拒绝，使用IP或者域名，不能使用localhost
                .redirectUris((uris) -> uris.addAll(Arrays.asList(registeredClient.getRedirectUris().split(","))))
                // scope允许客户端请求的范围
                .scopes((scopes) -> scopes.addAll(Arrays.asList(registeredClient.getScopes().split(","))));
        // @formatter:on

        // clientSetting 客户端自定义设置，包括验证密钥或者是否需要授权页面
        Map<String, Object> clientSettingsMap = utils.parse(registeredClient.getClientSettings());
        build.clientSettings(ClientSettings.withSettings(clientSettingsMap).build());

        // tokenSetting发布给客户端的 OAuth2 令牌的自定义设置
        Map<String, Object> tokenSettingsMap = utils.parse(registeredClient.getTokenSettings());
        TokenSettings.Builder tokenSettingsBuilder = TokenSettings.withSettings(tokenSettingsMap);
        if (!tokenSettingsMap.containsKey(ACCESS_TOKEN_FORMAT)) {
            tokenSettingsBuilder.accessTokenFormat(SELF_CONTAINED);
        }
        build.tokenSettings(tokenSettingsBuilder.build());
        RegisteredClient client = build.build();
        log.info(JSONUtil.toJsonStr(client));
        return client;
    }

    /**
     * 解决授权授予类型
     *
     * @param authorizationGrantType 授权批准类型
     * @return {@link AuthorizationGrantType}
     */
    private static AuthorizationGrantType resolveAuthorizationGrantType(String authorizationGrantType) {
        if (AUTHORIZATION_CODE.getValue().equals(authorizationGrantType)) {
            return AUTHORIZATION_CODE;
        } else if (CLIENT_CREDENTIALS.getValue().equals(authorizationGrantType)) {
            return CLIENT_CREDENTIALS;
        } else if (REFRESH_TOKEN.getValue().equals(authorizationGrantType)) {
            return REFRESH_TOKEN;
        }
        return new AuthorizationGrantType(authorizationGrantType);        // Custom authorization grant type
    }

    /**
     * 解决客户端身份验证方法
     *
     * @param clientAuthenticationMethod 客户端身份验证方法
     * @return {@link ClientAuthenticationMethod}
     */
    private static ClientAuthenticationMethod resolveClientAuthenticationMethod(String clientAuthenticationMethod) {
        if (CLIENT_SECRET_BASIC.getValue().equals(clientAuthenticationMethod)) {
            return CLIENT_SECRET_BASIC;
        } else if (CLIENT_SECRET_POST.getValue().equals(clientAuthenticationMethod)) {
            return CLIENT_SECRET_POST;
        } else if (NONE.getValue().equals(clientAuthenticationMethod)) {
            return NONE;
        }
        return new ClientAuthenticationMethod(clientAuthenticationMethod);        // Custom client authentication method
    }


}
