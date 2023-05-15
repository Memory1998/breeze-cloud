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

package com.breeze.cloud.log;

import com.breeze.cloud.log.aspect.SysLogAspect;
import com.breeze.cloud.log.events.PublisherSaveSysLogEvent;
import lombok.AllArgsConstructor;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;

/**
 * 开启日志配置
 *
 * @author gaoweixuan
 * @date 2021/10/20
 **/
@AllArgsConstructor
@Configuration(proxyBeanMethods = false)
@EnableAspectJAutoProxy
@ConditionalOnWebApplication
@ConditionalOnProperty(prefix = "breeze.log", value = "enable", havingValue = "true")
public class EnableSysLogConfiguration {

    /**
     * 发布系统日志事件
     */
    private final PublisherSaveSysLogEvent publisherSaveSysLogEvent;

    /**
     * 系统日志AOP Bean
     *
     * @return {@link SysLogAspect}
     */
    @Bean
    @ConditionalOnMissingBean
    public SysLogAspect sysLogAspect() {
        return new SysLogAspect(publisherSaveSysLogEvent);
    }

}

