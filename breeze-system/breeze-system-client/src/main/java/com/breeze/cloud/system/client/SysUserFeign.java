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

import com.breeze.cloud.core.base.BaseLoginUser;
import com.breeze.cloud.core.constants.ContextConstants;
import com.breeze.cloud.core.utils.Result;
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
@FeignClient(name = ContextConstants.SYSTEM, contextId = "LoginUserFeign")
public interface SysUserFeign {

    /**
     * 加载用户通过用户名
     *
     * @param username 用户名
     * @param tenantId 承租者id
     * @return {@link Result}<{@link BaseLoginUser}>
     */
    @RequestMapping("/user/loadUserByUsername/{username}")
    Result<BaseLoginUser> loadUserByUsername(@PathVariable("username") String username, @RequestHeader(name = "TENANT_ID") String tenantId);

    /**
     * 加载用户通过电话
     *
     * @param phone    手机号
     * @param tenantId 承租者id
     * @return {@link Result}<{@link BaseLoginUser}>
     */
    @RequestMapping("/user/loadUserByPhone/{phone}")
    Result<BaseLoginUser> loadUserByPhone(@PathVariable("phone") String phone, @RequestHeader(name = "TENANT_ID") String tenantId);

    /**
     * 加载用户通过电子邮件
     *
     * @param email    邮箱
     * @param tenantId 承租者id
     * @return {@link Result}<{@link BaseLoginUser}>
     */
    @RequestMapping("/user/loadUserByEmail/{email}")
    Result<BaseLoginUser> loadUserByEmail(@PathVariable("email") String email, @RequestHeader(name = "TENANT_ID") String tenantId);

    /**
     * 微信登录加载用户,若不存在即创建
     *
     * @param wxLoginParam wx登录参数
     * @return {@link Result}<{@link BaseLoginUser}>
     */
    @PostMapping("/user/loadCreateUserByOpenId")
    Result<BaseLoginUser> loadCreateUserByOpenId(@RequestBody WxLoginParam wxLoginParam);

    /**
     * 三方登录
     *
     * @param authLoginParam 三方登录用户
     * @return {@link Result}<{@link LoginUserParam}>
     */
    @PostMapping("/user/loadCreateAuthUserByPhone")
    Result<BaseLoginUser> loadCreateAuthUserByPhone(AuthLoginParam authLoginParam);

    /**
     * 负载创建用户通过电话
     *
     * @param phone 电话
     * @return {@link Result}<{@link BaseLoginUser}>
     */
    @PostMapping("/user/loadCreateUserByPhone/{phone}")
    Result<BaseLoginUser> loadCreateUserByPhone(@PathVariable("phone") String phone);

}
