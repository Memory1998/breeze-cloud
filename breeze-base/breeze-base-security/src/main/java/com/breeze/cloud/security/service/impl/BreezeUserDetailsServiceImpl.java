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

package com.breeze.cloud.security.service.impl;

import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.breeze.cloud.admin.api.SysUserFeign;
import com.breeze.cloud.admin.dto.SysUserDTO;
import com.breeze.cloud.admin.dto.SysUserRoleDTO;
import com.breeze.cloud.core.Result;
import com.breeze.cloud.core.enums.ResultCode;
import com.breeze.cloud.security.domain.BreezeLoginUser;
import com.breeze.cloud.security.service.BreezeUserDetailsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @author breeze
 * @date 2021/10/1
 */
@Service
public class BreezeUserDetailsServiceImpl implements BreezeUserDetailsService {

    @Autowired
    private SysUserFeign sysUserFeign;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // todo
        Result<SysUserDTO> userEntityResult = this.sysUserFeign.loadByLoginAmount(username);
        if (Objects.equals(userEntityResult.getCode(), ResultCode.FAIL.getCode()) || Objects.isNull(userEntityResult.getData())) {
            throw new UsernameNotFoundException("用户不存在");
        }
        Set<String> authSet = new HashSet<>();
        SysUserDTO sysUserDTO = userEntityResult.getData();
        if (Objects.nonNull(sysUserDTO.getPermission())) {
            authSet.addAll(Arrays.stream(sysUserDTO.getPermission()).filter(StringUtils::hasLength).collect(Collectors.toList()));
        }

        List<String> roleCodeList = null;
        List<String> roleIdList = null;
        if (CollectionUtils.isNotEmpty(sysUserDTO.getUserRoleDTOList())) {
            // 按照角色权限必须使用ROLE_前缀后生效
            roleCodeList = sysUserDTO.getUserRoleDTOList().stream().map(role -> "ROLE_" + role.getRoleCode()).filter(StringUtils::hasLength).collect(Collectors.toList());
            authSet.addAll(roleCodeList);
            // 角色ID集合
            roleIdList = sysUserDTO.getUserRoleDTOList().stream().map(SysUserRoleDTO::getRoleId).map(String::valueOf).filter(StringUtils::hasLength).collect(Collectors.toList());
        }

        Collection<? extends GrantedAuthority> authorities
                = AuthorityUtils.createAuthorityList(authSet.toArray(new String[0]));

        return new BreezeLoginUser(sysUserDTO.getId(),
                sysUserDTO.getUserCode(),
                roleCodeList,
                roleIdList,
                sysUserDTO.getDeptId(),
                sysUserDTO.getDeptName(),
                sysUserDTO.getUsername(),
                sysUserDTO.getPassword(),
                sysUserDTO.getAmountName(),
                Objects.equals(0, sysUserDTO.getIsLock()),
                true,
                true,
                Objects.equals(0, sysUserDTO.getIsLock()),
                authorities);
    }

    @Override
    public UserDetails loadUserByPhone(String phone, String code) throws UsernameNotFoundException {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        String inputCode = request.getParameter("code");

        // todo code
        String smsCode = "123456";
        if ("".equals(smsCode)) {
            throw new BadCredentialsException("请先获取验证码");
        }

        if (!Objects.equals(smsCode, inputCode)) {
            throw new BadCredentialsException("验证码错误");
        }
        return null;
    }
}
