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

import com.breeze.cloud.auth.doamin.UserPrincipal;
import com.breeze.cloud.auth.exception.AuthException;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.system.client.SysUserFeign;
import com.breeze.cloud.system.dto.LoginUser;
import com.google.common.collect.Lists;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;

/**
 * 用户主体服务
 *
 * @author gaoweixuan
 * @date 2023-04-21
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class UserPrincipalService implements UserDetailsService {

    /**
     * 用户假装
     */
    private final SysUserFeign userFeign;

    /**
     * 加载用户用户名
     *
     * @param username 用户名
     * @return {@link UserPrincipal}
     */
    @Override
    public UserPrincipal loadUserByUsername(String username) {
        Result<LoginUser> loginUserResult = this.userFeign.loadUserByUsername(username, this.getRequestParam());
        return getLoginUserInfo(loginUserResult);
    }

    /**
     * 获取请求参数值
     *
     * @return {@link String}
     */
    private String getRequestParam() {
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        assert requestAttributes != null;
        HttpServletRequest contextRequest = requestAttributes.getRequest();
        return contextRequest.getParameter("tenantId");
    }

    /**
     * 加载用户通过电话
     *
     * @param phone 电话
     * @return {@link UserDetails}
     */
    public UserDetails loadUserByPhone(String phone) {
        Result<LoginUser> loginUserResult = this.userFeign.loadUserByPhone(phone, this.getRequestParam());
        return this.getLoginUserInfo(loginUserResult);
    }

    /**
     * 获取登录用户信息
     *
     * @param loginUserResult 登录用户结果
     * @return {@link UserPrincipal}
     */
    private UserPrincipal getLoginUserInfo(Result<LoginUser> loginUserResult) {
        LoginUser loginUser = loginUserResult.getData();
        if (loginUser == null) {
            throw new AuthException("用户不存在");
        }
        return this.convertResponseUserData(loginUser);
    }

    /**
     * 获取登录用户
     *
     * @param loginUser 登录用户
     * @return {@link UserPrincipal}
     */
    UserPrincipal convertResponseUserData(LoginUser loginUser) {
        List<GrantedAuthority> authorities = Lists.newArrayList();
        Optional.ofNullable(loginUser.getAuthorities()).ifPresent(auth -> getAuthorityList(auth, authorities));
        Optional.ofNullable(loginUser.getUserRoleCodes()).ifPresent(roleCode -> getAuthorityList(roleCode, authorities));
        return new UserPrincipal(loginUser,
                Objects.equals(loginUser.getIsLock(), 0),
                true,
                true,
                Objects.equals(loginUser.getIsLock(), 0),
                authorities);
    }

    /**
     * 获得权限列表
     *
     * @param auth        身份验证
     * @param authorities 当局
     */
    void getAuthorityList(Set<String> auth, List<GrantedAuthority> authorities) {
        authorities.addAll(AuthorityUtils.createAuthorityList(auth.toArray(new String[0])));
    }

}
