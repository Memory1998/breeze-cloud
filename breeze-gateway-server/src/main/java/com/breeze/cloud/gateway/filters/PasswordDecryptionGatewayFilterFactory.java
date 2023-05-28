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

import cn.hutool.core.util.StrUtil;
import com.breeze.cloud.core.propertise.AesSecretProperties;
import com.breeze.cloud.core.utils.AesUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.gateway.filter.GatewayFilter;
import org.springframework.cloud.gateway.filter.factory.AbstractGatewayFilterFactory;
import org.springframework.core.style.ToStringCreator;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;
import org.springframework.web.server.ServerWebExchange;
import org.springframework.web.util.UriComponentsBuilder;

import java.net.URI;
import java.util.Arrays;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * 密码解密网关过滤工厂
 *
 * <p>
 * 自定义过滤器 类名以GatewayFilterFactory结尾，继承 AbstractGatewayFilterFactory
 * 并且需在yml文件中进行配置
 * filters:
 * - PasswordDecryption
 * </p>
 *
 * @author gaoweixuan
 * @date 2022-02-09
 */
@SuppressWarnings("ALL")
@Slf4j
@Component
public class PasswordDecryptionGatewayFilterFactory extends AbstractGatewayFilterFactory<PasswordDecryptionGatewayFilterFactory.Config> {

    private final static String PASSWORD = "password";
    private final static String GRANT_TYPE = "grant_type";
    private final static String GRANT_TYPE_KEY = "grantType";
    private final AesSecretProperties aesSecretProperties;

    public PasswordDecryptionGatewayFilterFactory(AesSecretProperties aesSecretProperties) {
        super(PasswordDecryptionGatewayFilterFactory.Config.class);
        this.aesSecretProperties = aesSecretProperties;
    }

    @Override
    public List<String> shortcutFieldOrder() {
        return Arrays.asList(GRANT_TYPE_KEY);
    }

    @Override
    public GatewayFilter apply(Config config) {

        return (exchange, chain) -> {
            String grantType = exchange.getRequest().getQueryParams().getFirst(GRANT_TYPE);
            String paramGrantType = config.getGrantType();
            if (StrUtil.isAllBlank(paramGrantType)) {
                return chain.filter(exchange);
            }
            Set<String> grantTypeSet = Arrays.stream(paramGrantType.split("\\|")).collect(Collectors.toSet());
            if (!CollectionUtils.contains(grantTypeSet.iterator(), grantType)) {
                return chain.filter(exchange);
            }
            ServerWebExchange serverWebExchange = reBuildRequestParam(exchange);
            return chain.filter(serverWebExchange);
        };
    }

    private ServerWebExchange reBuildRequestParam(ServerWebExchange exchange) {
        //获取uri对象
        URI uri = exchange.getRequest().getURI();
        //私钥解密
        String password = exchange.getRequest().getQueryParams().getFirst(PASSWORD);
        String decryptPassword = AesUtil.decryptStr(password, aesSecretProperties.getAesSecret());
        //获取 url上的参数
        String originalQuery = uri.getRawQuery();
        //如果有参数才进行修改
        if (StrUtil.isNotBlank(originalQuery)) {
            URI newUri = UriComponentsBuilder.fromUri(uri).replaceQueryParam(PASSWORD, decryptPassword).build(true).toUri();
            //用新的URI 创建新的 ServerHttpRequest
            ServerHttpRequest request = exchange.getRequest().mutate().uri(newUri).build();
            //返回新构建的 exchange
            return exchange.mutate().request(request).build();

        }
        return exchange;
    }


    public static class Config {

        private String grantType;

        public String getGrantType() {
            return this.grantType;
        }

        public PasswordDecryptionGatewayFilterFactory.Config setGrantType(String grantType) {
            this.grantType = grantType;
            return this;
        }

        @Override
        public String toString() {
            // @formatter:off
                return new ToStringCreator(this)
                        .append("grantType", grantType)
                        .toString();
                // @formatter:on
        }

    }

}
