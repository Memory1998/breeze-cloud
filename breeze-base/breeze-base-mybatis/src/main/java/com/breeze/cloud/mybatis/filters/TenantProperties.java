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

package com.breeze.cloud.mybatis.filters;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.List;

/**
 * 租户白名单属性
 *
 * @author gaoweixuan
 * @date 2023-03-06
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "breeze.tenant")
public class TenantProperties {

    /**
     * 增加租户的表
     */
    private List<String> tables;

    /**
     * 列
     */
    private String column = "tenant_id";

    /**
     * 参数
     */
    private String param = "tenantId";

}
