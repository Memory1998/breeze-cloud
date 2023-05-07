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

package com.breeze.cloud.flow.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.flow.domain.ProcessCategory;
import com.breeze.cloud.flow.query.ProcessCategoryQuery;
import com.breeze.cloud.flow.service.IProcessCategoryService;
import com.breeze.cloud.log.annotation.BreezeSysLog;
import com.breeze.cloud.log.enums.LogType;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Arrays;
import java.util.Objects;

/**
 * 流程资源管理控制器
 *
 * @author gaoweixuan
 * @date 2023-03-01
 */
@RestController
@AllArgsConstructor
@RequestMapping("/category")
@Tag(name = "流程分类管理模块", description = "ProcessCategoryController")
public class ProcessCategoryController {

    /**
     * 流程分类服务
     */
    private final IProcessCategoryService processCategoryService;

    /**
     * 列表
     *
     * @param processCategory 流程类别
     * @return {@link Result}<{@link IPage}<{@link ProcessCategory}>>
     */
    @Operation(summary = "列表")
    @PostMapping("/list")
    @PreAuthorize("hasAnyAuthority('flow:category:list')")
    public Result<IPage<ProcessCategory>> list(@RequestBody ProcessCategoryQuery processCategory) {
        return Result.ok(this.processCategoryService.listPage(processCategory));
    }

    /**
     * 校验流程分类编码是否重复
     *
     * @param categoryCode 流程分类编码
     * @param categoryId   流程分类ID
     * @return {@link Result}<{@link ProcessCategory}>
     */
    @Operation(summary = "校验流程分类编码是否重复")
    @GetMapping("/checkCategoryCode")
    @PreAuthorize("hasAnyAuthority('flow:category:list')")
    public Result<Boolean> checkFlowCategoryCode(@NotBlank(message = "编码不能为空") @RequestParam("categoryCode") String categoryCode,
                                                 @NotNull(message = "ID不能为空") @RequestParam(value = "categoryId", required = false) Long categoryId) {
        return Result.ok(Objects.isNull(this.processCategoryService.getOne(Wrappers.<ProcessCategory>lambdaQuery()
                .ne(Objects.nonNull(categoryId), ProcessCategory::getId, categoryId)
                .eq(ProcessCategory::getCategoryCode, categoryCode))));
    }

    /**
     * 创建
     *
     * @param processCategory 流程分类实体入参
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "保存")
    @PostMapping("/create")
    @PreAuthorize("hasAnyAuthority('flow:category:create')")
    @BreezeSysLog(description = "流程分类信息保存", type = LogType.SAVE)
    public Result<Boolean> save(@Valid @RequestBody ProcessCategory processCategory) {
        return Result.ok(this.processCategoryService.save(processCategory));
    }

    /**
     * 修改
     *
     * @param processCategory 流程分类实体
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "修改")
    @PutMapping("/modify")
    @PreAuthorize("hasAnyAuthority('flow:category:modify')")
    @BreezeSysLog(description = "流程分类信息修改", type = LogType.EDIT)
    public Result<Boolean> modify(@Valid @RequestBody ProcessCategory processCategory) {
        return Result.ok(this.processCategoryService.updateById(processCategory));
    }

    /**
     * 删除
     *
     * @param ids id
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "删除")
    @DeleteMapping("/delete")
    @PreAuthorize("hasAnyAuthority('flow:category:delete')")
    @BreezeSysLog(description = "流程分类信息删除", type = LogType.DELETE)
    public Result<Boolean> delete(@NotNull(message = "参数不能为空") @RequestBody Long[] ids) {
        return Result.ok(this.processCategoryService.removeByIds(Arrays.asList(ids)));
    }

}
