package com.breeze.cloud.admin.controller;

import com.breeze.cloud.admin.entity.SysMenuRoleEntity;
import com.breeze.cloud.admin.service.SysMenuRoleService;
import com.breeze.cloud.core.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@RestController
@RequestMapping("/sys/menuRole")
public class SysMenuRoleController {

    @Autowired
    private SysMenuRoleService sysMenuRoleService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:menuRole:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return Result.ok();
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:menuRole:list')")
    public Result info(@PathVariable("id") Long id) {
        SysMenuRoleEntity sysMenuRole = sysMenuRoleService.getById(id);
        return null;
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:menuRole:list')")
    public Result save(@RequestBody SysMenuRoleEntity sysMenuRole) {
        sysMenuRoleService.save(sysMenuRole);
        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:menuRole:list')")
    public Result update(@RequestBody SysMenuRoleEntity sysMenuRole) {
        sysMenuRoleService.updateById(sysMenuRole);
        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:menuRole:list')")
    public Result delete(@RequestBody Long[] ids) {
        sysMenuRoleService.removeByIds(Arrays.asList(ids));
        return Result.ok();
    }

}
