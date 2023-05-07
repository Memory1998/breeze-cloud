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

package com.breeze.cloud.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.cloud.system.domain.SysRole;
import com.breeze.cloud.system.domain.SysUserRole;
import com.breeze.cloud.system.mapper.SysUserRoleMapper;
import com.breeze.cloud.system.service.SysUserRoleService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 系统角色用户服务impl
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
@Service
@AllArgsConstructor
public class SysUserRoleServiceImpl extends ServiceImpl<SysUserRoleMapper, SysUserRole> implements SysUserRoleService {

    /**
     * 使用 [userId] 查询用户角色
     *
     * @param userId 用户id
     * @return {@link List}<{@link SysRole}>
     */
    @Override
    public List<SysRole> getSysRoleByUserId(Long userId) {
        return this.baseMapper.getSysRoleByUserId(userId);
    }
}
