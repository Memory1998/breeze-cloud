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

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.lang.tree.Tree;
import cn.hutool.core.lang.tree.TreeNode;
import cn.hutool.core.lang.tree.TreeUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.cloud.core.base.BaseLoginUser;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.security.utils.SecurityUtils;
import com.breeze.cloud.system.domain.SysMenu;
import com.breeze.cloud.system.domain.SysRoleMenu;
import com.breeze.cloud.system.dto.UserRole;
import com.breeze.cloud.system.mapper.SysMenuMapper;
import com.breeze.cloud.system.query.MenuQuery;
import com.breeze.cloud.system.service.SysMenuService;
import com.breeze.cloud.system.service.SysRoleMenuService;
import com.google.common.collect.Maps;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

import static com.breeze.cloud.core.constants.CoreConstants.ROOT;

/**
 * 系统菜单服务impl
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements SysMenuService {

    /**
     * 系统角色菜单服务
     */
    private final SysRoleMenuService sysRoleMenuService;

    /**
     * 用户菜单权限列表
     *
     * @param userRoleList 用户角色列表
     * @return {@link Set}<{@link String}>
     */
    @Override
    public Set<String> listUserMenuPermission(Set<UserRole> userRoleList) {
        return Optional.ofNullable(this.baseMapper.listUserMenuPermission(userRoleList))
                .orElseGet(HashSet::new);
    }

    /**
     * 树菜单列表
     *
     * @param platformCode 平台代码
     * @return {@link Result}<{@link List}<{@link Tree}<{@link Long}>>>
     */
    @Override
    public Result<List<Tree<Long>>> listTreeMenu(String platformCode) {
        BaseLoginUser currentBaseLoginUser = SecurityUtils.getCurrentUser();
        if (CollUtil.isEmpty(currentBaseLoginUser.getUserRoleIds())) {
            return Result.ok();
        }

        // 查询角色下的菜单信息
        List<SysMenu> menuList = this.baseMapper.selectMenusByRoleId(currentBaseLoginUser.getUserRoleIds(), platformCode);
        return Result.ok(this.buildTrees(menuList, ROOT));
    }

    /**
     * 权限数据列表树选中数据
     *
     * @return {@link Result}<{@link List}<{@link Tree}<{@link Long}>>>
     */
    private Result<List<Tree<Long>>> listTreeRolePermission() {
        List<SysMenu> menuList = this.list(Wrappers.<SysMenu>lambdaQuery()
                .in(SysMenu::getType, 0, 1, 2)
                .orderByAsc(SysMenu::getSort));
        if (CollUtil.isEmpty(menuList)) {
            return Result.ok();
        }
        return Result.ok(this.buildTrees(menuList, ROOT));
    }

    /**
     * 菜单列表
     *
     * @param menuQuery 菜单查询
     * @return {@link Result}<{@link ?}>
     */
    @Override
    public Result<?> listMenu(MenuQuery menuQuery) {
        List<SysMenu> entityList = this.baseMapper.listMenu(menuQuery);
        if (StrUtil.isAllNotBlank(menuQuery.getName()) || StrUtil.isAllNotBlank(menuQuery.getTitle())) {
            return Result.ok(entityList);
        }
        List<Tree<Long>> build = this.buildTrees(entityList, ROOT);
        return Result.ok(build);
    }

    /**
     * 树形权限列表
     *
     * @return {@link Result}<{@link List}<{@link Tree}<{@link Long}>>>
     */
    @Override
    public Result<List<Tree<Long>>> listTreePermission() {
        BaseLoginUser currentBaseLoginUser = SecurityUtils.getCurrentUser();
        if (CollUtil.isEmpty(currentBaseLoginUser.getUserRoleIds())) {
            return Result.ok();
        }
        return this.listTreeRolePermission();
    }

    /**
     * 删除通过ID
     *
     * @param id id
     * @return {@link Result}
     */
    @Override
    public Result<Boolean> deleteById(Long id) {
        List<SysMenu> menuEntityList = this.list(Wrappers.<SysMenu>lambdaQuery().eq(SysMenu::getParentId, id));
        if (CollUtil.isNotEmpty(menuEntityList)) {
            return Result.warning(Boolean.FALSE, "存在子菜单, 不可删除");
        }
        boolean remove = this.removeById(id);
        if (remove) {
            // 删除已经关联的角色的菜单
            this.sysRoleMenuService.remove(Wrappers.<SysRoleMenu>lambdaQuery().eq(SysRoleMenu::getMenuId, id));
            return Result.ok(Boolean.TRUE, "删除成功");
        }
        return Result.fail(Boolean.FALSE, "删除失败");
    }

    /**
     * 保存菜单
     *
     * @param menuEntity 菜单实体
     * @return {@link Result}<{@link Boolean}>
     */
    @Override
    public Result<Boolean> saveMenu(SysMenu menuEntity) {
        SysMenu sysMenu = this.getById(menuEntity.getParentId());
        if (!Objects.equals(ROOT, menuEntity.getParentId()) && Objects.isNull(sysMenu)) {
            return Result.fail("上一层组件不存在");
        }
        return Result.ok(this.save(menuEntity));
    }

    /**
     * 更新菜单通过id
     *
     * @param menuEntity 菜单实体
     * @return {@link Result}<{@link Boolean}>
     */
    @Override
    public Result<Boolean> updateMenuById(SysMenu menuEntity) {
        return Result.ok(this.updateById(menuEntity));
    }

    /**
     * 获取树形数据
     *
     * @param menuEntityList 菜单实体列表
     * @param id
     * @return {@link List}<{@link Tree}<{@link Long}>>
     */
    private List<Tree<Long>> buildTrees(List<SysMenu> menuEntityList, Long id) {
        List<TreeNode<Long>> collect = menuEntityList.stream().map(menu -> {
            TreeNode<Long> node = new TreeNode<>();
            node.setId(menu.getId());
            node.setName(menu.getName());
            node.setParentId(menu.getParentId());
            node.setWeight(menu.getSort());
            Map<String, Object> leafMap = Maps.newHashMap();
            leafMap.put("title", menu.getTitle());
            leafMap.put("path", menu.getPath());
            leafMap.put("component", menu.getComponent());
            leafMap.put("icon", menu.getIcon());
            leafMap.put("platformName", menu.getPlatformName());
            leafMap.put("keepAlive", menu.getKeepAlive());
            leafMap.put("hidden", menu.getHidden());
            leafMap.put("href", menu.getHref());
            leafMap.put("permission", menu.getPermission());
            leafMap.put("platformId", menu.getPlatformId());
            leafMap.put("sort", menu.getSort());
            leafMap.put("type", menu.getType());
            node.setExtra(leafMap);
            return node;
        }).collect(Collectors.toList());
        return TreeUtil.build(collect, id);
    }
}
