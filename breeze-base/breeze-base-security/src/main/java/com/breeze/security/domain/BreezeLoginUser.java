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

package com.breeze.security.domain;

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
     * 主体名称
     */
    private String mainName;

    /**
     * 部门ID
     */
    private Long deptId;

    /**
     * 部门name
     */
    private String deptName;

    /**
     * @param userId
     * @param userCode
     * @param userCodeList
     * @param userRoleIdList
     * @param mainName
     * @param deptId
     * @param deptName
     * @param username
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
            , String mainName
            , Long deptId
            , String deptName
            , String username
            , String password
            , boolean enabled
            , boolean accountNonExpired
            , boolean credentialsNonExpired
            , boolean accountNonLocked
            , Collection<? extends GrantedAuthority> authorities) {
        super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
        // 扩展自定义属性
        this.userId = userId;
        this.userCode = userCode;
        this.userCodeList = userCodeList;
        this.userRoleIdList = userRoleIdList;
        this.mainName = mainName;
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

    public String getMainName() {
        return mainName;
    }

    public void setMainName(String mainName) {
        this.mainName = mainName;
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
