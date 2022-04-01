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

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.cloud.admin.entity.SysDeptEntity;
import com.breeze.cloud.admin.service.SysDeptService;
import com.breeze.cloud.core.Result;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@Api(tags = "部门管理模块", value = "部门管理模块")
@RestController
@RequestMapping("/sys/dept")
public class SysDeptController {

    @Autowired
    private SysDeptService sysDeptService;

    /**
     * 列表
     */
    @GetMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:dept:list')")
    public Result<IPage<SysDeptEntity>> listPage(Page<SysDeptEntity> page, SysDeptEntity deptEntity) {
        return Result.ok(this.sysDeptService.page(page, Wrappers.query(deptEntity)));
    }

    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:dept:info')")
    public Result info(@PathVariable("id") Long id) {
        return Result.ok(sysDeptService.getById(id));
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:dept:save')")
    public Result save(@RequestBody SysDeptEntity sysDept) {
        return Result.ok(sysDeptService.save(sysDept));
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:dept:update')")
    public Result update(@RequestBody SysDeptEntity sysDept) {
        return Result.ok(this.sysDeptService.updateById(sysDept));
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:dept:delete')")
    public Result delete(@RequestBody Long[] ids) {
        return Result.ok(this.sysDeptService.removeByIds(Arrays.asList(ids)));
    }

}
