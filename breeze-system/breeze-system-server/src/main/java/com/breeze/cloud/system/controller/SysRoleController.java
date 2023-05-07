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

package com.breeze.cloud.system.controller;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.log.annotation.BreezeSysLog;
import com.breeze.cloud.log.enums.LogType;
import com.breeze.cloud.system.domain.SysPost;
import com.breeze.cloud.system.domain.SysRole;
import com.breeze.cloud.system.domain.SysRoleMenu;
import com.breeze.cloud.system.params.MenuPermissionParam;
import com.breeze.cloud.system.query.RoleQuery;
import com.breeze.cloud.system.service.SysRoleMenuService;
import com.breeze.cloud.system.service.SysRoleService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

/**
 * 系统角色控制器
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
@RestController
@AllArgsConstructor
@SecurityRequirement(name = "Bearer")
@RequestMapping("/role")
@Tag(name = "系统角色管理模块", description = "SysRoleController")
public class SysRoleController {

    /**
     * 系统角色服务
     */
    private final SysRoleService sysRoleService;

    /**
     * 系统角色菜单服务
     */
    private final SysRoleMenuService sysRoleMenuService;

    /**
     * 列表
     *
     * @param roleQuery 角色查询
     * @return {@link Result}<{@link Page}<{@link SysRole}>>
     */
    @Operation(summary = "列表")
    @PostMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result<Page<SysRole>> list(@RequestBody RoleQuery roleQuery) {
        return Result.ok(this.sysRoleService.listPage(roleQuery));
    }

    /**
     * 校验角色编码是否重复
     *
     * @param roleCode 角色编码
     * @param roleId   角色ID
     * @return {@link Result}<{@link SysPost}>
     */
    @Operation(summary = "校验角色编码是否重复")
    @GetMapping("/checkRoleCode")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result<Boolean> checkRoleCode(@NotBlank(message = "角色编码不能为空") @RequestParam("roleCode") String roleCode,
                                         @RequestParam(value = "roleId", required = false) Long roleId) {
        return Result.ok(Objects.isNull(this.sysRoleService.getOne(Wrappers.<SysRole>lambdaQuery()
                .ne(Objects.nonNull(roleId), SysRole::getId, roleId)
                .eq(SysRole::getRoleCode, roleCode))));
    }

    /**
     * 获取用户角色列表
     *
     * @param userId 用户Id
     * @return {@link Result}<{@link List}<{@link Long}>>
     */
    @Operation(summary = "获取用户角色列表")
    @GetMapping("/listUserRoles")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result<List<Long>> listUserRoles(@RequestParam("userId") Long userId) {
        return Result.ok(this.sysRoleService.listUserRoles(userId));
    }

    /**
     * 获取树形权限列表
     * <p>
     * 选中数据
     *
     * @param roleId 角色id
     * @return {@link Result}<{@link List}<{@link SysRoleMenu}>>
     */
    @Operation(summary = "获取树形权限列表", description = "选中的行的回显")
    @GetMapping("/listRolesPermission")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result<List<SysRoleMenu>> listRolesPermission(@RequestParam Long roleId) {
        return Result.ok(this.sysRoleMenuService.list(Wrappers.<SysRoleMenu>lambdaQuery().eq(SysRoleMenu::getRoleId, roleId)));
    }

    /**
     * 修改权限
     *
     * @param menuPermissionParam 菜单权限参数
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "编辑权限")
    @PutMapping("/modifyPermission")
    @PreAuthorize("hasAnyAuthority('sys:role:modify')")
    @BreezeSysLog(description = "角色权限信息修改", type = LogType.EDIT)
    public Result<Boolean> modifyPermission(@Valid @RequestBody MenuPermissionParam menuPermissionParam) {
        return this.sysRoleMenuService.modifyPermission(menuPermissionParam);
    }

    /**
     * 创建
     *
     * @param sysRole 角色实体
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "保存")
    @PostMapping("/create")
    @PreAuthorize("hasAnyAuthority('sys:role:create')")
    @BreezeSysLog(description = "角色信息保存", type = LogType.SAVE)
    public Result<Boolean> save(@Valid @RequestBody SysRole sysRole) {
        return Result.ok(sysRoleService.save(sysRole));
    }

    /**
     * 修改
     *
     * @param sysRole 角色实体
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "修改")
    @PutMapping("/modify")
    @PreAuthorize("hasAnyAuthority('sys:role:modify')")
    @BreezeSysLog(description = "角色信息修改", type = LogType.EDIT)
    public Result<Boolean> modify(@Valid @RequestBody SysRole sysRole) {
        return Result.ok(sysRoleService.updateById(sysRole));
    }

    /**
     * 删除
     *
     * @param ids id
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "删除")
    @DeleteMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:role:delete')")
    @BreezeSysLog(description = "角色信息删除", type = LogType.DELETE)
    public Result<Boolean> delete(@NotNull(message = "参数不能为空") @RequestBody Long[] ids) {
        return sysRoleService.deleteByIds(Arrays.asList(ids));
    }

}
