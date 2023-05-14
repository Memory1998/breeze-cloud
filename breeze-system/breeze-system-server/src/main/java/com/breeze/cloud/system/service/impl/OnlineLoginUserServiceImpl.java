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

import com.breeze.cloud.system.service.OnlineLoginUserService;
import org.springframework.security.core.session.SessionRegistry;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

/**
 * @author gaoweixuan
 * @date 2023/05/14
 */
@Service
public class OnlineLoginUserServiceImpl implements OnlineLoginUserService {

    /**
     * 会话注册表
     */
    private final SessionRegistry sessionRegistry;

    public OnlineLoginUserServiceImpl() {
        this.sessionRegistry = new SessionRegistryImpl();
    }

    /**
     * 获取所有在线用户
     *
     * @return {@link List}<{@link User}>
     */
    @Override
    public List<User> listAllPrincipals() {
        List<Object> allPrincipals = this.sessionRegistry.getAllPrincipals();
        return allPrincipals.stream().map(o -> {
            if (o instanceof User) {
                return (User) o;
            }
            return null;
        }).filter(Objects::isNull).collect(Collectors.toList());
    }
}
