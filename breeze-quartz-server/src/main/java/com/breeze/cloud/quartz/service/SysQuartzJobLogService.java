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

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.breeze.cloud.quartz.domain.SysQuartzJobLog;
import com.breeze.cloud.quartz.query.JobQuery;

import java.util.List;

/**
 * quartz定时任务日志服务
 *
 * @author gaoweixuan
 * @date 2023-03-16
 */
public interface SysQuartzJobLogService extends IService<SysQuartzJobLog> {

    /**
     * 列表页面
     *
     * @param jobQuery 任务查询
     * @return {@link Page}<{@link SysQuartzJobLog}>
     */
    Page<SysQuartzJobLog> listPage(JobQuery jobQuery);

    /**
     * 删除日志
     *
     * @param logIds 日志Ids
     * @return boolean
     */
    boolean deleteLogs(List<Long> logIds);

    /**
     * 清空
     */
    void truncate();

}
