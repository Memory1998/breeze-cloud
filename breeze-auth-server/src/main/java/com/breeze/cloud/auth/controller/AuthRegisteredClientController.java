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

package com.breeze.cloud.auth.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.cloud.auth.domain.AuthRegisteredClient;
import com.breeze.cloud.auth.querys.RegisterClientQuery;
import com.breeze.cloud.auth.service.IAuthRegisterClientService;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.log.annotation.BreezeSysLog;
import com.breeze.cloud.log.enums.LogType;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.AllArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClient;
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
public class AuthRegisteredClientController {

    /**
     * 客户端注册服务
     */
    private final IAuthRegisterClientService authRegisterClientService;

    /**
     * 列表
     *
     * @return {@link Result}<{@link Page}<{@link RegisteredClient}>>
     */
    @Operation(summary = "列表", description = "分页")
    @GetMapping
    @PreAuthorize("hasAnyAuthority('auth:client:list')")
    public Result<Page<AuthRegisteredClient>> list(RegisterClientQuery registerClientQuery) {
        return Result.ok(this.authRegisterClientService.listPage(registerClientQuery));
    }

    /**
     * 保存
     *
     * @param registeredClient 注册客户端
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "保存")
    @PostMapping
    @PreAuthorize("hasAnyAuthority('auth:client:create')")
    @BreezeSysLog(description = "客户端信息保存", type = LogType.SAVE)
    public Result<Boolean> save(@Valid @RequestBody AuthRegisteredClient registeredClient) {
        return Result.ok(this.authRegisterClientService.save(registeredClient));
    }

    /**
     * 修改
     *
     * @param registeredClient 注册客户端
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "修改")
    @PutMapping
    @PreAuthorize("hasAnyAuthority('auth:client:modify')")
    @BreezeSysLog(description = "客户端信息修改", type = LogType.EDIT)
    public Result<Boolean> modify(@Valid @RequestBody AuthRegisteredClient registeredClient) {
        return Result.ok(this.authRegisterClientService.updateById(registeredClient));
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
        return this.authRegisterClientService.deleteById(Arrays.asList(ids));
    }

}
