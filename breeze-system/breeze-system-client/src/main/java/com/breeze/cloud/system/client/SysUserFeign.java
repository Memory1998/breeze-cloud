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

package com.breeze.cloud.system.client;

import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.system.dto.LoginUser;
import com.breeze.cloud.system.params.AuthLoginParam;
import com.breeze.cloud.system.params.LoginUserParam;
import com.breeze.cloud.system.params.WxLoginParam;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

/**
 * 系统用户Feign
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
@FeignClient(name = "breeze-system-server", contextId = "LoginUserFeign")
public interface SysUserFeign {

    /**
     * 加载用户通过用户名
     *
     * @param username 用户名
     * @param tenantId
     * @return {@link Result}<{@link LoginUserParam}>
     */
    @RequestMapping("/user/loadUserByUsername/{username}")
    Result<LoginUser> loadUserByUsername(@PathVariable("username") String username, @RequestHeader(name = "TENANT_ID") String tenantId);

    /**
     * 加载用户通过电话
     *
     * @param phone 手机号
     * @return {@link Result}<{@link LoginUserParam}>
     */
    @RequestMapping("/user/loadUserByPhone/{phone}")
    Result<LoginUser> loadUserByPhone(@PathVariable("phone") String phone, @RequestHeader(name = "TENANT_ID") String tenantId);

    /**
     * 加载用户通过电子邮件
     *
     * @param email 邮箱
     * @return {@link Result}<{@link LoginUserParam}>
     */
    @RequestMapping("/user/loadUserByEmail/{email}")
    Result<LoginUser> loadUserByEmail(@PathVariable("email") String email);

    /**
     * 微信登录加载用户,若不存在即创建
     *
     * @param wxLoginParam wx登录参数
     * @return {@link Result}<{@link LoginUser}>
     */
    @PostMapping("/user/loadCreateUserByOpenId")
    Result<LoginUser> loadCreateUserByOpenId(@RequestBody WxLoginParam wxLoginParam);

    /**
     * 三方登录
     *
     * @param authLoginParam 三方登录用户
     * @return {@link Result}<{@link LoginUserParam}>
     */
    @PostMapping("/user/loadCreateAuthUserByPhone")
    Result<LoginUser> loadCreateAuthUserByPhone(AuthLoginParam authLoginParam);

    /**
     * 负载创建用户通过电话
     *
     * @param phone 电话
     * @return {@link Result}<{@link LoginUser}>
     */
    @PostMapping("/user/loadCreateUserByPhone/{phone}")
    Result<LoginUser> loadCreateUserByPhone(@PathVariable("phone") String phone);

}
