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

package com.breeze.cloud.auth.authentication.sms;

import org.springframework.lang.Nullable;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.AuthorizationGrantType;
import org.springframework.util.Assert;

import java.util.*;

/**
 * oauth2资源所有者手机身份验证令牌
 *
 * @author gaoweixuan
 * @date 2023-04-21
 */
public class OAuth2ResourceOwnerSmsAuthenticationToken extends AbstractAuthenticationToken {

    private static final long serialVersionUID = 8343921382678855298L;
    private final AuthorizationGrantType authorizationGrantType;
    private final Authentication clientPrincipal;
    private final Set<String> scopes;
    private final Map<String, Object> additionalParameters;

    /**
     * oauth2资源所有者手机身份验证令牌构造
     *
     * @param clientPrincipal        the authenticated client principal
     * @param authorizationGrantType 授权类型
     * @param scopes                 作用域
     * @param additionalParameters   额外参数
     */
    public OAuth2ResourceOwnerSmsAuthenticationToken(AuthorizationGrantType authorizationGrantType,
                                                     Authentication clientPrincipal,
                                                     @Nullable Set<String> scopes,
                                                     @Nullable Map<String, Object> additionalParameters) {
        super(Collections.emptyList());
        Assert.notNull(authorizationGrantType, "authorizationGrantType cannot be null");
        Assert.notNull(clientPrincipal, "clientPrincipal cannot be null");
        this.authorizationGrantType = authorizationGrantType;
        this.clientPrincipal = clientPrincipal;
        this.scopes = Collections.unmodifiableSet(scopes != null ? new HashSet<>(scopes) : Collections.emptySet());
        this.additionalParameters = Collections.unmodifiableMap(additionalParameters != null ? new HashMap<>(additionalParameters) : Collections.emptyMap());
    }

    /**
     * 获取授权类型[ grant type ]
     *
     * @return {@link AuthorizationGrantType}
     */
    public AuthorizationGrantType getGrantType() {
        return this.authorizationGrantType;
    }

    /**
     * 获取手机
     *
     * @return {@link Object}
     */
    @Override
    public Object getPrincipal() {
        return this.clientPrincipal;
    }

    /**
     * 获得证书
     *
     * @return {@link Object}
     */
    @Override
    public Object getCredentials() {
        return "";
    }

    /**
     * 获取认证范围
     *
     * @return {@link Set}<{@link String}>  如果没有就返回空的set
     */
    public Set<String> getScopes() {
        return this.scopes;
    }

    /**
     * 获取额外参数
     *
     * @return {@link Map}<{@link String}, {@link Object}>
     */
    public Map<String, Object> getAdditionalParameters() {
        return this.additionalParameters;
    }

}
