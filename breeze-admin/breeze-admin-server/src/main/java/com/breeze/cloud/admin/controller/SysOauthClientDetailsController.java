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

package com.breeze.cloud.admin.controller;

import com.breeze.cloud.admin.entity.SysOauthClientDetailsEntity;
import com.breeze.cloud.admin.service.SysOauthClientDetailsService;
import com.breeze.cloud.core.Result;
import com.breeze.cloud.security.annotation.JoinWhiteList;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.Map;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@Api(tags = "授权管理模块", value = "授权管理模块")
@RestController
@RequestMapping("/sys/oauth/")
public class SysOauthClientDetailsController {

    @Autowired
    private SysOauthClientDetailsService sysOauthClientDetailsService;

    /**
     * 列表
     */
    @GetMapping("/list")
    @PreAuthorize("hasAnyAuthority('sys:oauth:list')")
    public Result list(@RequestParam Map<String, Object> params) {
        return Result.ok(this.sysOauthClientDetailsService.list());
    }

    /**
     * 信息
     */
    @GetMapping("/info/{clientId}")
    @JoinWhiteList
    public SysOauthClientDetailsEntity info(@PathVariable("clientId") String clientId) {
        return this.sysOauthClientDetailsService.getById(clientId);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:oauth:save')")
    public Result save(@RequestBody SysOauthClientDetailsEntity oauth) {
        return Result.ok(this.sysOauthClientDetailsService.save(oauth));
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:oauth:update')")
    public Result update(@RequestBody SysOauthClientDetailsEntity oauth) {
        return Result.ok(this.sysOauthClientDetailsService.updateById(oauth));
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:oauth:delete')")
    public Result delete(@RequestBody String[] clientIds) {
        return Result.ok(this.sysOauthClientDetailsService.removeByIds(Arrays.asList(clientIds)));
    }

}
