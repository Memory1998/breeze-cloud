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

package com.breeze.cloud.auth.config;

import com.breeze.cloud.log.bo.SysLogBO;
import com.breeze.cloud.log.events.LocalSysLogSaveEventListener;
import com.breeze.cloud.log.events.RemoteSysLogSaveEventListener;
import com.breeze.cloud.system.client.SysLogFeign;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 系统日志配置
 *
 * @author gaoweixuan
 * @date 2023/05/15
 */
@Configuration
@RequiredArgsConstructor
public class SysLogConfiguration {

    /**
     * 系统日志feign
     */
    private final SysLogFeign sysLogFeign;

    /**
     * 远程接口日志保存侦听器
     *
     * @return {@link LocalSysLogSaveEventListener}
     */
    @Bean
    public RemoteSysLogSaveEventListener remoteSysLogSaveEventListener() {
        return new RemoteSysLogSaveEventListener((source) -> this.sysLogFeign.save((SysLogBO) source.getSource()));
    }

}


