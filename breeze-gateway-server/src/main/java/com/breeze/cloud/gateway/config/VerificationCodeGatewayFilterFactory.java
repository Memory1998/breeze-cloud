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

package com.breeze.cloud.gateway.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;

import java.net.URI;
import java.util.Objects;

/**
 * 拦截 验证码验证等
 *
 * @author breeze
 * @date 2022-02-09
 */
@Slf4j
@Component
public class VerificationCodeGatewayFilterFactory extends AbstractGatewayFilterFactory {

    @Override
    public GatewayFilter apply(Object config) {
        // 返回Gateway对象
        return (exchange, chain) -> {
            MultiValueMap<String, String> queryParams = exchange.getRequest().getQueryParams();
            //获取参数
            log.info("{}", queryParams.toSingleValueMap());

            //获取URI
            URI newUri = exchange.getRequest().getURI();
            String rawPath = newUri.getRawPath();
            log.info("{}", rawPath);

            if (!Objects.equals("/oauth/token", rawPath) || !Objects.equals("/oauth/sms", rawPath)) {
                return chain.filter(exchange);
            }

            if (Objects.equals("/oauth/token", rawPath) && Objects.equals("refresh_token", queryParams.get("grant_type"))) {
                return chain.filter(exchange);
            }
            // todo yanzhangma
            return chain.filter(exchange);
        };
    }
}
