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

package com.breeze.cloud.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.breeze.cloud.core.base.BaseLoginUser;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.system.domain.SysUser;
import com.breeze.cloud.system.params.*;
import com.breeze.cloud.system.query.UserQuery;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 系统用户服务
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
public interface SysUserService extends IService<SysUser> {

    /**
     * 列表页面
     *
     * @param userQuery 用户查询
     * @return {@link IPage}<{@link SysUser}>
     */
    IPage<SysUser> listPage(UserQuery userQuery);

    /**
     * 保存用户
     *
     * @param sysUser 系统用户
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> saveUser(SysUser sysUser);

    /**
     * 通过id更新用户
     *
     * @param sysUser 系统用户
     * @return {@link Boolean}
     */
    Boolean updateUserById(SysUser sysUser);

    /**
     * 开关
     *
     * @param userOpenParam 用户打开参数
     * @return {@link Boolean}
     */
    Boolean open(UserOpenParam userOpenParam);

    /**
     * 重置密码
     *
     * @param userResetPasswordParam 用户重置密码参数
     * @return {@link Boolean}
     */
    Boolean resetPass(UserResetPasswordParam userResetPasswordParam);

    /**
     * 删除用户
     *
     * @param sysUser 用户
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> removeUser(SysUser sysUser);

    /**
     * 用户分配角色
     *
     * @param userRolesParam 用户角色参数
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> userAddRole(UserRolesParam userRolesParam);

    /**
     * 通过ID查询用户
     *
     * @param id id
     * @return {@link Result}<{@link SysUser}>
     */
    Result<SysUser> getUserById(Long id);

    /**
     * 注册用户
     *
     * @param sysUser  系统用户
     * @param roleCode 角色代码
     * @return {@link SysUser}
     */
    SysUser registerUser(SysUser sysUser, String roleCode);

    /**
     * 查询用户通过部门id
     *
     * @param deptIds 部门IDS
     * @return {@link List}<{@link SysUser}>
     */
    List<SysUser> listUserByDeptId(List<Long> deptIds);

    /**
     * 导出
     *
     * @param response 响应
     */
    void export(HttpServletResponse response);

    /**
     * 加载用户通过用户名
     *
     * @param username 用户名
     * @return {@link Result}<{@link BaseLoginUser}>
     */
    Result<BaseLoginUser> loadUserByUsername(String username);

    /**
     * 加载用户通过电话
     *
     * @param phone 电话
     * @return {@link Result}<{@link BaseLoginUser}>
     */
    Result<BaseLoginUser> loadUserByPhone(String phone);

    /**
     * 加载用户通过电子邮件
     *
     * @param email 电子邮件
     * @return {@link Result}<{@link BaseLoginUser}>
     */
    Result<BaseLoginUser> loadUserByEmail(String email);

    /**
     * 加载注册用户通过开放id
     *
     * @param wxLoginParam wx登录参数
     * @return {@link Result}<{@link BaseLoginUser}>
     */
    Result<BaseLoginUser> loadRegisterUserByOpenId(WxLoginParam wxLoginParam);

    /**
     * 加载注册用户通过电话
     *
     * @param authLoginParam 身份验证登录参数
     * @return {@link Result}<{@link BaseLoginUser}>
     */
    Result<BaseLoginUser> loadRegisterUserByPhone(AuthLoginParam authLoginParam);

}
