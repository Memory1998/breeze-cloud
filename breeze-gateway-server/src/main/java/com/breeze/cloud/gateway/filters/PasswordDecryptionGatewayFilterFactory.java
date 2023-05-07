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

package com.breeze.cloud.gateway.filters;

import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.MultiValueMap;

import java.net.URI;

/**
 * 密码解密网关过滤工厂
 *
 * <p>
 * 自定义过滤器需在yml文件中进行配置，否则不生效
 * </p>
 *
 * @author gaoweixuan
 * @date 2022-02-09
 */
@Slf4j
@Component
public class PasswordDecryptionGatewayFilterFactory extends AbstractGatewayFilterFactory {

    /**
     * @param config 配置
     * @return {@link GatewayFilter}
     */
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

            // TODO
            return chain.filter(exchange);
        };
    }

}
