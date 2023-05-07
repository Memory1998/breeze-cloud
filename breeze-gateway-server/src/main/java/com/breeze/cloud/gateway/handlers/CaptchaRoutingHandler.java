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

package com.breeze.cloud.gateway.handlers;

import com.anji.captcha.controller.CaptchaController;
import com.anji.captcha.model.common.ResponseModel;
import com.anji.captcha.model.vo.CaptchaVO;
import com.anji.captcha.service.CaptchaService;
import com.anji.captcha.util.StringUtils;
import com.breeze.cloud.core.enums.ResultCode;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.gateway.exception.ParamsNotFoundException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.*;
import reactor.core.publisher.Mono;

import java.util.Objects;
import java.util.Optional;

import static com.breeze.cloud.core.enums.ResultCode.HTTP_MESSAGE_CONVERSION_EXCEPTION;

/**
 * 路由处理器
 *
 * @author gaoweixuan
 * @date 2022-02-07
 */
@Slf4j
@Configuration
@AllArgsConstructor
public class CaptchaRoutingHandler {

    /**
     * 对象映射器
     */
    private final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * 验证码服务
     */
    private final CaptchaService captchaService;

    /**
     * 获取 remote id
     *
     * @param request 请求
     * @return {@link String}
     */
    public static String getRemoteId(ServerRequest request) {
        Optional<String> xfwd = request.queryParam("X-Forwarded-For");
        String ip = getRemoteIpFromXfwd(xfwd.orElse(""));
        Optional<String> ua = request.queryParam("user-agent");
        return StringUtils.isNotBlank(ip) ? ip + ua : request.remoteAddress().get().getHostString() + ua.orElse("");
    }

    /**
     * 从xfwd获得远程ip
     *
     * @param xfwd xfwd
     * @return {@link String}
     */
    private static String getRemoteIpFromXfwd(String xfwd) {
        if (StringUtils.isNotBlank(xfwd)) {
            String[] ipList = xfwd.split(",");
            return StringUtils.trim(ipList[0]);
        } else {
            return null;
        }
    }

    /**
     * 重写验证码请求
     *
     * <p>
     * 参考: {@link CaptchaController}
     * </p>
     *
     * @return {@link RouterFunction}
     */
    @Bean
    public RouterFunction routerFunction() {
        return RouterFunctions
                .route(RequestPredicates.path("/captcha/getCode").and(RequestPredicates.accept(MediaType.APPLICATION_JSON)),
                        request -> {
                            log.info("[获取验证码], {}", request.queryParams());
                            CaptchaVO captchaVO = new CaptchaVO();
                            // 滑块
                            captchaVO.setCaptchaType("blockPuzzle");
                            captchaVO.setBrowserInfo(getRemoteId(request));
                            return getServerResponseMono(captchaService.get(captchaVO));
                        })
                .andRoute(RequestPredicates.path("/captcha/checkCode").and(RequestPredicates.accept(MediaType.APPLICATION_JSON)),
                        request -> {
                            log.info("[校验验证码] ");
                            CaptchaVO vo = new CaptchaVO();
                            vo.setPointJson(request.queryParam("pointJson").orElseThrow(
                                    () -> new ParamsNotFoundException(HTTP_MESSAGE_CONVERSION_EXCEPTION)
                            ));
                            vo.setToken(request.queryParam("token").orElseThrow(
                                    () -> new ParamsNotFoundException(HTTP_MESSAGE_CONVERSION_EXCEPTION)
                            ));
                            vo.setBrowserInfo(getRemoteId(request));
                            vo.setCaptchaType("blockPuzzle");
                            return getServerResponseMono(captchaService.check(vo));
                        });
    }

    /**
     * 获取服务器响应mono
     *
     * @param responseModel 响应模型
     * @return {@link Mono}<{@link ServerResponse}>
     */
    private Mono<ServerResponse> getServerResponseMono(ResponseModel responseModel) {
        ServerResponse.BodyBuilder bodyBuilder = ServerResponse
                .status(HttpStatus.OK)
                .contentType(MediaType.APPLICATION_JSON);
        String result = "";
        try {
            result = objectMapper.writeValueAsString(Result.fail(ResultCode.FAIL.getMsg()));
            if (Objects.nonNull(responseModel) && responseModel.isSuccess()) {
                return bodyBuilder.body(BodyInserters.fromValue(objectMapper.writeValueAsString(responseModel)));
            }
        } catch (Exception e) {
            log.error("[验证码异常] {}", e);
            e.printStackTrace();
            return bodyBuilder.body(BodyInserters.fromValue(result));
        }
        return bodyBuilder.body(BodyInserters.fromValue(result));
    }

}
