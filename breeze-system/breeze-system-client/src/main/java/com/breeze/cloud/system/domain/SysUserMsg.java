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
 * 系统用户消息
 *
 * @author gaoweixuan
 * @date 2022-11-26
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@TableName(value = "sys_user_msg")
@Schema(description = "系统用户消息实体")
public class SysUserMsg extends BaseModel<SysUserMsg> implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    @Schema(description = "用户ID")
    private Long userId;

    /**
     * 消息编码
     */
    @Schema(description = "消息编码")
    private String msgCode;

    /**
     * 关闭
     */
    @Schema(description = "关闭")
    private Integer markClose;

    /**
     * 已读
     */
    @Schema(description = "已读")
    private Integer markRead;

    /**
     * 消息快照ID
     */
    @Schema(description = "消息快照ID")
    private Long msgSnapshotId;

}
