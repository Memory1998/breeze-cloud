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

package com.breeze.cloud.quartz.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.log.annotation.BreezeSysLog;
import com.breeze.cloud.log.enums.LogType;
import com.breeze.cloud.quartz.domain.SysQuartzJobLog;
import com.breeze.cloud.quartz.query.JobQuery;
import com.breeze.cloud.quartz.service.SysQuartzJobLogService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * Quartz任务控制器
 *
 * @author gaoweixuan
 * @date 2023-03-16
 */
@RestController
@AllArgsConstructor
@RequestMapping(value = "/jLog")
public class SysQuartzJobLogController {

    /**
     * quartz 任务服务
     */
    private final SysQuartzJobLogService quartzJobLogService;

    /**
     * 列表页面
     *
     * @param jobQuery 任务查询
     * @return {@link Result}<{@link Page}<{@link SysQuartzJobLog}>>
     */
    @Operation(summary = "列表")
    @PostMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:jLog:list')")
    public Result<Page<SysQuartzJobLog>> listPage(@RequestBody JobQuery jobQuery) {
        return Result.ok(this.quartzJobLogService.listPage(jobQuery));
    }

    /**
     * 删除
     *
     * @param logIds 日志Ids
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "删除")
    @DeleteMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:jLog:delete')")
    @BreezeSysLog(description = "删除任务日志", type = LogType.DELETE)
    public Result<Boolean> delete(@NotNull(message = "参数不能为空") @RequestBody List<Long> logIds) {
        return Result.ok(this.quartzJobLogService.deleteLogs(logIds));
    }

    /**
     * 清空
     */
    @Operation(summary = "清空")
    @PutMapping("/truncate")
    @PreAuthorize("hasAnyAuthority('sys:jLog:truncate')")
    @BreezeSysLog(description = "清空任务日志", type = LogType.DELETE)
    public void truncate() {
        this.quartzJobLogService.truncate();
    }

}
