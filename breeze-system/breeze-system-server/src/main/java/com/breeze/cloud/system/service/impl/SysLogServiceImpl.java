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

package com.breeze.cloud.system.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.cloud.log.bo.SysLogBO;
import com.breeze.cloud.system.domain.SysLog;
import com.breeze.cloud.system.mapper.SysLogMapper;
import com.breeze.cloud.system.query.LogQuery;
import com.breeze.cloud.system.service.SysLogService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 系统日志服务impl
 *
 * @author gaoweixuan
 * @date 2022-09-02
 */
@Service
@AllArgsConstructor
public class SysLogServiceImpl extends ServiceImpl<SysLogMapper, SysLog> implements SysLogService {

    /**
     * 日志列表
     *
     * @param logQuery 日志查询
     * @return {@link Page}<{@link SysLog}>
     */
    @Override
    public Page<SysLog> listPage(LogQuery logQuery) {
        return this.baseMapper.listPage(new Page<>(logQuery.getCurrent(), logQuery.getLimit()), logQuery);
    }

    /**
     * 保存系统日志
     *
     * @param sysLogBO 系统日志BO
     */
    @Override
    public void saveSysLog(SysLogBO sysLogBO) {
        SysLog sysLog = new SysLog();
        BeanUtil.copyProperties(sysLogBO, sysLog);
        this.save(sysLog);
    }

    /**
     * 清空
     */
    @Override
    public void truncate() {
        this.baseMapper.truncate();
    }

}
