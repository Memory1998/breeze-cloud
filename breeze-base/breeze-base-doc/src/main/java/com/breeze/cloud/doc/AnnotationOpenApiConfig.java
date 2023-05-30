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

package com.breeze.cloud.doc;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeIn;
import io.swagger.v3.oas.annotations.enums.SecuritySchemeType;
import io.swagger.v3.oas.annotations.info.Info;
import io.swagger.v3.oas.annotations.security.*;
import io.swagger.v3.oas.annotations.servers.Server;
import org.springframework.context.annotation.Configuration;

@OpenAPIDefinition(
		info = @Info(
				title = "RBAC管理系统",
				description = "SpringBoot版本",
				version = "v1.0.0"),
		servers = {@Server(url = "http://127.0.0.1:8000")},
		//集成多种认证模式
		security = {
				@SecurityRequirement(name = "OAuth2 Flow", scopes = {"address", "user_info", "openid", "phone", "email", "profile", "read"}),
				@SecurityRequirement(name = "Bearer access_token")
		}
)
@SecurityScheme(name = "OAuth2 Flow",
		type = SecuritySchemeType.OAUTH2,
		flows = @OAuthFlows(authorizationCode = @OAuthFlow(
				authorizationUrl = "${springdoc.oAuthFlow.authorizationUrl}",
				tokenUrl = "${springdoc.oAuthFlow.tokenUrl}",
				scopes = {
						// read address user_info phone profile write email
						@OAuthScope(name = "address", description = "address"),
						@OAuthScope(name = "user_info", description = "user_info"),
						@OAuthScope(name = "openid", description = "openid"),
						@OAuthScope(name = "phone", description = "手机号"),
						@OAuthScope(name = "email", description = "电子邮件"),
						@OAuthScope(name = "profile", description = "用户身份信息"),
						@OAuthScope(name = "read", description = "read scope")
				})
		),
		description = "OAuth2授权码认证 选择 Scopes"
)
@SecurityScheme(
		name = "Bearer access_token",
		type = SecuritySchemeType.HTTP,
		in = SecuritySchemeIn.HEADER,
		scheme = "bearer",
		description = "使用有效access_token [Bearer access_token]"
)
@Configuration
public class AnnotationOpenApiConfig {

}
