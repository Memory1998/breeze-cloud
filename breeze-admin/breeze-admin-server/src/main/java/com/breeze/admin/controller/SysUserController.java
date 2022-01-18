package com.breeze.admin.controller;

import com.breeze.admin.entity.SysUserEntity;
import com.breeze.admin.service.SysUserService;
import com.breeze.core.Result;
import com.breeze.security.annotation.JoinWhiteList;
import com.github.xiaoymin.knife4j.annotations.ApiSort;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Arrays;
import java.util.Map;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@RestController
@ApiSort(1)
@Api(tags = "用户管理", value = "SysUserController")
@RequestMapping("/sys/user")
public class SysUserController {

    @Autowired
    private SysUserService sysUserService;

    @GetMapping("/v1/getUser")
    @JoinWhiteList
    public Authentication getUser() {
        return SecurityContextHolder.getContext().getAuthentication();
    }

    @GetMapping("/v2/getUser")
    @JoinWhiteList
    @PreAuthorize("hasAnyAuthority('sys:admin')")
    public Principal getUser2(Principal principal) {
        return principal;
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return null;
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result info(@PathVariable("id") Long id) {
        SysUserEntity sysUser = sysUserService.getById(id);
        return Result.ok();
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result save(@RequestBody SysUserEntity sysUser) {
        sysUserService.save(sysUser);
        return Result.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result update(@RequestBody SysUserEntity sysUser) {
        sysUserService.updateById(sysUser);
        return Result.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:user:list')")
    public Result delete(@RequestBody Long[] ids) {
        sysUserService.removeByIds(Arrays.asList(ids));
        return Result.ok();
    }

}
