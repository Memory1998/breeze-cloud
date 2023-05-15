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
import com.breeze.cloud.system.domain.SysRegisteredClient;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * 系统用户Feign
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
@FeignClient(name = ContextConstants.SYSTEM, contextId = "SysRegisterClientFeign")
public interface SysRegisterClientFeign {

    /**
     * 通过客户端id获取客户端
     *
     * @param clientId 客户端id
     * @return {@link SysRegisteredClient}
     */
    @GetMapping("/client/getByClientId/{clientId}")
    SysRegisteredClient getByClientId(@PathVariable("clientId") String clientId);

    /**
     * 通过id获取客户端
     *
     * @param id id
     * @return {@link SysRegisteredClient}
     */
    @GetMapping("/client/getById/{id}")
    SysRegisteredClient getById(@PathVariable("id") String id);

}
