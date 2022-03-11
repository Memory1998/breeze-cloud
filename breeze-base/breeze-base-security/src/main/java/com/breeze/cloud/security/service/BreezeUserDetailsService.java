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

package com.breeze.cloud.security.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

/**
 * @author breeze
 * @date 2022/01/11
 */
public interface BreezeUserDetailsService extends UserDetailsService {


    /**
     * Locates the user based on the phone. In the actual implementation, the search
     * may possibly be case sensitive, or case insensitive depending on how the
     * implementation instance is configured. In this case, the <code>UserDetails</code>
     * object that comes back may have a username that is of a different case than what
     * was actually requested..
     *
     * @param phone the phone identifying the user whose data is required.
     * @param code
     * @return a fully populated user record (never <code>null</code>)
     * @throws UsernameNotFoundException if the phone could not be found or the user has no
     *                                   GrantedAuthority
     */
    UserDetails loadUserByPhone(String phone, String code) throws UsernameNotFoundException;

}
