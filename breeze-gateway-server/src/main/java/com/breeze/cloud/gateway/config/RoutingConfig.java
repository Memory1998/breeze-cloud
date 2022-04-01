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
                            // todo 不知道原因接受不到参数
                            // data.setPointJson(request.queryParam("pointJson").orElse(""));
                            // data.setToken(request.queryParam("token").orElse(""));
                            data.setPointJson(request.headers().header("pointJson").get(0));
                            data.setToken(request.headers().header("token").get(0));
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


}
