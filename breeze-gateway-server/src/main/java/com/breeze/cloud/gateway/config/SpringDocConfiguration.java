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
 *
 */

package com.breeze.cloud.gateway.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.ExternalDocumentation;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springdoc.core.AbstractSwaggerUiConfigProperties;
import org.springdoc.core.GroupedOpenApi;
import org.springdoc.core.SwaggerUiConfigProperties;
import org.springframework.cloud.gateway.route.RouteDefinition;
import org.springframework.cloud.gateway.route.RouteDefinitionLocator;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/**
 * spring文档配置
 *
 * @author gaoweixuan
 * @date 2023-04-17
 */
@Configuration
public class SpringDocConfiguration {
    /**
     * 安全名称
     */
    private static final String SECURITY_SCHEME_NAME = "Bearer";
    protected final SwaggerUiConfigProperties swaggerUiConfigProperties;
    protected final RouteDefinitionLocator routeDefinitionLocator;

    public SpringDocConfiguration(SwaggerUiConfigProperties swaggerUiConfigProperties, RouteDefinitionLocator routeDefinitionLocator) {
        this.swaggerUiConfigProperties = swaggerUiConfigProperties;
        this.routeDefinitionLocator = routeDefinitionLocator;
    }

    @Bean
    @Lazy(false)
    public List<GroupedOpenApi> apis() {
        List<GroupedOpenApi> groups = new ArrayList<>();
        List<RouteDefinition> definitions = routeDefinitionLocator.getRouteDefinitions().collectList().block();

        definitions.stream()
                .filter(routeDefinition -> !routeDefinition.getId().contains("auth") && !routeDefinition.getId().contains("openapi"))
                .forEach(routeDefinition -> {
                    String path = routeDefinition.getPredicates().get(0).getArgs().get("_genkey_0")
                            .replace("/**", "").replace("/", "");
                    AbstractSwaggerUiConfigProperties.SwaggerUrl swaggerUrl = new AbstractSwaggerUiConfigProperties.SwaggerUrl(
                            routeDefinition.getId().replace("ReactiveCompositeDiscoveryClient_", "").toLowerCase(),
                            path + "/v3/api-docs",
                            null
                    );
                    Set<AbstractSwaggerUiConfigProperties.SwaggerUrl> urls = swaggerUiConfigProperties.getUrls();
                    if (urls == null) {
                        urls = new LinkedHashSet<>();
                        swaggerUiConfigProperties.setUrls(urls);
                    }
                    urls.add(swaggerUrl);
                });
        return groups;
    }

    @Bean
    public OpenAPI breezeOpenAPI() {
        return new OpenAPI().info(new Info().title("晴风咸蛋小项目 API 文档")
                        .description("晴风咸蛋小项目")
                        .version("v1.0.0")
                        .license(new License().name("Apache 2.0").url("")))
                .externalDocs(new ExternalDocumentation()
                        .description("晴风咸蛋小项目 文档")
                        .url("https://github.com/Memory1998/breeze-boot.git"))
                .components(new Components().addSecuritySchemes(SECURITY_SCHEME_NAME,
                        new SecurityScheme()
                                .name(SECURITY_SCHEME_NAME)
                                .type(SecurityScheme.Type.HTTP)
                                .scheme("Bearer")
                                .bearerFormat("JWT")));
    }

}

