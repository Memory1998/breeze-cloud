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

package com.breeze.cloud.flow.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import java.io.Serializable;
import java.util.Date;

/**
 * 流程部署
 *
 * @author gaoweixuan
 * @date 2023-03-08
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@TableName(value = "act_re_deployment")
@Schema(description = "流程部署实体")
public class ActReDeployment implements Serializable {

    @TableField(exist = false)
    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId
    private String id;

    /**
     * 名字
     */
    private String name;

    /**
     * 类别
     */
    private String category;

    /**
     * KEY
     */
    private String key;

    /**
     * 租户ID
     */
    private String tenantId;

    /**
     * 部署时
     */
    private Date deployTime;

    /**
     * 来自
     */
    private String derivedFrom;

    /**
     * 来自根
     */
    private String derivedFromRoot;

    /**
     * 父部署id
     */
    private String parentDeploymentId;

    /**
     * 引擎版本
     */
    private String engineVersion;

}
