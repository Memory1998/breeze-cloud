package com.breeze.cloud.admin.controller;

import com.breeze.cloud.admin.entity.SysRoleUserEntity;
import com.breeze.cloud.admin.service.SysRoleUserService;
import com.breeze.cloud.core.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
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
@Api(tags = "用户角色管理", value = "SysRoleUserController")
@RequestMapping("/sys/roleUser")
public class SysRoleUserController {
    @Autowired
    private SysRoleUserService sysRoleUserService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @ApiOperation(value = "列表", notes = "列表", position = 1)
    @PreAuthorize("hasAnyAuthority('sys:roleUser:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return Result.ok();
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:roleUser:list')")
    public Result info(@PathVariable("id") Long id) {
        SysRoleUserEntity sysRoleUser = sysRoleUserService.getById(id);
        return Result.ok();
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:roleUser:list')")
    public Result save(@RequestBody SysRoleUserEntity sysRoleUser) {
        sysRoleUserService.save(sysRoleUser);
        return null;
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:roleUser:list')")
    public Result update(@RequestBody SysRoleUserEntity sysRoleUser) {
        sysRoleUserService.updateById(sysRoleUser);
        return null;
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:roleUser:list')")
    public Result delete(@RequestBody Long[] ids) {
        sysRoleUserService.removeByIds(Arrays.asList(ids));
        return null;
    }

}
