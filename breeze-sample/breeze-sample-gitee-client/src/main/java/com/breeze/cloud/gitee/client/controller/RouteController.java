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

package com.breeze.cloud.gitee.client.controller;

import com.google.common.collect.Maps;
import lombok.SneakyThrows;
import org.checkerframework.checker.nullness.qual.Nullable;
import org.springframework.boot.autoconfigure.security.oauth2.client.OAuth2ClientProperties;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.net.URLDecoder;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * 路由控制器
 *
 * @author gaoweixuan
 * @date 2023-04-20
 */
@Controller
public class RouteController {

    private final OAuth2ClientProperties oAuth2ClientProperties;

    public RouteController(OAuth2ClientProperties properties) {
        this.oAuth2ClientProperties = properties;
    }

    @GetMapping("/")
    public String root() {
        return "redirect:/index";
    }
    @GetMapping("/index")
    public String index(Model model, @AuthenticationPrincipal OAuth2User principal) {
        Map<@Nullable String, @Nullable Object> resultMap = Maps.newHashMap();
        resultMap.put("name", principal.getName());
        resultMap.put("attributes", principal.getAttributes());
        resultMap.put("authorities", principal.getAuthorities().stream().map(GrantedAuthority::getAuthority).collect(Collectors.toList()));
        model.addAttribute("userInfo", resultMap);
        return "index";
    }

    @SneakyThrows
    @GetMapping("/logout")
    public String login(Model model, String msg) {
        Map<String, OAuth2ClientProperties.Registration> registration = this.oAuth2ClientProperties.getRegistration();
        String prefix = "/oauth2/authorization/";
        Map<String, String> resultMap = Maps.newHashMap();
        registration.forEach((k, v) -> resultMap.put(v.getClientName(), prefix + k));
        model.addAttribute("oauthLogin", resultMap);
        if(Objects.nonNull(msg)){
            model.addAttribute("msg", URLDecoder.decode(msg, "UTF-8"));
        }
        return "login";
    }

    @SneakyThrows
    @GetMapping("/oauth2Login")
    public String oauth2Login(Model model, String msg) {
        Map<String, OAuth2ClientProperties.Registration> registration = this.oAuth2ClientProperties.getRegistration();
        String prefix = "/oauth2/authorization/";
        Map<String, String> resultMap = Maps.newHashMap();
        registration.forEach((k, v) -> resultMap.put(v.getClientName(), prefix + k));
        model.addAttribute("oauthLogin", resultMap);
        if(Objects.nonNull(msg)){
            model.addAttribute("msg", URLDecoder.decode(msg, "UTF-8"));
        }
        return "login";
    }

}
