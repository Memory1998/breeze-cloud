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

package com.breeze.cloud.security.utils;

import com.breeze.cloud.security.domain.CurrentLoginUser;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.List;
import java.util.Objects;

/**
 * @author breeze
 * @date 2022/02/07
 */
public class SecurityUtils {

    /**
     * 获取Authentication
     *
     * @return Authentication
     */
    public static Authentication getAuthentication() {
        return SecurityContextHolder.getContext().getAuthentication();
    }

    /**
     * 获取当前登录者对象
     */
    public static CurrentLoginUser getBreezeLoginUser() {
        Authentication authentication = getAuthentication();
        Object principal = authentication.getPrincipal();
        if (Objects.isNull(principal)) {
            throw new RuntimeException("用户没有登录");
        }

        if (principal instanceof CurrentLoginUser) {
            return (CurrentLoginUser) principal;
        }
        return null;
    }

    /**
     * 获取当前登录者的权限集CODE
     *
     * @return UserRoleCodeList
     */
    public static List<String> getUserRoleCodes() {
        return Objects.requireNonNull(getBreezeLoginUser()).getUserRoleCodes();
    }

    /**
     * 获取当前登录者的权限集ID
     *
     * @return UserRoleIdList
     */
    public static List<String> getUserRoleIds() {
        return Objects.requireNonNull(getBreezeLoginUser()).getUserRoleIds();
    }

    /**
     * 获取用户编码
     *
     * @return userCode
     */
    public String getUserCode() {
        return Objects.requireNonNull(getBreezeLoginUser()).getUserCode();
    }

    /**
     * 获取用户ID
     *
     * @return userId
     */
    public Long getUserId() {
        return Objects.requireNonNull(getBreezeLoginUser()).getUserId();
    }

}
