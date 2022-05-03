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

package com.breeze.cloud.security.sms.config;

import com.breeze.cloud.security.service.BreezeUserDetailsService;
import com.breeze.cloud.security.sms.BreezeSmsCodeAuthenticationProvider;
import com.breeze.cloud.security.sms.handler.BreezeAuthenticationFailureHandler;
import com.breeze.cloud.security.sms.handler.BreezeAuthenticationSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.config.annotation.SecurityConfigurerAdapter;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.DefaultSecurityFilterChain;

/**
 * @author breeze
 * @date 2022/01/11
 */
public class BreezeSmsCodeAuthenticationSecurityConfigurerAdapter extends SecurityConfigurerAdapter<DefaultSecurityFilterChain, HttpSecurity> {

    @Autowired
    private BreezeAuthenticationSuccessHandler authenticationSuccessHandler;

    @Autowired
    private BreezeAuthenticationFailureHandler authenticationFailureHandler;

    @Autowired
    private BreezeUserDetailsService userDetailsService;

    @Override
    public void configure(HttpSecurity http) {
        http.authenticationProvider(new BreezeSmsCodeAuthenticationProvider(userDetailsService));
    }
}
