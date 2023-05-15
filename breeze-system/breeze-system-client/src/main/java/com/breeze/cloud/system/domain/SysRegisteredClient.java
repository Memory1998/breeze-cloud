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

package com.breeze.cloud.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonAlias;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.time.LocalDateTime;

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
@TableName("sys_registered_client")
@Schema(description = "注册客户端实体")
public class SysRegisteredClient implements Serializable {

    @TableId(type = IdType.ASSIGN_ID)
    private String id;

    /**
     * 客户机id
     */
    private String clientId;

    /**
     * 客户id发布时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime clientIdIssuedAt;

    /**
     * 客户秘密
     */
    private String clientSecret;

    /**
     * 客户秘密到期时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime clientSecretExpiresAt;

    /**
     * 客户端名称
     */
    private String clientName;

    /**
     * 客户端身份验证方法
     */
    private String clientAuthenticationMethods;

    /**
     * 授权批准类型
     */
    private String authorizationGrantTypes;

    /**
     * 重定向uri
     */
    private String redirectUris;

    /**
     * 作用域
     */
    private String scopes;

    /**
     * 客户端设置
     */
    private String jsonClientSettings;

    /**
     * 令牌设置
     */
    private String jsonTokenSettings;

    // ===================================回显========================================
    /**
     * 标识牌签名算法
     */
    @JsonAlias({"settings.token.id-token-signature-algorithm", "idTokenSignatureAlgorithm"}) // 反序列化的别名
    @TableField(exist = false)
    private String idTokenSignatureAlgorithm;
    /**
     * 访问令牌格式
     */
    @JsonAlias({"settings.token.access-token-format", "accessTokenFormat"})
    @TableField(exist = false)
    private String accessTokenFormat;
    /**
     * 授权代码时间
     */
    @JsonAlias({"settings.token.authorization-code-time-to-live", "authorizationCodeTimeToLive"})
    @TableField(exist = false)
    private Integer authorizationCodeTimeToLive;
    /**
     * 访问令牌时间有效时间
     */
    @JsonAlias({"settings.token.access-token-time-to-live", "accessTokenTimeToLive"})
    @TableField(exist = false)
    private Integer accessTokenTimeToLive;
    /**
     * 刷新令牌有效时间
     */
    @JsonAlias({"settings.token.refresh-token-time-to-live", "refreshTokenTimeToLive"})
    @TableField(exist = false)
    private Integer refreshTokenTimeToLive;
    /**
     * 是否使用刷新令牌
     */
    @TableField(exist = false)
    @JsonAlias({"settings.token.reuse-refresh-tokens", "reuseRefreshTokens"})
    private Boolean reuseRefreshTokens;

    /**
     * 开启PKCE
     */
    @JsonAlias({"settings.client.require-proof-key", "requireProofKey"})
    @TableField(exist = false)
    private Boolean requireProofKey;
    /**
     * 是否需要授权同意
     */
    @JsonAlias({"settings.client.require-authorization-consent", "requireAuthorizationConsent"})
    @TableField(exist = false)
    private Boolean requireAuthorizationConsent;
    /**
     * jwk设置url
     */
    @JsonAlias({"settings.client.jwk-set-url", "jwkSetUrl"})
    @TableField(exist = false)
    private String jwkSetUrl;
    /**
     * 令牌端点认证签名算法
     */
    @JsonAlias({"settings.client.token-endpoint-authentication-signing-algorithm", "tokenEndpointAuthenticationSigningAlgorithm"})
    @TableField(exist = false)
    private String tokenEndpointAuthenticationSigningAlgorithm;

}
