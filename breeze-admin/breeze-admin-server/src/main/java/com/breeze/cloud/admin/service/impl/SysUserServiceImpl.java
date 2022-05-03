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

package com.breeze.cloud.admin.service.impl;

import cn.hutool.core.bean.BeanUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.cloud.admin.dto.SysUserDTO;
import com.breeze.cloud.admin.dto.SysUserRoleDTO;
import com.breeze.cloud.admin.entity.SysDeptEntity;
import com.breeze.cloud.admin.entity.SysUserEntity;
import com.breeze.cloud.admin.mapper.SysUserMapper;
import com.breeze.cloud.admin.service.SysDeptService;
import com.breeze.cloud.admin.service.SysMenuService;
import com.breeze.cloud.admin.service.SysRoleService;
import com.breeze.cloud.admin.service.SysUserService;
import com.breeze.cloud.core.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.List;
import java.util.Objects;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUserEntity> implements SysUserService {

    @Autowired
    private SysRoleService sysRoleService;

    @Autowired
    private SysMenuService sysMenuService;

    @Autowired
    private SysDeptService sysDeptService;

    @Override
    public Result<SysUserDTO> loadByLoginUsername(String username) {
        SysUserEntity sysUserEntity = this.getOne(Wrappers.<SysUserEntity>lambdaQuery().eq(SysUserEntity::getUsername, username));
        if (Objects.isNull(sysUserEntity)) {
            return Result.fail("用户名错误或不存在");
        }
        SysUserDTO sysUserDTO = new SysUserDTO();
        SysDeptEntity dept = this.sysDeptService.getById(sysUserEntity.getDeptId());
        sysUserDTO.setDeptName(dept.getDeptName());
        BeanUtil.copyProperties(sysUserEntity, sysUserDTO);
        List<SysUserRoleDTO> userRoleDTOList = this.sysRoleService.listUserRole(sysUserEntity.getId());
        sysUserDTO.setUserRoleDTOList(userRoleDTOList);
        if (CollectionUtils.isEmpty(userRoleDTOList)){
            return Result.ok(sysUserDTO);
        }
        String[] permissionList = this.sysMenuService.listUserMenuPermission(userRoleDTOList);
        sysUserDTO.setPermission(permissionList);
        return Result.ok(sysUserDTO);
    }
}
