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

package com.breeze.admin.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_menu")
public class SysMenuEntity extends BaseModel<SysMenuEntity> implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 菜单名称
     */
    private String menuName;
    /**
     * 顺序
     */
    private Integer sort;
    /**
     * 上一级的菜单ID
     */
    private Long parentId;
    /**
     * 权限
     */
    private String per;
    /**
     * 路径
     */
    private String path;
    /**
     * 保活
     */
    private Integer keepAlive;
    /**
     * 隐藏
     */
    private Integer visable;

}
