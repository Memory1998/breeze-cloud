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

package com.breeze.cloud.flow.client;

import com.breeze.cloud.core.constants.ContextConstants;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.flow.params.ProcessStartParam;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

/**
 * 可流动过程假装
 *
 * @author gaoweixuan
 * @date 2023-04-11
 */
@FeignClient(name = ContextConstants.FLOWABLE, contextId = "FlowableProcessFeign")
public interface FlowableProcessFeign {

    /**
     * 开启审批流
     *
     * @param startParam 启动参数
     * @return {@link Result}<{@link Boolean}>
     */
    @PostMapping("/startProcess")
    Result<Boolean> startProcess(@Valid @RequestBody ProcessStartParam startParam);

}
