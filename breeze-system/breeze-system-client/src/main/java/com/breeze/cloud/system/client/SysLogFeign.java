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

package com.breeze.cloud.system.client;

import com.breeze.cloud.core.constants.ContextConstants;
import com.breeze.cloud.log.bo.SysLogBO;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

/**
 * 系统日志控制器
 *
 * @author gaoweixuan
 * @date 2023-05-15
 */
@FeignClient(name = ContextConstants.SYSTEM, contextId = "SysLogFeign")
public interface SysLogFeign {

    /**
     * 远程保存接口
     *
     * @param sysLogBO 日志BO
     */
    @PostMapping("/log/save")
    void save(@RequestBody SysLogBO sysLogBO);

}
