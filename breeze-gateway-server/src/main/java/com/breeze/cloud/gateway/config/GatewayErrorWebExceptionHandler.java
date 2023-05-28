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

package com.breeze.cloud.gateway.config;

import com.breeze.cloud.core.utils.Result;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.web.reactive.error.ErrorWebExceptionHandler;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.core.io.buffer.DataBufferFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

/**
 * 网关错误网络异常处理程序
 *
 * @author gaoweixuan
 * @date 2023/05/28
 */
@Slf4j
@Component
public class GatewayErrorWebExceptionHandler implements ErrorWebExceptionHandler {
    private final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 处理
     *
     * @param exchange 交换机
     * @param ex       异常
     * @return {@link Mono}<{@link Void}>
     */
    @SneakyThrows
    @Override
    public Mono<Void> handle(ServerWebExchange exchange, Throwable ex) {
        log.error("[网关异常]", ex);
        ServerHttpResponse response = exchange.getResponse();
        response.getHeaders().setContentType(MediaType.APPLICATION_JSON);
        response.setStatusCode(HttpStatus.SERVICE_UNAVAILABLE);
        DataBufferFactory bufferFactory = response.bufferFactory();
        DataBuffer dataBuffer = bufferFactory.wrap(objectMapper.writeValueAsBytes(Result.fail(ex.getMessage())));
        return response.writeWith(Mono.fromSupplier(() -> dataBuffer));
    }

}
