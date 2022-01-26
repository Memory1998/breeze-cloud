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

package com.breeze.cloud.security.sms;

import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.util.Assert;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

/**
 * @author breeze
 * @date 2022/01/11
 */
public class BreezeSmsCodeAuthenticationToken extends AbstractAuthenticationToken {

    private static final long serialVersionUID = 1L;

    /**
     * principal 身份信息，大部分情况下返回的是UserDetails接口的实现类，UserDetails代表用户的详细 信息，那从Authentication中取出来的UserDetails就是当前登录用户信息，它也是框架中的常用接口之一
     */
    private Object principal;

    /**
     * authorities 权限信息列表，默认是GrantedAuthority接口的一些实现类，通常是代表权限信息的一系 列字符串
     */
    private Collection<GrantedAuthority> authorities;

    /**
     * Creates a token with the supplied array of authorities.
     *
     * @param authorities the collection of <tt>GrantedAuthority</tt>s for the principal
     *                    represented by this authentication object.
     */
    public BreezeSmsCodeAuthenticationToken(Object principal,
                                            Collection<? extends GrantedAuthority> authorities) {
        super(authorities);
        if (authorities == null) {
            this.authorities = AuthorityUtils.NO_AUTHORITIES;
            return;
        }
        this.principal = principal;
        this.setAuthenticated(true);

        for (GrantedAuthority a : authorities) {
            Assert.notNull(a, "Authorities collection cannot contain any null elements");
        }
        this.authorities = Collections.unmodifiableList(new ArrayList<>(authorities));
    }

    /**
     * Creates a token with the supplied array of authorities.
     *
     * @param phone the collection of <tt>GrantedAuthority</tt>s for the principal
     *              represented by this authentication object.
     */
    public BreezeSmsCodeAuthenticationToken(String phone) {
        super(null);
        this.principal = phone;
        this.setAuthenticated(Boolean.FALSE);
    }

    @Override
    public Collection<GrantedAuthority> getAuthorities() {
        return this.authorities;
    }

    /**
     * 凭证信息，用户输入的密码字符串，在认证过后通常会被移除，用于保障安全。
     *
     * @return
     */
    @Override
    public Object getCredentials() {
        return null;
    }

    /**
     * 身份信息，大部分情况下返回的是UserDetails接口的实现类，UserDetails代表用户的详细 信息，那从Authentication中取出来的UserDetails就是当前登录用户信息，它也是框架中的常用接口之一
     *
     * @return
     */
    @Override
    public Object getPrincipal() {
        return this.principal;
    }

    @Override
    public boolean isAuthenticated() {
        return super.isAuthenticated();
    }

    @Override
    public void setAuthenticated(boolean authenticated) {
        if (authenticated) {
            throw new IllegalArgumentException(
                    "Cannot set this token to trusted - use constructor which takes a GrantedAuthority list instead");
        }
        super.setAuthenticated(Boolean.FALSE);
    }

    @Override
    public void eraseCredentials() {
        super.eraseCredentials();
    }

}
