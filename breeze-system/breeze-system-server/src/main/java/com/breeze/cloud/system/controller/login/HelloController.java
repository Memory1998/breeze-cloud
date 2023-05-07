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

package com.breeze.cloud.system.controller.login;

import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.security.annotation.JumpAuth;
import com.breeze.cloud.security.utils.SecurityUtils;
import com.breeze.cloud.system.dto.LoginUser;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * 你好控制器
 *
 * @author gaoweixuan
 * @date 2022-08-31
 */
@Slf4j
@RestController
@SecurityRequirement(name = "Bearer")
@RequestMapping("/test")
public class HelloController {

    /**
     * 你好，世界
     *
     * @param authentication 身份验证
     * @return {@link Result}<{@link String}>
     */
    @PreAuthorize("hasAnyAuthority('sys:test:hello')")
    @GetMapping("/hello")
    @Operation(security = {@SecurityRequirement(name = "Bearer")}, summary = "测试")
    public Result<String> helloWorld(Authentication authentication) {
        LoginUser currentLoginUser = SecurityUtils.getCurrentUser();
        assert currentLoginUser != null;
        currentLoginUser.getAuthorities().forEach(System.out::println);
        return Result.ok("Hello, " + authentication.getName() + "!");
    }

    /**
     * 你好，世界
     *
     * @param authentication 身份验证
     * @return {@link Result}<{@link String}>
     */
    @PreAuthorize("hasAnyRole('ROLE_ADMIN')")
    @GetMapping("/hello2")
    public Result<String> helloWorld2(Authentication authentication) {
        LoginUser currentLoginUser = SecurityUtils.getCurrentUser();
        assert currentLoginUser != null;
        currentLoginUser.getAuthorities().forEach(System.out::println);
        return Result.ok("Hello, " + authentication.getName() + "!");
    }

    /**
     * 获取用户
     *
     * @return {@link Authentication}
     */
    @GetMapping("/v1/getUser")
    public void getUser() {
        System.out.println("SecurityContextHolder.getContext().getAuthentication() = " + SecurityContextHolder.getContext().getAuthentication());
    }

    /**
     * 获取user
     *
     * @param principal 主要
     * @return {@link Principal}
     */
    @GetMapping("/v2/getUser")
    public void getUser2(Principal principal) {
        System.out.println("principal = " + principal);
    }

    /**
     * 获取user
     * 文档 「https://springdoc.org/#how-can-i-ignore-authenticationprincipal-parameter-from-spring-security」
     *
     * @return {@link Principal}
     */
    @GetMapping("/v3/getUser")
    public User getUser3(@AuthenticationPrincipal @Parameter(hidden = true) User user) {
        return user;
    }

    /**
     * 获取user4
     *
     * @param authentication 身份验证
     * @return {@link Object}
     */
    @GetMapping("/v4/getUser")
    public Object getUser4(Authentication authentication) {
        return authentication.getPrincipal();
    }

    /**
     * 测试参数
     *
     * @param a a
     * @param b b
     */
    @JumpAuth
    @GetMapping("/v4/test/{a}/{b}")
    public void test(@PathVariable("a") String a, @PathVariable("b") String b, HttpServletRequest request) {
        log.info("{}, {}", a, b);
    }

    /**
     * 测试跳过验证
     */
    @JumpAuth
    @PostMapping("/v4/test2")
    public void test2(@RequestBody TestDTO testDTO) {
        log.info("{}", testDTO.toString());
    }

    @Data
    static class TestDTO {
        private String a;
        private Long b;
        private LocalDate c;
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
        private LocalDateTime d;
    }

}
