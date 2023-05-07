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

package com.breeze.cloud.websocket.bo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import java.io.Serializable;
import java.util.List;

/**
 * 用户消息BO
 *
 * @author gaoweixuan
 * @date 2022-11-23
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Schema(description = "用户消息BO")
public class UserMsgBO implements Serializable {

    private static final long serialVersionUID = 1L;

    private SysUserMsgSnapshotBO sysUserMsgSnapshotBO;

    private List<MsgBodyBO> msgBodyBOList;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode(callSuper = false)
    @Schema(description = "用户消息体")
    public static class MsgBodyBO implements Serializable {

        private static final long serialVersionUID = 1L;

        /**
         * 用户ID
         */
        private Long userId;

        /**
         * 消息编码
         */
        private String msgCode;

        /**
         * 消息快照ID
         */
        private Long msgSnapshotId;

    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode(callSuper = false)
    @Schema(description = "系统用户消息快照")
    public static class SysUserMsgSnapshotBO implements Serializable {

        private static final long serialVersionUID = 1L;

        /**
         * 消息ID
         */
        private Long msgId;

        /**
         * 消息标题
         */
        private String msgTitle;

        /**
         * 消息类型 0 通知 1 公告
         */
        private Integer msgType;

        /**
         * 消息级别 error 紧急消息（多次提醒） info 一般消息 warning 警示消消息 success 正常消息
         */
        private String msgLevel;

        /**
         * 消息内容
         */
        private String content;

    }

}
