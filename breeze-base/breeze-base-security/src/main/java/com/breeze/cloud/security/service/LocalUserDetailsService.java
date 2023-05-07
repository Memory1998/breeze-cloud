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

package com.breeze.cloud.security.service;

import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.security.ext.CurrentLoginUser;
import com.breeze.cloud.system.client.SysUserFeign;
import com.breeze.cloud.system.dto.LoginUser;
import com.breeze.cloud.system.params.AuthLoginParam;
import com.breeze.cloud.system.params.WxLoginParam;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;

/**
 * 本地用户详细信息服务
 *
 * @author gaoweixuan
 * @date 2023-04-19
 */
@AllArgsConstructor
public class LocalUserDetailsService implements UserDetailsService {

    private SysUserFeign sysUserFeign;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Result<LoginUser> loginUserResult = this.sysUserFeign.loadUserByUsername(username, "1");
        return this.getLoginUserInfo(loginUserResult);
    }

    /**
     * 加载用户通过电子邮件
     *
     * @param email 电子邮件
     * @return {@link UserDetails}
     */
    public UserDetails loadUserByEmail(String email) {
        Result<LoginUser> loginUserResult = this.sysUserFeign.loadUserByEmail(email);
        return this.getLoginUserInfo(loginUserResult);
    }

    public UserDetails loadUserByPhone(String phone) {
        Result<LoginUser> loginUserResult = this.sysUserFeign.loadUserByPhone(phone, "1");
        return this.getLoginUserInfo(loginUserResult);
    }

    public UserDetails loadCreateUserByPhone(String phone) {
        Result<LoginUser> loginUserResult = this.sysUserFeign.loadCreateUserByPhone(phone);
        return this.getLoginUserInfo(loginUserResult);
    }

    public UserDetails loadCreateUserByOpenId(WxLoginParam wxLoginParam) {
        Result<LoginUser> loginUserResult = this.sysUserFeign.loadCreateUserByOpenId(wxLoginParam);
        return this.getLoginUserInfo(loginUserResult);
    }

    public UserDetails loadCreateAuthUserByPhone(AuthLoginParam authLoginParam) {
        Result<LoginUser> loginUserResult = this.sysUserFeign.loadCreateAuthUserByPhone(authLoginParam);
        return this.getLoginUserInfo(loginUserResult);
    }

    private CurrentLoginUser getLoginUserInfo(Result<LoginUser> loginUserResult) {
        LoginUser loginUser = loginUserResult.getData();
        if (loginUser == null) {
            throw new UsernameNotFoundException("用户不存在");
        }
        return this.convertResponseUserData(loginUser);
    }

    /**
     * 获取登录用户
     *
     * @param loginUser 登录用户
     * @return {@link CurrentLoginUser}
     */
    public CurrentLoginUser convertResponseUserData(LoginUser loginUser) {
        List<GrantedAuthority> authorities = Lists.newArrayList();
        Optional.ofNullable(loginUser.getAuthorities()).ifPresent(auth -> getAuthorityList(auth, authorities));
        Optional.ofNullable(loginUser.getUserRoleCodes()).ifPresent(roleCode -> getAuthorityList(roleCode, authorities));
        return new CurrentLoginUser(loginUser,
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
    private void getAuthorityList(Set<String> auth, List<GrantedAuthority> authorities) {
        authorities.addAll(AuthorityUtils.createAuthorityList(auth.toArray(new String[0])));
    }

}
