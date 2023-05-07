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

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.breeze.cloud.core.base.BaseModel;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;

/**
 * 系统菜单实体
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
@TableName("sys_menu")
@Schema(description = "系统菜单实体")
public class SysMenu extends BaseModel<SysMenu> implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 平台ID
     */
    @Schema(description = "平台ID")
    @NotNull(message = "平台ID不可为空")
    private Long platformId;

    /**
     * 平台名称
     */
    @Schema(description = "平台名称")
    @TableField(exist = false)
    private String platformName;

    /**
     * 上一级的菜单ID
     */
    @Schema(description = "上一级的菜单ID")
    @NotNull(message = "上一级的菜单ID不可为空")
    private Long parentId;

    /**
     * 标题
     */
    @Schema(description = "标题")
    @NotBlank(message = "标题不可为空")
    private String title;

    /**
     * 组件名称
     */
    @Schema(description = "组件名称")
    private String name;

    /**
     * 类型 0 文件夹 1 菜单 2 按钮
     */
    @Schema(description = "类型")
    private Integer type;

    /**
     * 图标
     */
    @Schema(description = "图标")
    private String icon;

    /**
     * 菜单路径
     */
    @Schema(description = "菜单路径")
    private String path;

    /**
     * 组件路径
     */
    @Schema(description = "组件路径")
    private String component;


    /**
     * 权限标识
     */
    @Schema(description = "权限标识")
    private String permission;

    /**
     * 是否开启缓存
     */
    @Schema(description = "是否开启缓存")
    private Integer keepAlive;

    /**
     * 是否隐藏
     */
    @Schema(description = "是否隐藏")
    private Integer hidden;

    /**
     * 是否外链
     */
    @Schema(description = "是否外链")
    private Integer href;

    /**
     * 顺序
     */
    @Schema(description = "顺序")
    private Integer sort;

    /**
     * 此菜单拥有的所有的权限
     */
    @Schema(description = "此菜单拥有的所有的权限")
    @TableField(exist = false)
    private List<String> permissions;
}
