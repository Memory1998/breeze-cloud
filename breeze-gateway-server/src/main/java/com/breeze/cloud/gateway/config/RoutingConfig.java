package com.breeze.cloud.gateway.config;

import com.anji.captcha.model.vo.CaptchaVO;
import com.anji.captcha.service.CaptchaService;
import com.anji.captcha.util.StringUtils;
import com.breeze.cloud.core.Result;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.*;

import java.util.Optional;

@Configuration
public class RoutingConfig {

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private CaptchaService captchaService;

    /**
     * 参考：com.anji.captcha.controller.CaptchaController
     *
     * webflux项目中 开发 webMVC 接口会报错
     *
     * @return
     */
    @Bean
    public RouterFunction monoRouterFunction() {
        return RouterFunctions
                .route(RequestPredicates.path("/getCode").and(RequestPredicates.accept(MediaType.TEXT_PLAIN)),
                        request -> {
                            CaptchaVO data = new CaptchaVO();
                            // 滑块
                            data.setCaptchaType("blockPuzzle");
                            data.setBrowserInfo(getRemoteId(request));
                            try {
                                return ServerResponse.status(HttpStatus.OK).contentType(MediaType.APPLICATION_JSON)
                                        .body(BodyInserters.fromValue(objectMapper.writeValueAsString(Result.ok(captchaService.get(data)))));
                            } catch (JsonProcessingException e) {
                                e.printStackTrace();
                            }
                            return null;
                        })
                .andRoute(RequestPredicates.path("/checkCode").and(RequestPredicates.accept(MediaType.TEXT_PLAIN)),
                        request -> {
                            CaptchaVO data = new CaptchaVO();
                            data.setPointJson(request.queryParam("pointJson").get());
                            data.setToken(request.queryParam("token").get());
                            data.setBrowserInfo(getRemoteId(request));
                            data.setCaptchaType("blockPuzzle");
                            try {
                                return ServerResponse.status(HttpStatus.OK).contentType(MediaType.APPLICATION_JSON)
                                        .body(BodyInserters.fromValue(objectMapper.writeValueAsString(Result.ok(captchaService.check(data)))));
                            } catch (JsonProcessingException e) {
                                e.printStackTrace();
                            }
                            return null;
                        });
    }

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


}
