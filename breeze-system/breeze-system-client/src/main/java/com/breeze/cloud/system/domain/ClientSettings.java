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

import com.fasterxml.jackson.annotation.JsonAlias;
import lombok.Data;

/**
 * 客户端设置
 *
 * @author gaoweixuan
 * @date 2023/05/15
 */
@Data
public class ClientSettings {
    /**
     * 开启PKCE
     */
    @JsonAlias({"settings.client.require-proof-key", "requireProofKey"})
    private Boolean requireProofKey;
    /**
     * 是否需要授权同意
     */
    @JsonAlias({"settings.client.require-authorization-consent", "requireAuthorizationConsent"})
    private Boolean requireAuthorizationConsent;
    /**
     * jwk设置url
     */
    @JsonAlias({"settings.client.jwk-set-url", "jwkSetUrl"})
    private String jwkSetUrl;
    /**
     * 令牌端点认证签名算法
     */
    @JsonAlias({"settings.client.token-endpoint-authentication-signing-algorithm", "tokenEndpointAuthenticationSigningAlgorithm"})
    private String tokenEndpointAuthenticationSigningAlgorithm;
}
