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

import org.apache.commons.compress.utils.Lists;
import org.springframework.boot.autoconfigure.security.oauth2.client.OAuth2ClientProperties;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;
import java.util.Map;

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
        return "index";
    }

    @GetMapping("/index")
    public String index() {
        return "index";
    }

    @GetMapping("/oauth2Login")
    public String oauth2Login(Model model) {
        Map<String, OAuth2ClientProperties.Registration> registration = this.oAuth2ClientProperties.getRegistration();
        String prefix = "/oauth2/authorization/";
        List<String> resultList = Lists.newArrayList();
        registration.forEach((k, v) -> resultList.add(prefix + k));
        model.addAttribute("oauth2Url", resultList);
        return "login";
    }

    @GetMapping("/failure")
    public String failure() {
        return "failure";
    }

    @GetMapping("/userInfo")
    public OAuth2User userInfo(@AuthenticationPrincipal OAuth2User principal) {
        return principal;
    }
}
