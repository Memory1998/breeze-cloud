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

package com.breeze.cloud.admin.controller;

import com.breeze.cloud.admin.dto.SysUserDTO;
import com.breeze.cloud.admin.entity.SysUserEntity;
import com.breeze.cloud.admin.service.SysUserService;
import com.breeze.cloud.core.Result;
import com.breeze.cloud.security.annotation.JoinWhiteList;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Arrays;
import java.util.Map;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@RestController
@Api(tags = "用户管理模块", value = "用户管理模块")
@RequestMapping("/sys/user")
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;

    @JoinWhiteList
    @GetMapping("/v1/getUser")
    public Authentication getUser() {
        return SecurityContextHolder.getContext().getAuthentication();
    }

    @JoinWhiteList
    @GetMapping("/v2/getUser")
    public Principal getUser2(Principal principal) {
        return principal;
    }

    /**
     * 登录feign接口
     */
    @GetMapping("/loadByUsername/{username}")
    @JoinWhiteList
    public Result<SysUserDTO> loadByLoginUsername(@PathVariable("username") String username) {
        return this.sysUserService.loadByLoginUsername(username);
    }

    /**
     * 列表
     */
    @GetMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return Result.ok(this.sysUserService.list());
    }

    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:user:info')")
    public Result info(@PathVariable("id") Long id) {
        SysUserEntity sysUser = sysUserService.getById(id);
        return Result.ok(sysUser);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:user:save')")
    public Result save(@RequestBody SysUserEntity sysUser) {
        return Result.ok(sysUserService.save(sysUser));
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:user:update')")
    public Result update(@RequestBody SysUserEntity sysUser) {
        return Result.ok(sysUserService.updateById(sysUser));
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:user:delete')")
    public Result delete(@RequestBody Long[] ids) {
        return Result.ok(sysUserService.removeByIds(Arrays.asList(ids)));
    }

}
