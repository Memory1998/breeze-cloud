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

package com.breeze.cloud.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.system.domain.SysRoleMenu;
import com.breeze.cloud.system.params.MenuPermissionParam;

/**
 * 系统菜单角色服务
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
public interface SysRoleMenuService extends IService<SysRoleMenu> {

    /**
     * 编辑权限
     *
     * @param menuPermissionParam 菜单权限参数
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> modifyPermission(MenuPermissionParam menuPermissionParam);

}

