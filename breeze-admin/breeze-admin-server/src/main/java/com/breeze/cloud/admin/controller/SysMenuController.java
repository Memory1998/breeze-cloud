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

import com.breeze.cloud.admin.entity.SysMenuEntity;
import com.breeze.cloud.admin.service.SysMenuService;
import com.breeze.cloud.core.Result;
import com.breeze.cloud.security.annotation.JoinWhiteList;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;


/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@Api(tags = "模块")
@RestController
@RequestMapping("/sys/menu")
public class SysMenuController {

    @Autowired
    private SysMenuService sysMenuService;

    /**
     * 列表
     */
    @ApiOperation(value = "列表")
    @RequestMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return Result.ok();
    }

    /**
     * 树形菜单
     */
    @ApiOperation(value = "树形菜单")
    @GetMapping("/menuTree")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result menuTree(@RequestParam String platformCode) {
        return Result.ok(this.sysMenuService.menuTree(platformCode));
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result info(@PathVariable("id") Long id) {
        SysMenuEntity sysMenu = sysMenuService.getById(id);
        return Result.ok();
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result<Boolean> save(@RequestBody SysMenuEntity sysMenu) {
        sysMenuService.save(sysMenu);
        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result<Boolean> update(@RequestBody SysMenuEntity sysMenu) {
        sysMenuService.updateById(sysMenu);
        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result<Boolean> delete(@RequestBody Long[] ids) {
        sysMenuService.removeByIds(Arrays.asList(ids));
        return Result.ok();
    }

}
