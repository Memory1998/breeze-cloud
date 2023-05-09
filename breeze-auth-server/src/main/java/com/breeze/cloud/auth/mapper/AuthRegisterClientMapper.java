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

package com.breeze.cloud.auth.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.cloud.auth.domain.AuthRegisteredClient;
import com.breeze.cloud.auth.querys.RegisterClientQuery;
import com.breeze.cloud.mybatis.mapper.BreezeBaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.oauth2.server.authorization.client.RegisteredClient;

/**
 * 身份验证注册客户端映射器
 *
 * @author gaoweixuan
 * @date 2023/05/09
 */
@Mapper
public interface AuthRegisterClientMapper extends BreezeBaseMapper<AuthRegisteredClient> {

    /**
     * 列表页面
     *
     * @param page 页面
     * @return {@link Page}<{@link AuthRegisteredClient}>
     */
    Page<AuthRegisteredClient> listPage(@Param("page") Page page);

    /**
     * 更新
     *
     * @param registeredClient 注册客户端
     */
    void update(RegisteredClient registeredClient);

    /**
     * 插入
     *
     * @param registeredClient 注册客户端
     */
    void insert(RegisteredClient registeredClient);

    /**
     * 得到注册客户端
     *
     * @param registeredClient 注册客户端
     * @return {@link AuthRegisteredClient}
     */
    AuthRegisteredClient getRegisteredClientBy(@Param("registeredClient") RegisterClientQuery registeredClient);

}
