/*
 * Copyright 2021 the original author or authors.
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

package com.breeze.cloud.admin.api;

import com.breeze.cloud.admin.api.factory.SysUserFeignFactory;
import com.breeze.cloud.admin.dto.SysUserDTO;
import com.breeze.cloud.core.Result;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@FeignClient(name = "breeze-admin-server", contextId = "sysUserFeign", fallback = SysUserFeignFactory.class)
public interface SysUserFeign {

    /**
     * 登录feign接口
     */
    @RequestMapping("/sys/user/loadByUsername/{loginAmount}")
    Result<SysUserDTO> loadByLoginAmount(@PathVariable("loginAmount") String loginAmount);

}
