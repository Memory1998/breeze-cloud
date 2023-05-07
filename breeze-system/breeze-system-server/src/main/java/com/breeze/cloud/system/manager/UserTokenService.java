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

package com.breeze.cloud.system.manager;

import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.security.config.JwtConfiguration;
import com.breeze.cloud.security.ext.CurrentLoginUser;
import com.breeze.cloud.system.dto.LoginUser;
import com.google.common.collect.Maps;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.time.Instant;
import java.util.Date;
import java.util.Map;
import java.util.stream.Collectors;

import static com.breeze.cloud.core.constants.CacheConstants.LOGIN_USER;

/**
 * 用户令牌服务
 *
 * @author gaoweixuan
 * @date 2022-10-19
 */
@Service
public class UserTokenService {

    /**
     * 缓存
     */
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    /**
     * jwt配置
     */
    @Autowired
    private JwtConfiguration jwtConfiguration;

    /**
     * 创建jwt牌
     *
     * @param expiry         到期
     * @param authentication 身份验证
     * @return {@link Map}<{@link String}, {@link Object}>
     */
    public Map<String, Object> createJwtToken(long expiry, Authentication authentication) {
        Instant now = Instant.now();
        String scope = authentication.getAuthorities().stream().map(GrantedAuthority::getAuthority).collect(Collectors.joining(" "));
        LoginUser loginUser = ((CurrentLoginUser) authentication.getPrincipal()).getLoginUser();
        JWTClaimsSet claims = new JWTClaimsSet.Builder()
                .issuer("self")
                .issueTime(new Date(now.toEpochMilli()))
                .expirationTime(new Date(now.plusSeconds(expiry).toEpochMilli()))
                .subject(authentication.getName())
                .claim("userId", loginUser.getId())
                .claim("tenantId", loginUser.getTenantId())
                .claim("username", loginUser.getUsername())
                .claim("userCode", loginUser.getUserCode())
                .claim("scope", scope)
                .build();
        JWSHeader header = new JWSHeader.Builder(JWSAlgorithm.RS256).build();
        SignedJWT signedJwt = new SignedJWT(header, claims);
        Map<String, Object> resultMap = Maps.newHashMap();
        resultMap.put("userInfo", loginUser);
        resultMap.put("accessToken", jwtConfiguration.sign(signedJwt).serialize());
        return resultMap;
    }

    public Result<Boolean> logout(String username, HttpServletRequest request) {
        // String authorization = request.getHeader(HttpHeaders.AUTHORIZATION);
        // 使用的无状态的JWT，使用黑名单机制退出登录
        // this.redisTemplate.opsForValue().set(BLACK_JWT + username, authorization,36000L);
        return Result.ok(this.redisTemplate.delete(LOGIN_USER + username));
    }
}
