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

import com.breeze.cloud.security.service.BreezeUserDetailsService;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;

/**
 * @author breeze
 * @date 2022/01/11
 */
public class BreezeSmsCodeAuthenticationProvider implements AuthenticationProvider {

    /**
     * The plaintext password used to perform PasswordEncoder#matches(CharSequence,
     * String)} on when the user is not found to avoid SEC-2056.
     */
    private static final String PHONE_NOT_FOUND_CODE = "phoneNotFoundCode";

    private BreezeUserDetailsService userDetailsService;

    public BreezeSmsCodeAuthenticationProvider(BreezeUserDetailsService userDetailsService) {
        this.userDetailsService = userDetailsService;
    }

    /**
     * 身份逻辑验证
     *
     * @param authentication
     * @return
     * @throws AuthenticationException
     */
    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {

        BreezeSmsCodeAuthenticationToken authenticationToken = (BreezeSmsCodeAuthenticationToken) authentication;

        Object principal = authenticationToken.getPrincipal();
        Object credentials = authenticationToken.getCredentials();

        UserDetails user = this.userDetailsService.loadUserByPhone((String) principal, (String) credentials);
        if (null == user) {
            throw new InternalAuthenticationServiceException(PHONE_NOT_FOUND_CODE);
        }

        BreezeSmsCodeAuthenticationToken authenticationResult = new BreezeSmsCodeAuthenticationToken(user, user.getAuthorities());
        authenticationResult.setDetails(authenticationToken.getDetails());
        return authenticationResult;
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return BreezeSmsCodeAuthenticationToken.class.isAssignableFrom(authentication);
    }

}
