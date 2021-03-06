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

import com.breeze.cloud.admin.entity.SysPlatformEntity;
import com.breeze.cloud.admin.service.SysPlatformService;
import com.breeze.cloud.core.Result;
import com.github.xiaoymin.knife4j.annotations.ApiSort;
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
@RestController
@ApiSort(1)
@Api(tags = "平台管理模块", value = "平台管理模块")
@RequestMapping("/sys/platform")
public class SysPlatformController {

    @Autowired
    private SysPlatformService sysPlatformService;

    /**
     * 列表
     */
    @GetMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:platform:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return Result.ok(this.sysPlatformService.list());
    }

    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:platform:info')")
    public Result info(@PathVariable("id") Long id) {
        return Result.ok(sysPlatformService.getById(id));
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:platform:save')")
    public Result save(@RequestBody SysPlatformEntity sysUser) {
        return Result.ok(sysPlatformService.save(sysUser));
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:user:update')")
    public Result update(@RequestBody SysPlatformEntity sysPlatformEntity) {
        return Result.ok(sysPlatformService.updateById(sysPlatformEntity));
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:platform:delete')")
    public Result delete(@RequestBody Long[] ids) {
        return Result.ok(sysPlatformService.removeByIds(Arrays.asList(ids)));
    }

}
