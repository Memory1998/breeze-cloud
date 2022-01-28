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

import com.breeze.cloud.admin.entity.SysUserEntity;
import com.breeze.cloud.admin.service.SysUserService;
import com.breeze.cloud.core.Result;
import com.breeze.cloud.security.annotation.JoinWhiteList;
import com.github.xiaoymin.knife4j.annotations.ApiSort;
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
@ApiSort(1)
@Api(tags = "用户管理", value = "SysUserController")
@RequestMapping("/sys/user")
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;

    @GetMapping("/v1/getUser")
    @JoinWhiteList
    public Authentication getUser() {
        return SecurityContextHolder.getContext().getAuthentication();
    }

    @GetMapping("/v2/getUser")
    @JoinWhiteList
    @PreAuthorize("hasAnyAuthority('sys:admin')")
    public Principal getUser2(Principal principal) {
        return principal;
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return null;
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result info(@PathVariable("id") Long id) {
        SysUserEntity sysUser = sysUserService.getById(id);
        return Result.ok();
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result save(@RequestBody SysUserEntity sysUser) {
        sysUserService.save(sysUser);
        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result update(@RequestBody SysUserEntity sysUser) {
        sysUserService.updateById(sysUser);
        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result delete(@RequestBody Long[] ids) {
        sysUserService.removeByIds(Arrays.asList(ids));
        return Result.ok();
    }

}
