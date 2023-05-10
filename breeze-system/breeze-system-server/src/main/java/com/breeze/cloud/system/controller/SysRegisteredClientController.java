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

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.log.annotation.BreezeSysLog;
import com.breeze.cloud.log.enums.LogType;
import com.breeze.cloud.security.annotation.JumpAuth;
import com.breeze.cloud.system.domain.SysRegisteredClient;
import com.breeze.cloud.system.params.RegisteredClientParams;
import com.breeze.cloud.system.query.RegisterClientQuery;
import com.breeze.cloud.system.service.ISysRegisterClientService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.Arrays;


/**
 * 注册客户端控制器
 *
 * @author gaoweixuan
 * @date 2023/05/06
 */
@RestController
@AllArgsConstructor
@SecurityRequirement(name = "Bearer")
@RequestMapping("/client")
@Tag(name = "auth客户端注册模块", description = "AuthRegisteredClientController")
public class SysRegisteredClientController {

    /**
     * 客户端注册服务
     */
    private final ISysRegisterClientService sysRegisterClientService;

    /**
     * 列表
     *
     * @param registerClientQuery 客户端查询
     * @return {@link Result}<{@link Page}<{@link SysRegisteredClient}>>
     */
    @Operation(summary = "列表", description = "分页")
    @GetMapping
    @PreAuthorize("hasAnyAuthority('auth:client:list')")
    public Result<Page<SysRegisteredClient>> list(RegisterClientQuery registerClientQuery) {
        return Result.ok(this.sysRegisterClientService.listPage(registerClientQuery));
    }

    /**
     * 通过客户端id获取客户端
     *
     * @param clientId 客户端id
     * @return {@link SysRegisteredClient}
     */
    @JumpAuth
    @Operation(summary = "通过客户端id获取客户端")
    @GetMapping("/getByClientId/{clientId}")
    public SysRegisteredClient getByClientId(@PathVariable("clientId") String clientId) {
        return this.sysRegisterClientService.getByClientId(clientId);
    }

    /**
     * 通过id获取客户端
     *
     * @param id id
     * @return {@link SysRegisteredClient}
     */
    @JumpAuth
    @Operation(summary = "通过id获取客户端")
    @GetMapping("/getById/{id}")
    public SysRegisteredClient getById(@PathVariable("id") String id) {
        return this.sysRegisterClientService.getById(id);
    }

    /**
     * 保存
     *
     * @param registeredClientParams 注册客户端参数
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "保存")
    @JumpAuth
    @PostMapping
//    @PreAuthorize("hasAnyAuthority('auth:client:create')")
    @BreezeSysLog(description = "客户端信息保存", type = LogType.SAVE)
    public Result<Boolean> save(@Valid @RequestBody RegisteredClientParams registeredClientParams) {
        return this.sysRegisterClientService.saveRegisteredClient(registeredClientParams);
    }

    /**
     * 修改
     *
     * @param registeredClientParams 注册客户端参数
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "修改")
    @PutMapping
    @PreAuthorize("hasAnyAuthority('auth:client:modify')")
    @BreezeSysLog(description = "客户端信息修改", type = LogType.EDIT)
    public Result<Boolean> modify(@Valid @RequestBody RegisteredClientParams registeredClientParams) {
        return Result.ok(this.sysRegisterClientService.update(registeredClientParams));
    }

    /**
     * 删除
     *
     * @param ids id数组
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "删除")
    @DeleteMapping
    @PreAuthorize("hasAnyAuthority('auth:client:delete')")
    @BreezeSysLog(description = "客户端信息删除", type = LogType.DELETE)
    public Result<Boolean> delete(@NotNull(message = "参数不能为空") @RequestBody Long[] ids) {
        return this.sysRegisterClientService.deleteById(Arrays.asList(ids));
    }

}
