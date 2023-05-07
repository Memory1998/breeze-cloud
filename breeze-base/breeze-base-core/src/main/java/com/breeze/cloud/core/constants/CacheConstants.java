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

package com.breeze.cloud.core.constants;

/**
 * 缓存常量
 *
 * @author gaoweixuan
 * @date 2021/10/1
 */
public class CacheConstants {

    /**
     * 登录用户
     */
    public static final String LOGIN_USER = "sys:login_user:";

    /**
     * 黑名单jwt
     */
    public static final String BLACK_JWT = "sys:black:jwt:";

    public static String prefix = "auth:";

    /**
     * 授权信息
     */
    public static final String AUTHORIZATION = prefix + "authorization:";

    /**
     * state 对应的 oauthId
     */
    public static final String STATE_OAUTH = prefix + "state:oauth:";

    /**
     * code 对应的 oauthId
     */
    public static final String CODE_OAUTH = prefix + "code:oauth:";

    /**
     * access_code 对应的 oauthId
     */
    public static final String ACCESS_OAUTH = prefix + "access:oauth:";

    /**
     * refresh_code 对应的 oauthId
     */
    public static final String REFRESH_OAUTH = prefix + "refresh:oauth:";

    /**
     * clientId 对应的 oauthId
     */
    public static final String CLIENT_OAUTH = prefix + "client:oauth:";

    /**
     * 相关的Key保存
     */
    public static final String CORRELATIONS = prefix + "correlations:";

    /**
     * 授权同意信息
     */
    public static final String CONSENT = prefix + "consent:";
}
