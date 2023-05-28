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

import cn.hutool.core.util.StrUtil;
import com.breeze.cloud.auth.domain.UserPrincipal;
import com.breeze.cloud.auth.exception.NotSupportException;
import com.breeze.cloud.core.base.BaseLoginUser;
import com.breeze.cloud.core.utils.Result;
import com.google.common.collect.Lists;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;

/**
 * 用户服务接口
 *
 * @author gaoweixuan
 * @date 2023/05/09
 */
public interface IUserDetailService extends UserDetailsService {

    /**
     * 加载用户通过电话
     *
     * @param phone 电话
     * @return {@link UserPrincipal}
     */
    UserPrincipal loadUserByPhone(String phone);

    /**
     * 加载用户通过电子邮件
     *
     * @param email 电子邮件
     * @return {@link UserPrincipal}
     */
    UserPrincipal loadUserByEmail(String email);

    /**
     * 获取登录用户信息
     *
     * @param loginUserResult 登录用户结果
     * @return {@link UserPrincipal}
     */
    default UserPrincipal getLoginUserInfo(Result<BaseLoginUser> loginUserResult) {
        BaseLoginUser baseLoginUser = loginUserResult.getData();
        if (baseLoginUser == null) {
            throw new UsernameNotFoundException("用户不存在");
        }
        return this.convertResponseUserData(baseLoginUser);
    }

    /**
     * 获取登录用户
     *
     * @param baseLoginUser 登录用户
     * @return {@link UserPrincipal}
     */
    default UserPrincipal convertResponseUserData(BaseLoginUser baseLoginUser) {
        List<GrantedAuthority> authorities = Lists.newArrayList();
        // 保存权限信息
        Optional.ofNullable(baseLoginUser.getAuthorities()).ifPresent(auth -> getAuthorityList(auth, authorities));
        // 保存角色信息
        Optional.ofNullable(baseLoginUser.getUserRoleCodes()).ifPresent(roleCode -> getAuthorityList(roleCode, authorities));
        return new UserPrincipal(
                baseLoginUser.getUsername(),
                baseLoginUser.getPassword(),
                Objects.equals(baseLoginUser.getIsLock(), 0),
                true,
                true,
                Objects.equals(baseLoginUser.getIsLock(), 0),
                authorities,
                baseLoginUser.getId(),
                baseLoginUser.getDeptId(),
                baseLoginUser.getDeptName(),
                baseLoginUser.getUserCode(),
                baseLoginUser.getAmountName(),
                baseLoginUser.getAvatar(),
                baseLoginUser.getPhone(),
                baseLoginUser.getSex(),
                baseLoginUser.getIdCard(),
                baseLoginUser.getAmountType(),
                baseLoginUser.getIsLock(),
                baseLoginUser.getOpenId(),
                baseLoginUser.getEmail(),
                baseLoginUser.getUserRoleCodes(),
                baseLoginUser.getUserRoleIds(),
                baseLoginUser.getTenantId(),
                baseLoginUser.getPermissions());
    }

    /**
     * 获取请求租户Id参数
     *
     * @return {@link String}
     */
    default String getTenantId() {
        ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        assert requestAttributes != null;
        HttpServletRequest contextRequest = requestAttributes.getRequest();
        String tenantIdHeader = contextRequest.getHeader("tenantId");
        if (StrUtil.isAllNotBlank(tenantIdHeader)) {
            return tenantIdHeader;
        }
        String tenantIdParam = contextRequest.getParameter("tenantId");
        if (StrUtil.isAllNotBlank(tenantIdParam)) {
            return tenantIdParam;
        }
        throw new NotSupportException("tenantId Not Found");
    }

    /**
     * 获得权限列表
     *
     * @param auth        身份验证
     * @param authorities 当局
     */
    default void getAuthorityList(Set<String> auth, List<GrantedAuthority> authorities) {
        authorities.addAll(AuthorityUtils.createAuthorityList(auth.toArray(new String[0])));
    }

}
