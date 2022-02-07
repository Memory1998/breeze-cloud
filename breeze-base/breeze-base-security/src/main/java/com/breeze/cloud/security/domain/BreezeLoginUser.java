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
    private List<String> roleCodeList;

    /**
     * 用户的角色ID
     */
    private List<String> userRoleIdList;

    /**
     * 登录后显示的账户名称
     */
    private String amountName;

    /**
     * 部门ID
     */
    private Long deptId;

    /**
     * 部门name
     */
    private String deptName;

    /**
     * @param userId                用户ID
     * @param userCode              用户CODE
     * @param roleCodeList          角色CODE
     * @param userRoleIdList        角色Id
     * @param deptId                部门ID
     * @param deptName              部门名称
     * @param username              应用内唯一的用户名
     * @param amountName            用户登录账户
     * @param password              用户的加密后的密码， 不加密会使用{noop}前缀
     * @param enabled               用户是否可用
     * @param accountNonExpired     账户是否过期
     * @param credentialsNonExpired 凭证是否过期
     * @param accountNonLocked      账户是否锁定
     * @param authorities           用户的权限集， 默认需要添加ROLE_ 前缀
     */
    public BreezeLoginUser(Long userId
            , String userCode
            , List<String> roleCodeList
            , List<String> userRoleIdList
            , Long deptId
            , String deptName
            , String username
            , String amountName
            , String password
            , boolean enabled
            , boolean accountNonExpired
            , boolean credentialsNonExpired
            , boolean accountNonLocked
            , Collection<? extends GrantedAuthority> authorities) {
        super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
        // 扩展自定义属性
        this.userId = userId;
        this.amountName = amountName;
        this.userCode = userCode;
        this.roleCodeList = roleCodeList;
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

    public List<String> getRoleCodeList() {
        return roleCodeList;
    }

    public void setGetRoleCodeList(List<String> roleCodeList) {
        this.roleCodeList = roleCodeList;
    }

    public List<String> getUserRoleIdList() {
        return userRoleIdList;
    }

    public void setUserRoleIdList(List<String> userRoleIdList) {
        this.userRoleIdList = userRoleIdList;
    }

    public String getAmountName() {
        return amountName;
    }

    public void setAmountName(String amountName) {
        this.amountName = amountName;
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
