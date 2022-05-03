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

import com.anji.captcha.model.common.ResponseModel;
import com.anji.captcha.model.vo.CaptchaVO;
import com.anji.captcha.service.CaptchaService;
import com.anji.captcha.util.StringUtils;
import com.breeze.cloud.core.Result;
import com.breeze.cloud.core.enums.ResultCode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.*;
import reactor.core.publisher.Mono;

import java.util.Objects;
import java.util.Optional;

/**
 * @author breeze
 * @date 2022-02-07
 */
@Configuration
public class RoutingHandler {

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private CaptchaService captchaService;

    public static final String getRemoteId(ServerRequest request) {
        Optional<String> xfwd = request.queryParam("X-Forwarded-For");
        String ip = getRemoteIpFromXfwd(xfwd.orElse(""));
        Optional<String> ua = request.queryParam("user-agent");
        return StringUtils.isNotBlank(ip) ? ip + ua : request.remoteAddress().get().getHostString() + ua.orElse("");
    }

    private static String getRemoteIpFromXfwd(String xfwd) {
        if (StringUtils.isNotBlank(xfwd)) {
            String[] ipList = xfwd.split(",");
            return StringUtils.trim(ipList[0]);
        } else {
            return null;
        }
    }

    /**
     * 参考：com.anji.captcha.controller.CaptchaController
     * <p>
     * webflux
     *
     * @return
     */
    @Bean
    public RouterFunction monoRouterFunction() {
        return RouterFunctions
                .route(RequestPredicates.path("/getCode").and(RequestPredicates.accept(MediaType.TEXT_PLAIN)),
                        request -> {
                            CaptchaVO captchaVO = new CaptchaVO();
                            // 滑块
                            captchaVO.setCaptchaType("blockPuzzle");
                            captchaVO.setBrowserInfo(getRemoteId(request));
                            return getServerResponseMono(captchaService.get(captchaVO));
                        })
                .andRoute(RequestPredicates.path("/checkCode").and(RequestPredicates.accept(MediaType.TEXT_PLAIN)),
                        request -> {
                            CaptchaVO captchaVO = new CaptchaVO();
                            // todo 不知道原因接受不到参数
                            // data.setPointJson(request.queryParam("pointJson").orElse(""));
                            // data.setToken(request.queryParam("token").orElse(""));
                            captchaVO.setPointJson(request.headers().header("pointJson").get(0));
                            captchaVO.setToken(request.headers().header("token").get(0));
                            captchaVO.setBrowserInfo(getRemoteId(request));
                            captchaVO.setCaptchaType("blockPuzzle");
                            return getServerResponseMono(captchaService.check(captchaVO));
                        });
    }

    private Mono<ServerResponse> getServerResponseMono(ResponseModel responseModel) {
        ServerResponse.BodyBuilder bodyBuilder = ServerResponse
                .status(HttpStatus.OK)
                .contentType(MediaType.APPLICATION_JSON);
        String result = "";
        try {
            result = objectMapper.writeValueAsString(Result.fail(ResultCode.FAIL.getDesc()));
            if (Objects.nonNull(responseModel) && responseModel.isSuccess()) {
                return bodyBuilder.body(BodyInserters.fromValue(objectMapper.writeValueAsString(Result.ok(responseModel))));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return bodyBuilder.body(BodyInserters.fromValue(result));
        }
        return bodyBuilder.body(BodyInserters.fromValue(result));
    }

}
