package com.breeze.cloud.admin.controller;

import com.breeze.cloud.admin.entity.OauthClientDetailsEntity;
import com.breeze.cloud.admin.service.OauthClientDetailsService;
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
    private OauthClientDetailsService oauthClientDetailsService;

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
    public OauthClientDetailsEntity info(@PathVariable("clientId") String clientId) {
        return this.oauthClientDetailsService.getById(clientId);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:oauth:save')")
    public Result save(@RequestBody OauthClientDetailsEntity oauth) {
        this.oauthClientDetailsService.save(oauth);
        return null;
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:oauth:update')")
    public Result update(@RequestBody OauthClientDetailsEntity oauth) {
        this.oauthClientDetailsService.updateById(oauth);
        return null;
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:oauth:delete')")
    public Result delete(@RequestBody String[] clientIds) {
        this.oauthClientDetailsService.removeByIds(Arrays.asList(clientIds));
        return null;
    }

}
