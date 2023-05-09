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

package com.breeze.cloud.auth.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.breeze.cloud.auth.domain.AuthRegisteredClient;
import com.breeze.cloud.auth.querys.RegisterClientQuery;
import com.breeze.cloud.core.utils.Result;

import java.util.List;

/**
 * auth注册客户服务接口
 *
 * @author gaoweixuan
 * @date 2023/05/09
 */
public interface IAuthRegisterClientService extends IService<AuthRegisteredClient> {

    /**
     * 列表页面
     *
     * @param registerClientQuery 注册客户端参数
     * @return {@link Page}<{@link AuthRegisteredClient}>
     */
    Page<AuthRegisteredClient> listPage(RegisterClientQuery registerClientQuery);

    /**
     * 删除通过id
     *
     * @param ids id集合
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> deleteById(List<Long> ids);

}
