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

import com.breeze.cloud.admin.entity.SysRoleEntity;
import com.breeze.cloud.admin.service.SysRoleService;
import com.breeze.cloud.core.Result;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@Api(tags = "角色管理模块", value = "角色管理模块")
@RestController
@RequestMapping("/sys/role")
public class SysRoleController {
    @Autowired
    private SysRoleService sysRoleService;

    /**
     * 列表
     */
    @GetMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return Result.ok();
    }


    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:role:info')")
    public Result info(@PathVariable("id") Long id) {
        SysRoleEntity role = sysRoleService.getById(id);
        return Result.ok(role);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:role:save')")
    public Result save(@RequestBody SysRoleEntity sysRole) {
        return Result.ok(sysRoleService.save(sysRole));
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:role:update')")
    public Result update(@RequestBody SysRoleEntity sysRole) {
        return Result.ok(sysRoleService.updateById(sysRole));
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:role:delete')")
    public Result delete(@RequestBody Long[] ids) {
        return Result.ok(sysRoleService.removeByIds(Arrays.asList(ids)));
    }

}
