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

package com.breeze.cloud.system.domain;

import com.baomidou.mybatisplus.annotation.TableName;
import com.breeze.cloud.core.base.BaseModel;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import java.io.Serializable;

/**
 * 系统岗位实体
 *
 * @author gaoweixuan
 * @date 2022-11-06
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@TableName(value = "sys_post")
@Schema(description = "系统岗位实体")
public class SysPost extends BaseModel<SysRolePermission> implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 岗位名称
     */
    private String postCode;

    /**
     * 岗位编码
     */
    private String postName;

    /**
     * 描述
     */
    private String description;

}
