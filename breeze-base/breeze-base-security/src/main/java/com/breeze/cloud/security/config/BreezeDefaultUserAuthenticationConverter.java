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
import com.breeze.cloud.security.domain.BreezeLoginUser;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
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
        if (map.containsKey(USERNAME)) {
            Collection<? extends GrantedAuthority> authorities = getAuthorities(map);
            String username = String.valueOf(map.get(USERNAME));
            Map<String, Object> userMap = (LinkedHashMap) map.get("breezeLoginUser");
            Long userId = Long.valueOf(userMap.get("userId").toString());
            String userCode = String.valueOf(userMap.get("userCode"));
            List<String> userRoleCodes = (ArrayList) userMap.get("userRoleCodes");
            List<String> userRoleIds = (ArrayList) userMap.get("userRoleIds");
            String amountName = (String) userMap.get("amountName");
            Long deptId = Long.valueOf(userMap.get("deptId").toString());
            String deptName = (String) userMap.get("deptName");
            BreezeLoginUser user = new BreezeLoginUser(
                    userId,
                    userCode,
                    userRoleCodes,
                    userRoleIds,
                    deptId,
                    deptName,
                    username,
                    "N/A",
                    amountName,
                    true, true, true, true,
                    authorities);
            return new UsernamePasswordAuthenticationToken(user, "N/A", authorities);
        }
        return null;
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
