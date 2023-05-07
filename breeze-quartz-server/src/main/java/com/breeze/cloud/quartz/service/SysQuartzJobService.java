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

package com.breeze.cloud.quartz.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.quartz.domain.SysQuartzJob;
import com.breeze.cloud.quartz.query.JobQuery;

import java.util.List;

/**
 * quartz定时任务日志服务
 *
 * @author gaoweixuan
 * @date 2023-03-16
 */
public interface SysQuartzJobService extends IService<SysQuartzJob> {

    /**
     * 列表页面
     *
     * @param jobQuery 任务查询
     * @return {@link IPage}<{@link SysQuartzJob}>
     */
    Page<SysQuartzJob> listPage(JobQuery jobQuery);

    /**
     * 保存任务
     *
     * @param sysQuartzJob quartz任务
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> saveJob(SysQuartzJob sysQuartzJob);

    /**
     * 更新任务通过id
     *
     * @param sysQuartzJob quartz任务
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> updateJobById(SysQuartzJob sysQuartzJob);

    /**
     * 暂停任务
     *
     * @param jobId 任务id
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> pauseJob(Long jobId);

    /**
     * 恢复任务
     *
     * @param jobId 任务id
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> resumeJob(Long jobId);

    /**
     * 删除任务
     *
     * @param jobIds 任务ids
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> deleteJob(List<Long> jobIds);

    /**
     * 立刻运行
     *
     * @param jobId 任务ID
     * @return {@link Boolean}
     */
    Result<Boolean> runJobNow(Long jobId);

}
