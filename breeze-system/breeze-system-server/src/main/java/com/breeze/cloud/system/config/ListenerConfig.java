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

package com.breeze.cloud.system.config;

import com.breeze.cloud.log.bo.SysLogBO;
import com.breeze.cloud.log.events.LocalSysLogSaveEventListener;
import com.breeze.cloud.system.service.SysLogService;
import com.breeze.cloud.system.service.SysMsgUserService;
import com.breeze.cloud.websocket.dto.UserMsgDTO;
import com.breeze.cloud.websocket.events.MsgSaveEventListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 系统日志收集的配置
 *
 * @author gaoweixuan
 * @date 2022-08-31
 */
@Configuration
public class ListenerConfig {

    /**
     * 系统日志服务
     */
    @Autowired
    private SysLogService sysLogService;

    /**
     * 用户消息服务
     */
    @Autowired
    private SysMsgUserService sysMsgUserService;

    /**
     * 日志保存侦听器
     *
     * @return {@link LocalSysLogSaveEventListener}
     */
    @Bean
    public LocalSysLogSaveEventListener sysLogSaveEventListener() {
        return new LocalSysLogSaveEventListener((source) -> this.sysLogService.saveSysLog((SysLogBO) source.getSource()));
    }

    /**
     * 消息快照保存侦听器
     *
     * @return {@link MsgSaveEventListener}
     */
    @Bean
    public MsgSaveEventListener msgSaveMsgSnappedEventListener() {
        return new MsgSaveEventListener((source) -> this.sysMsgUserService.saveUserMsg((UserMsgDTO) source.getSource()));
    }

}
