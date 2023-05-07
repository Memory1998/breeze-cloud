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

package com.breeze.cloud.system.params;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

/**
 * 三方登录参数
 *
 * @author gaoweixuan
 * @date 2022-11-09
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@Schema(description = "三方登录参数")
public class AuthLoginParam {

    /**
     * ID
     */
    @Schema(description = "ID")
    private String id;

    /**
     * 租户ID
     */
    @Schema(description = "租户ID")
    private Long tenantId;

    /**
     * 名称
     */
    @Schema(description = "名称")
    private String appUserName;

    /**
     * 头像 url
     */
    @Schema(description = "头像地址")
    private String avatarUrl;

    /**
     * 手机号
     */
    @Schema(description = "手机号")
    private String phone;

    /**
     * 邮件
     */
    @Schema(description = "邮件")
    private String email;

    /**
     * 性别
     */
    @Schema(description = "性别")
    private Integer sex;

    /**
     * 登录
     */
    @Schema(description = "登录")
    private String login;

    /**
     * 应用程序名称
     */
    @Schema(description = "应用程序名称")
    private String appName;

    /**
     * 软件令牌
     */
    private String appToken;

    /**
     * 范围
     */
    @Schema(description = "范围")
    private String scope;

}
