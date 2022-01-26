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

import com.breeze.cloud.admin.entity.OauthClientDetailsEntity;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@FeignClient(name = "breeze-admin-server", contextId = "oauthClientDetailsFeign")
public interface OauthClientDetailsFeign {

    /**
     * 信息
     */
    @GetMapping("/sys/oauth/info/{clientId}")
    OauthClientDetailsEntity info(@PathVariable("clientId") String clientId);
}
