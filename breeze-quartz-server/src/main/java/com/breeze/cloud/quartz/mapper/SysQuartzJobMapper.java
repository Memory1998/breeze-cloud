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

package com.breeze.cloud.quartz.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.cloud.quartz.domain.SysQuartzJob;
import com.breeze.cloud.quartz.query.JobQuery;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * Quartz任务日志映射器
 *
 * @author gaoweixuan
 * @date 2023-03-16
 */
@Mapper
public interface SysQuartzJobMapper extends BaseMapper<SysQuartzJob> {

    /**
     * 列表页面
     *
     * @param page     页面
     * @param jobQuery 任务查询
     * @return {@link Page}<{@link SysQuartzJob}>
     */
    Page<SysQuartzJob> listPage(Page<SysQuartzJob> page, @Param("jobQuery") JobQuery jobQuery);

}




