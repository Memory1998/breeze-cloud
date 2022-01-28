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

package com.breeze.cloud.security.domain;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.List;

/**
 * 登录用户的扩展类
 *
 * @author breeze
 * @date 2021/10/1
 */
public class BreezeLoginUser extends User {

    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户CODE
     */
    private String userCode;

    /**
     * 用户的角色CODE
     */
    private List<String> userCodeList;

    /**
     * 用户的角色ID
     */
    private List<Long> userRoleIdList;

    /**
     * 用户名称
     */
    private String username;

    /**
     * 部门ID
     */
    private Long deptId;

    /**
     * 部门name
     */
    private String deptName;

    /**
     * UserDetails 默认提供了：
     * 用户的权限集， 默认需要添加ROLE_ 前缀
     * 用户的加密后的密码， 不加密会使用{noop}前缀
     * 应用内唯一的用户名
     * 账户是否过期
     * 账户是否锁定
     * 凭证是否过期
     * 用户是否可用
     *
     * @param userId
     * @param userCode
     * @param userCodeList
     * @param userRoleIdList
     * @param deptId
     * @param deptName
     * @param username              用于显示用户名称
     * @param logAmount             用户登录
     * @param password
     * @param enabled
     * @param accountNonExpired
     * @param credentialsNonExpired
     * @param accountNonLocked
     * @param authorities
     */
    public BreezeLoginUser(Long userId
            , String userCode
            , List<String> userCodeList
            , List<Long> userRoleIdList
            , Long deptId
            , String deptName
            , String username
            , String logAmount
            , String password
            , boolean enabled
            , boolean accountNonExpired
            , boolean credentialsNonExpired
            , boolean accountNonLocked
            , Collection<? extends GrantedAuthority> authorities) {
        super(logAmount, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
        // 扩展自定义属性
        this.userId = userId;
        this.username = username;
        this.userCode = userCode;
        this.userCodeList = userCodeList;
        this.userRoleIdList = userRoleIdList;
        this.deptId = deptId;
        this.deptName = deptName;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public List<String> getUserCodeList() {
        return userCodeList;
    }

    public void setUserCodeList(List<String> userCodeList) {
        this.userCodeList = userCodeList;
    }

    public List<Long> getUserRoleIdList() {
        return userRoleIdList;
    }

    public void setUserRoleIdList(List<Long> userRoleIdList) {
        this.userRoleIdList = userRoleIdList;
    }

    @Override
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Long getDeptId() {
        return deptId;
    }

    public void setDeptId(Long deptId) {
        this.deptId = deptId;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }
}
