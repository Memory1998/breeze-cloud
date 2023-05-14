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

package com.breeze.cloud.system.controller;

import com.breeze.cloud.security.annotation.JumpAuth;
import com.breeze.cloud.system.service.OnlineLoginUserService;
import lombok.AllArgsConstructor;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 在线登录用户控制器
 *
 * @author gaoweixuan
 * @date 2023/05/14
 */
@RestController
@AllArgsConstructor
@RequestMapping("/online")
public class OnlineLoginUserController {

    private final OnlineLoginUserService onlineLoginUserService;

    @GetMapping
    @JumpAuth
    public List<User> listAllPrincipals() {
        return this.onlineLoginUserService.listAllPrincipals();
    }

}
