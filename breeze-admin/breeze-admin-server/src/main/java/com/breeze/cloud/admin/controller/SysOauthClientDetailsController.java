package com.breeze.cloud.admin.controller;

import com.breeze.cloud.admin.entity.SysOauthClientDetailsEntity;
import com.breeze.cloud.admin.service.SysOauthClientDetailsService;
import com.breeze.cloud.core.Result;
import com.breeze.cloud.security.annotation.JoinWhiteList;
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
@RequestMapping("/sys/oauth/")
public class SysOauthClientDetailsController {

    @Autowired
    private SysOauthClientDetailsService sysOauthClientDetailsService;

    /**
     * 列表
     */
    @RequestMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:oauth:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return null;
    }

    /**
     * 信息
     */
    @RequestMapping("/info/{clientId}")
    @JoinWhiteList
    public SysOauthClientDetailsEntity info(@PathVariable("clientId") String clientId) {
        return this.sysOauthClientDetailsService.getById(clientId);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:oauth:save')")
    public Result save(@RequestBody SysOauthClientDetailsEntity oauth) {
        this.sysOauthClientDetailsService.save(oauth);
        return null;
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:oauth:update')")
    public Result update(@RequestBody SysOauthClientDetailsEntity oauth) {
        this.sysOauthClientDetailsService.updateById(oauth);
        return null;
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:oauth:delete')")
    public Result delete(@RequestBody String[] clientIds) {
        this.sysOauthClientDetailsService.removeByIds(Arrays.asList(clientIds));
        return null;
    }

}
