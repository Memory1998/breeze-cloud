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

package com.breeze.cloud.system.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.cloud.mybatis.mapper.BreezeBaseMapper;
import com.breeze.cloud.system.domain.SysPermission;
import com.breeze.cloud.system.query.DataPermissionQuery;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 系统数据权限映射器
 *
 * @author gaoweixuan
 * @date 2022-10-30
 */
@Mapper
public interface SysPermissionMapper extends BreezeBaseMapper<SysPermission> {

    /**
     * 列表分页
     *
     * @param permissionQuery 数据权限查询
     * @param page            页面
     * @return {@link Page}<{@link SysPermission}>
     */
    Page<SysPermission> listPage(Page<SysPermission> page, @Param("permissionQuery") DataPermissionQuery permissionQuery);

}
