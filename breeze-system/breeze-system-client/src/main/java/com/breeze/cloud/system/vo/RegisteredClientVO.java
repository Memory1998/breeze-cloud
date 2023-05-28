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

package com.breeze.cloud.system.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import java.time.LocalDateTime;
import java.util.Set;

/**
 * 注册客户端实体类
 *
 * @author gaoweixuan
 * @date 2023/05/08
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Schema(description = "注册客户端实体")
public class RegisteredClientVO {

    /**
     * 客户机id
     */
    private String clientId;

    /**
     * 客户id发布时间
     */
    private LocalDateTime clientIdIssuedAt;

    /**
     * 客户秘密
     */
    private String clientSecret;

    /**
     * 客户秘密到期时间
     */
    private LocalDateTime clientSecretExpiresAt;

    /**
     * 客户端名称
     */
    private String clientName;

    /**
     * 客户端身份验证方法
     */
    private Set<String> clientAuthenticationMethods;

    /**
     * 授权批准类型
     */
    private Set<String> authorizationGrantTypes;

    /**
     * 重定向uri
     */
    private Set<String> redirectUris;

    /**
     * 作用域
     */
    private Set<String> scopes;

    /**
     * 客户端设置
     */
    private ClientSettingsVO clientSettings;

    /**
     * 令牌设置
     */
    private TokenSettingsVO tokenSettings;

    /**
     * 客户端身份验证方法
     */
    @JsonIgnore
    private String strClientAuthenticationMethods;

    /**
     * 授权批准类型
     */
    @JsonIgnore
    private String strAuthorizationGrantTypes;

    /**
     * 重定向uri
     */
    @JsonIgnore
    private String strRedirectUris;

    /**
     * 作用域
     */
    @JsonIgnore
    private String strScopes;

    /**
     * 客户端设置
     */
    @JsonIgnore
    private String jsonClientSettings;

    /**
     * 令牌设置
     */
    @JsonIgnore
    private String jsonTokenSettings;

}
