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

package com.breeze.cloud.system.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.system.domain.SysRegisteredClient;
import com.breeze.cloud.system.mapper.SysRegisterClientMapper;
import com.breeze.cloud.system.params.RegisteredClientParams;
import com.breeze.cloud.system.query.RegisterClientQuery;
import com.breeze.cloud.system.service.ISysRegisterClientService;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import java.util.List;
import java.util.Objects;

/**
 * 重写auth注册客户端库
 *
 * @author gaoweixuan
 * @date 2023/05/09
 */
@Slf4j
@Service
public class SysRegisterClientService extends ServiceImpl<SysRegisterClientMapper, SysRegisteredClient> implements ISysRegisterClientService {

    /**
     * 密码编码器
     */
    private final PasswordEncoder passwordEncoder;

    private final ObjectMapper mapper = new ObjectMapper();

    public SysRegisterClientService(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * 列表页面
     *
     * @param registerClientQuery 注册客户端参数
     * @return {@link Page}<{@link SysRegisteredClient}>
     */
    public Page<SysRegisteredClient> listPage(RegisterClientQuery registerClientQuery) {
        return this.baseMapper.listPage(new Page<>(registerClientQuery.getCurrent(), registerClientQuery.getSize()), registerClientQuery);
    }

    /**
     * 保存
     *
     * @param registeredClientParams 注册客户端参数
     */
    @SneakyThrows
    @Override
    public Result<Boolean> saveRegisteredClient(RegisteredClientParams registeredClientParams) {
        Assert.notNull(registeredClientParams, "registeredClient cannot be null");

        RegisteredClientParams.ClientSettings clientSettings = registeredClientParams.getClientSettings();
        Assert.notNull(clientSettings, "clientSettings cannot be null");

        RegisteredClientParams.TokenSettings tokenSettings = registeredClientParams.getTokenSettings();
        Assert.notNull(tokenSettings, "tokenSettings cannot be null");
        SysRegisteredClient byClientId = this.getByClientId(registeredClientParams.getClientId());
        if (Objects.nonNull(byClientId)) {
            return Result.fail(Boolean.FALSE, "已经存在此客户端");
        }
        this.insertRegisteredClient(registeredClientParams);
        return Result.ok();
    }

    /**
     * 更新
     *
     * @param registeredClientParams 注册客户端参数
     * @return {@link Boolean}
     */
    @Override
    public Boolean update(RegisteredClientParams registeredClientParams) {
        this.updateRegisteredClient(registeredClientParams);
        return Boolean.TRUE;
    }

    /**
     * 插入注册客户端
     *
     * @param registeredClientParams 注册客户端
     */
    @SneakyThrows
    private void insertRegisteredClient(RegisteredClientParams registeredClientParams) {
        // @formatter:off
        this.save(SysRegisteredClient.builder()
                .clientId(registeredClientParams.getClientId())
                .clientName(registeredClientParams.getClientName())
                .clientSecret(this.passwordEncoder.encode("{bcrypt}" + registeredClientParams.getClientSecret()))
                .clientIdIssuedAt(registeredClientParams.getClientIdIssuedAt())
                .clientSecretExpiresAt(registeredClientParams.getClientSecretExpiresAt())
                .clientSettings(mapper.writeValueAsString(registeredClientParams.getClientSettings()))
                .tokenSettings(mapper.writeValueAsString(registeredClientParams.getTokenSettings()))
                .clientAuthenticationMethods(String.join(",", registeredClientParams.getClientAuthenticationMethods()))
                .scopes(String.join(",", registeredClientParams.getScopes()))
                .authorizationGrantTypes(String.join(",", registeredClientParams.getAuthorizationGrantTypes()))
                .redirectUris(String.join(",", registeredClientParams.getRedirectUris()))
                .build());
        // @formatter:on
    }

    /**
     * 更新注册客户端
     *
     * @param registeredClientParams 注册客户端参数
     */
    @SneakyThrows
    private void updateRegisteredClient(RegisteredClientParams registeredClientParams) {
        // @formatter:off
        this.updateById(SysRegisteredClient.builder()
                .id(registeredClientParams.getId())
                .clientId(registeredClientParams.getClientId())
                .clientName(registeredClientParams.getClientName())
                .clientSecret(this.passwordEncoder.encode("{bcrypt}" + registeredClientParams.getClientSecret()))
                .clientIdIssuedAt(registeredClientParams.getClientIdIssuedAt())
                .clientSecretExpiresAt(registeredClientParams.getClientSecretExpiresAt())
                .clientSettings(mapper.writeValueAsString(registeredClientParams.getClientSettings()))
                .tokenSettings(mapper.writeValueAsString(registeredClientParams.getTokenSettings()))
                .clientAuthenticationMethods(String.join(",", registeredClientParams.getClientAuthenticationMethods()))
                .scopes(String.join(",", registeredClientParams.getScopes()))
                .authorizationGrantTypes(String.join(",", registeredClientParams.getAuthorizationGrantTypes()))
                .redirectUris(String.join(",", registeredClientParams.getRedirectUris()))
                .build());
        // @formatter:on
    }

    /**
     * 获取客户端由客户端id
     *
     * @param clientId 客户端id
     * @return {@link SysRegisteredClient}
     */
    @Override
    public SysRegisteredClient getByClientId(String clientId) {
        return this.baseMapper.getRegisteredClientBy(RegisterClientQuery.builder().clientId(clientId).build());
    }

    /**
     * 获取客户端通过id
     *
     * @param id id
     * @return {@link SysRegisteredClient}
     */
    @Override
    public SysRegisteredClient getById(String id) {
        return this.baseMapper.getRegisteredClientBy(RegisterClientQuery.builder().id(id).build());
    }

    /**
     * 删除通过id
     *
     * @param ids id集合
     * @return {@link Result}<{@link Boolean}>
     */
    @Override
    public Result<Boolean> deleteById(List<Long> ids) {
        return Result.ok(this.removeBatchByIds(ids));
    }

}
