/*
 * Copyright 2021 the original author or authors.
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

package com.breeze.cloud.security.config;

import cn.hutool.core.collection.CollUtil;
import com.breeze.cloud.security.domain.CurrentLoginUser;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.token.UserAuthenticationConverter;
import org.springframework.util.StringUtils;

import java.util.*;

/**
 * @author breeze
 * @date 2022/02/26
 */
public class BreezeDefaultUserAuthenticationConverter implements UserAuthenticationConverter {

    @Override
    public Map<String, ?> convertUserAuthentication(Authentication userAuthentication) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put(USERNAME, userAuthentication.getName());
        if (CollUtil.isNotEmpty(userAuthentication.getAuthorities())) {
            resultMap.put(AUTHORITIES, AuthorityUtils.authorityListToSet(userAuthentication.getAuthorities()));
        }
        return resultMap;
    }

    @Override
    public Authentication extractAuthentication(Map<String, ?> map) {
        if (!map.containsKey(USERNAME)) {
            return SecurityContextHolder.getContext().getAuthentication();
        }

        Object currentLoginUser = map.get("currentLoginUser");
        if (Objects.isNull(currentLoginUser)){
            return SecurityContextHolder.getContext().getAuthentication();
        }

        Map<String, Object> userMap = (LinkedHashMap) currentLoginUser;
        // 用户名
        String username = String.valueOf(map.get(USERNAME));
        // 权限信息
        Collection<? extends GrantedAuthority> authorities = getAuthorities(map);
        // 构造方法创建
        CurrentLoginUser user = new CurrentLoginUser(username, "N/A", true, true, true, true, authorities);
        // 用户编码
        user.setUserCode(String.valueOf(userMap.get("userCode")));
        // 账户名
        user.setAmountName(String.valueOf(userMap.get("amountName")));
        // 部门名称
        user.setDeptName(String.valueOf(userMap.get("deptName")));

        // 用户ID
        Object userId = userMap.get("userId");
        if (Objects.nonNull(userId)) {
            user.setUserId(Long.valueOf(userId.toString()));
        }

        // 部门ID
        Object deptId = userMap.get("deptId");
        if (Objects.nonNull(deptId)) {
            user.setDeptId(Long.valueOf(deptId.toString()));
        }

        // 用户角色ID
        Object userRoleIds = userMap.get("userRoleIds");
        if (Objects.nonNull(userRoleIds)) {
            user.setUserRoleIds((ArrayList) userRoleIds);
        }

        // 用户角色编码
        Object userRoleCodes = userMap.get("userRoleCodes");
        if (Objects.nonNull(userRoleCodes)) {
            user.setUserRoleCodes((ArrayList) userMap.get("userRoleCodes"));
        }
        return new UsernamePasswordAuthenticationToken(user, "N/A", authorities);
    }

    private Collection<? extends GrantedAuthority> getAuthorities(Map<String, ?> map) {
        Object authorities = map.get(AUTHORITIES);
        if (authorities instanceof Collection) {
            String grantedAuthorityString = StringUtils.collectionToCommaDelimitedString((Collection<?>) authorities);
            return AuthorityUtils.commaSeparatedStringToAuthorityList(grantedAuthorityString);
        }
        if (authorities instanceof String) {
            return AuthorityUtils.commaSeparatedStringToAuthorityList((String) authorities);
        }
        return Collections.emptyList();
    }

}
