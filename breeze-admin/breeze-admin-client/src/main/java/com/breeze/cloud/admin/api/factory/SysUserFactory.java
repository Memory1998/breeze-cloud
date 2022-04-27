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

package com.breeze.cloud.admin.api.factory;

import com.breeze.cloud.admin.api.SysUserFeign;
import com.breeze.cloud.admin.dto.SysUserDTO;
import com.breeze.cloud.core.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

/**
 * @author breeze
 * @date 2022/04/27
 */
@Slf4j
@Component
public class SysUserFactory implements FallbackFactory<SysUserFeign> {
    @Override
    public SysUserFeign create(Throwable cause) {
        return new SysUserFeign() {

            @Override
            public Result<SysUserDTO> loadByLoginAmount(String loginAmount) {
                return Result.ok(new SysUserDTO());
            }
        };

    }
}
