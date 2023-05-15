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

package com.breeze.cloud.system.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.log.annotation.BreezeSysLog;
import com.breeze.cloud.log.bo.SysLogBO;
import com.breeze.cloud.log.enums.LogType;
import com.breeze.cloud.security.annotation.JumpAuth;
import com.breeze.cloud.system.domain.SysLog;
import com.breeze.cloud.system.query.LogQuery;
import com.breeze.cloud.system.service.SysLogService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.Arrays;

/**
 * 系统日志控制器
 *
 * @author gaoweixuan
 * @date 2022-09-02
 */
@RestController
@AllArgsConstructor
@SecurityRequirement(name = "Bearer")
@RequestMapping("/log")
@Tag(name = "系统日志管理模块", description = "SysLogController")
public class SysLogController {

    /**
     * 系统日志服务
     */
    private final SysLogService sysLogService;

    /**
     * 列表
     *
     * @param logQuery 日志查询
     * @return {@link Result}<{@link Page}<{@link SysLog}>>
     */
    @PostMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:log:list')")
    public Result<Page<SysLog>> list(@RequestBody LogQuery logQuery) {
        return Result.ok(this.sysLogService.listPage(logQuery));
    }

    /**
     * 远程保存接口
     *
     * @param sysLogBO 日志BO
     */
    @PostMapping("/save")
    @JumpAuth
    public void save(@RequestBody SysLogBO sysLogBO) {
        this.sysLogService.saveSysLog(sysLogBO);
    }

    /**
     * 清空日志表
     */
    @Operation(summary = "清空")
    @DeleteMapping("/truncate")
    @PreAuthorize("hasAnyAuthority('sys:log:truncate')")
    @BreezeSysLog(description = "日志信息清空", type = LogType.DELETE)
    public void truncate() {
        this.sysLogService.truncate();
    }

    /**
     * 删除
     *
     * @param ids ids
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "删除")
    @DeleteMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:log:delete')")
    @BreezeSysLog(description = "日志信息删除", type = LogType.DELETE)
    public Result<Boolean> delete(@NotNull(message = "参数不能为空") @RequestBody Long[] ids) {
        return Result.ok(this.sysLogService.removeByIds(Arrays.asList(ids)));
    }

}
