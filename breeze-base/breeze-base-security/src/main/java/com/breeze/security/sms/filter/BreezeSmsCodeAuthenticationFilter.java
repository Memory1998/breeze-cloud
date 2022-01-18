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

package com.breeze.security.sms.filter;

import com.breeze.security.sms.BreezeSmsCodeAuthenticationToken;
import org.springframework.lang.Nullable;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author breeze
 * @date 2022/01/11
 */
public class BreezeSmsCodeAuthenticationFilter extends AbstractAuthenticationProcessingFilter {

    private String mobileParameter = "phone";

    private boolean postOnly = true;

    /**
     * 请求接口的url
     */
    public BreezeSmsCodeAuthenticationFilter() {
        super(new AntPathRequestMatcher("/oauth/sms", "POST"));
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
            throws AuthenticationException {
        if (postOnly && !request.getMethod().equals("POST")) {
            throw new AuthenticationServiceException("Authentication method not supported: " + request.getMethod());
        }
        // 根据请求参数名，获取请求value
        String phone = obtainPhone(request);
        phone = (phone != null) ? phone : "";
        phone = phone.trim();

        // 生成对应的AuthenticationToken
        BreezeSmsCodeAuthenticationToken authRequest = new BreezeSmsCodeAuthenticationToken(phone);
        // Allow subclasses to set the "details" property
        setDetails(request, authRequest);
        return this.getAuthenticationManager().authenticate(authRequest);
    }

    /**
     * Provided so that subclasses may configure what is put into the authentication
     * request's details property.
     *
     * @param request     that an authentication request is being created for
     * @param authRequest the authentication request object that should have its details
     *                    set
     */
    protected void setDetails(HttpServletRequest request, BreezeSmsCodeAuthenticationToken authRequest) {
        authRequest.setDetails(this.authenticationDetailsSource.buildDetails(request));
    }


    /**
     * Enables subclasses to override the composition of the phone, such as by
     * including additional values and a separator.
     * <p>
     * This might be used for example if a postcode/zipcode was required in addition to
     * the phone. A delimiter such as a pipe (|) should be used to separate the
     * password and extended value(s). The <code>AuthenticationDao</code> will need to
     * generate the expected password in a corresponding manner.
     * </p>
     *
     * @param request so that request attributes can be retrieved
     * @return the phone that will be presented in the <code>Authentication</code>
     * request token to the <code>AuthenticationManager</code>
     */
    @Nullable
    protected String obtainPhone(HttpServletRequest request) {
        return request.getParameter(mobileParameter);
    }
}
