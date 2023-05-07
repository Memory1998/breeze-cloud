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

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.system.domain.SysPermission;
import com.breeze.cloud.system.params.DataPermissionParam;
import com.breeze.cloud.system.query.DataPermissionQuery;

import java.util.List;

/**
 * 系统数据权限服务
 *
 * @author gaoweixuan
 * @date 2022-10-30
 */
public interface SysPermissionService extends IService<SysPermission> {

    /**
     * 列表页面
     *
     * @param dataPermissionQuery 权限查询
     * @return {@link Page}<{@link SysPermission}>
     */
    Page<SysPermission> listPage(DataPermissionQuery dataPermissionQuery);

    /**
     * 保存数据权限
     *
     * @param dataPermissionParam 数据权限参数
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> savePermission(DataPermissionParam dataPermissionParam);

    /**
     * 删除数据权限通过IDS
     *
     * @param ids ids
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> removePermissionByIds(List<Long> ids);

    /**
     * 修改数据权限
     *
     * @param dataPermissionParam 数据权限参数
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> modifyPermission(DataPermissionParam dataPermissionParam);

}
