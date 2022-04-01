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

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.lang.tree.Tree;
import cn.hutool.core.lang.tree.TreeNode;
import cn.hutool.core.lang.tree.TreeUtil;
import cn.hutool.json.JSONUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.cloud.admin.dto.SysUserRoleDTO;
import com.breeze.cloud.admin.entity.SysMenuEntity;
import com.breeze.cloud.admin.entity.SysMenuRoleEntity;
import com.breeze.cloud.admin.entity.SysPlatformEntity;
import com.breeze.cloud.admin.mapper.SysMenuMapper;
import com.breeze.cloud.admin.service.SysMenuRoleService;
import com.breeze.cloud.admin.service.SysMenuService;
import com.breeze.cloud.admin.service.SysPlatformService;
import com.breeze.cloud.core.Result;
import com.breeze.cloud.security.domain.BreezeLoginUser;
import com.breeze.cloud.security.utils.SecurityUtils;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@Service
@Slf4j
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenuEntity> implements SysMenuService {

    @Autowired
    private SysPlatformService platformService;

    @Autowired
    private SysMenuRoleService menuRoleService;

    @Override
    public String[] listUserMenuPermission(List<SysUserRoleDTO> roleDTOList) {
        return this.baseMapper.listUserMenuPermission(roleDTOList);
    }

    @Override
    public Result menuTree(String platformCode) {
        BreezeLoginUser breezeLoginUser = SecurityUtils.getBreezeLoginUser();
        log.info("用户信息 ===> {}", JSONUtil.parse(breezeLoginUser));
        List<SysMenuRoleEntity> menuRoleList = this.menuRoleService.list(Wrappers.<SysMenuRoleEntity>lambdaQuery()
                .in(SysMenuRoleEntity::getRoleId, breezeLoginUser.getUserRoleIds()));
        if (CollUtil.isEmpty(menuRoleList)) {
            return Result.ok();
        }
        SysPlatformEntity platformEntity = this.platformService.getOne(Wrappers.<SysPlatformEntity>lambdaQuery().eq(SysPlatformEntity::getPlatformCode, platformCode));
        if (Objects.isNull(platformEntity)) {
            return Result.ok();
        }
        List<Long> menuIdList = menuRoleList.stream().map(SysMenuRoleEntity::getMenuId).collect(Collectors.toList());
        List<SysMenuEntity> menuList = this.list(Wrappers.<SysMenuEntity>lambdaQuery()
                .in(SysMenuEntity::getId, menuIdList)
                .eq(SysMenuEntity::getPlatformId, platformEntity.getId())
                .orderByAsc(SysMenuEntity::getSort));
        if (CollUtil.isEmpty(menuList)) {
            return Result.ok();
        }
        List<TreeNode<Long>> collect = menuList.stream().map(menu -> {
            TreeNode<Long> node = new TreeNode<>();
            node.setId(menu.getId());
            node.setName(menu.getName());
            node.setParentId(menu.getParentId());
            node.setWeight(menu.getSort());
            Map<String, Object> leafMap = Maps.newHashMap();
            leafMap.put("title", menu.getTitle());
            leafMap.put("path", menu.getPath());
            leafMap.put("url", menu.getUrl());
            leafMap.put("visible", menu.getVisible());
            leafMap.put("icon", menu.getIcon());
            node.setExtra(leafMap);
            return node;
        }).collect(Collectors.toList());
        List<Tree<Long>> build = TreeUtil.build(collect, 0L);
        return Result.ok(build);
    }
}
