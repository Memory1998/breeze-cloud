package com.breeze.admin.controller;

import com.breeze.admin.entity.SysMenuEntity;
import com.breeze.admin.service.SysMenuService;
import com.breeze.core.Result;
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
@Api(tags = "模块")
@RestController
@RequestMapping("/sys/menu")
public class SysMenuController {

    @Autowired
    private SysMenuService sysMenuService;

    /**
     * 列表
     */
    @ApiOperation(value = "列表")
    @RequestMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return Result.ok();
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result info(@PathVariable("id") Long id) {
        SysMenuEntity sysMenu = sysMenuService.getById(id);
        return Result.ok();
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result<Boolean> save(@RequestBody SysMenuEntity sysMenu) {
        sysMenuService.save(sysMenu);
        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result<Boolean> update(@RequestBody SysMenuEntity sysMenu) {
        sysMenuService.updateById(sysMenu);
        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:menu:list')")
    public Result<Boolean> delete(@RequestBody Long[] ids) {
        sysMenuService.removeByIds(Arrays.asList(ids));
        return Result.ok();
    }

}
