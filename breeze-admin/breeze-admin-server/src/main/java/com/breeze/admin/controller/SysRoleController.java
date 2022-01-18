package com.breeze.admin.controller;

import com.breeze.admin.entity.SysRoleEntity;
import com.breeze.admin.service.SysRoleService;
import com.breeze.core.Result;
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
@RequestMapping("/sys/role")
public class SysRoleController {
    @Autowired
    private SysRoleService sysRoleService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return Result.ok();
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result info(@PathVariable("id") Long id) {
        SysRoleEntity sysRole = sysRoleService.getById(id);
        return Result.ok();
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result save(@RequestBody SysRoleEntity sysRole) {
        sysRoleService.save(sysRole);
        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result update(@RequestBody SysRoleEntity sysRole) {
        sysRoleService.updateById(sysRole);
        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result delete(@RequestBody Long[] ids) {
        sysRoleService.removeByIds(Arrays.asList(ids));
        return Result.ok();
    }

}
