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

package com.breeze.cloud.auth.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import org.springframework.security.oauth2.server.authorization.util.SpringAuthorizationServerVersion;

import java.io.Serializable;
import java.time.Instant;

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
@TableName("auth_registered_client")
@Schema(description = "注册客户端实体")
public class AuthRegisteredClient implements Serializable {

    private static final long serialVersionUID = SpringAuthorizationServerVersion.SERIAL_VERSION_UID;

    @TableId(type = IdType.ASSIGN_ID)
    private String id;
    private String clientId;
    private Instant clientIdIssuedAt;
    private String clientSecret;
    private Instant clientSecretExpiresAt;
    private String clientName;
    private String clientAuthenticationMethods;
    private String authorizationGrantTypes;
    private String redirectUris;
    private String scopes;
    private String clientSettings;
    private String tokenSettings;

}


