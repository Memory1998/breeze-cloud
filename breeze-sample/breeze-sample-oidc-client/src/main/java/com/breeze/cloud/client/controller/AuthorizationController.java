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

package com.breeze.cloud.client.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.client.OAuth2AuthorizedClient;
import org.springframework.security.oauth2.client.annotation.RegisteredOAuth2AuthorizedClient;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.core.endpoint.OAuth2ParameterNames;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.reactive.function.client.WebClient;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

import static org.springframework.security.oauth2.client.web.reactive.function.client.ServletOAuth2AuthorizedClientExchangeFilterFunction.clientRegistrationId;
import static org.springframework.security.oauth2.client.web.reactive.function.client.ServletOAuth2AuthorizedClientExchangeFilterFunction.oauth2AuthorizedClient;

/**
 * 授权控制器
 *
 * @author gaoweixuan
 * @date 2023-04-21
 */
@Slf4j
@Controller
public class AuthorizationController {
    private final WebClient webClient;
    private final String messagesBaseUri;

    public AuthorizationController(WebClient webClient,
                                   @Value("${messages.base-uri}") String messagesBaseUri) {
        this.webClient = webClient;
        this.messagesBaseUri = messagesBaseUri;
    }

    /**
     * @param model            模型
     * @param authorizedClient 授权客户端
     * @return {@link String}
     */
    @GetMapping(value = "/authorize", params = "grant_type=authorization_code")
    public String authorize(Model model,
                            @AuthenticationPrincipal OAuth2User principal,
                            @RegisteredOAuth2AuthorizedClient("breeze-authorization-code") OAuth2AuthorizedClient authorizedClient) {
        log.info("[获取信息，AuthorizationCodeGrantType]: {}", authorizedClient);

        List messages = this.webClient
                .get()
                .uri(this.messagesBaseUri + "/write/hello!")
                .attributes(oauth2AuthorizedClient(authorizedClient))
                .retrieve()
                .bodyToMono(List.class)
                .block();
        log.info("[读取到的信息]： {}", messages);

        // 给页面赋值
        model.addAttribute("messages", messages);
        model.addAttribute("name", principal.getName());

        return "index";
    }

    /**
     * '/authorized' is the registered 'redirect_uri' for authorization_code
     */
    @GetMapping(value = "/authorized", params = OAuth2ParameterNames.ERROR)
    public String authorizationFailed(Model model, HttpServletRequest request) {
        String errorCode = request.getParameter(OAuth2ParameterNames.ERROR);
        if (StringUtils.hasText(errorCode)) {
            model.addAttribute("error",
                    new OAuth2Error(
                            errorCode,
                            request.getParameter(OAuth2ParameterNames.ERROR_DESCRIPTION),
                            request.getParameter(OAuth2ParameterNames.ERROR_URI))
            );
        }

        return "index";
    }

    /**
     * 客户端授权
     *
     * @param model 模型
     * @return {@link String}
     */
    @GetMapping(value = "/authorize", params = "grant_type=client_credentials")
    public String clientCredentialsGrant(Model model, @AuthenticationPrincipal OAuth2User principal) {
        List messages = this.webClient
                .get()
                .uri(this.messagesBaseUri + "/read/hello")
                .attributes(clientRegistrationId("breeze-client-credentials"))
                .retrieve()
                .bodyToMono(List.class)
                .block();
        log.info("[读取到的信息]： {}", messages);
        model.addAttribute("messages", messages);
        model.addAttribute("name", principal.getName());

        return "index";
    }

}
