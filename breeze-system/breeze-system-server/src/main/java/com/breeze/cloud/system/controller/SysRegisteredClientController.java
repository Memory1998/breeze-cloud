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
import com.breeze.cloud.system.params.RegisteredClientParam;
import com.breeze.cloud.system.params.ResetClientSecretParam;
import com.breeze.cloud.system.query.RegisterClientQuery;
import com.breeze.cloud.system.service.SysRegisterClientService;
import com.breeze.cloud.system.vo.RegisteredClientVO;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
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
@RequiredArgsConstructor
@SecurityRequirement(name = "Bearer")
@RequestMapping("/client")
@Tag(name = "auth客户端注册模块", description = "AuthRegisteredClientController")
public class SysRegisteredClientController {

    /**
     * 客户端注册服务
     */
    private final SysRegisterClientService sysRegisterClientService;

    /**
     * 列表
     *
     * @param registerClientQuery 客户端查询
     * @return {@link Result}<{@link Page}<{@link RegisteredClientVO}>>
     */
    @Operation(summary = "列表", description = "分页")
    @GetMapping
    @PreAuthorize("hasAnyAuthority('sys:client:list')")
    public Result<Page<RegisteredClientVO>> list(RegisterClientQuery registerClientQuery) {
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
     * 通过id获取客户端
     *
     * @param clientId 客户端ID
     * @return {@link SysRegisteredClient}
     */
    @JumpAuth
    @Operation(summary = "通过clientId获取客户端")
    @GetMapping("/info/{clientId}")
    public Result<RegisteredClientVO> info(@PathVariable("clientId") Long clientId) {
        return Result.ok(this.sysRegisterClientService.info(clientId));
    }

    /**
     * 保存
     *
     * @param registeredClientParam 注册客户端参数
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "保存")
    @PostMapping
    @PreAuthorize("hasAnyAuthority('sys:client:create')")
    @BreezeSysLog(description = "客户端信息保存", type = LogType.SAVE)
    public Result<Boolean> save(@Valid @RequestBody RegisteredClientParam registeredClientParam) {
        return this.sysRegisterClientService.saveRegisteredClient(registeredClientParam);
    }

    /**
     * 修改
     *
     * @param registeredClientParam 注册客户端参数
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "修改")
    @PutMapping
    @PreAuthorize("hasAnyAuthority('sys:client:modify')")
    @BreezeSysLog(description = "客户端信息修改", type = LogType.EDIT)
    public Result<Boolean> modify(@Valid @RequestBody RegisteredClientParam registeredClientParam) {
        return Result.ok(this.sysRegisterClientService.update(registeredClientParam));
    }

    /**
     * 删除
     *
     * @param ids id数组
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "删除")
    @DeleteMapping
    @PreAuthorize("hasAnyAuthority('sys:client:delete')")
    @BreezeSysLog(description = "客户端信息删除", type = LogType.DELETE)
    public Result<Boolean> delete(@NotNull(message = "参数不能为空") @RequestBody Long[] ids) {
        return this.sysRegisterClientService.deleteById(Arrays.asList(ids));
    }

    /**
     * 重置密钥
     *
     * @param resetClientSecretParam 重置客户端密钥
     * @return {@link Result}<{@link Boolean}>
     */
    @Operation(summary = "重置密钥")
    @PutMapping("/resetClientSecret")
    @PreAuthorize("hasAnyAuthority('sys:client:resetClientSecret')")
    @BreezeSysLog(description = "重置密钥", type = LogType.EDIT)
    public Result<Boolean> resetClientSecret(@Valid @RequestBody ResetClientSecretParam resetClientSecretParam) {
        return Result.ok(this.sysRegisterClientService.resetClientSecretParam(resetClientSecretParam));
    }
}
