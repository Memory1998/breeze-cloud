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

package com.breeze.cloud.auth.extend;

import com.breeze.cloud.auth.jackson2.OAuth2AuthorizationConsentModule;
import com.breeze.cloud.core.utils.Utils;
import com.fasterxml.jackson.databind.Module;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.config.AutowireCapableBeanFactory;
import org.springframework.data.redis.core.RedisOperations;
import org.springframework.http.converter.json.SpringHandlerInstantiator;
import org.springframework.lang.Nullable;
import org.springframework.security.jackson2.SecurityJackson2Modules;
import org.springframework.security.oauth2.server.authorization.OAuth2AuthorizationConsent;
import org.springframework.security.oauth2.server.authorization.OAuth2AuthorizationConsentService;
import org.springframework.util.Assert;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

import static com.breeze.cloud.core.constants.CacheConstants.CONSENT;

/**
 * 在 redis中 oauth2授权同意服务
 *
 * @author gaoweixuan
 * @date 2023-04-24
 */
public class InRedisOAuth2AuthorizationConsentService implements OAuth2AuthorizationConsentService {

    /**
     * redis 操作
     */
    private final RedisOperations<String, String> redisOperations;

    /**
     * 工具
     */
    Utils<OAuth2AuthorizationConsent> utils = new Utils<>(new ObjectMapper());

    /**
     * Constructs an {@code InRedisOAuth2AuthorizationConsentService}.
     *
     * @param redisOperations redis
     * @param beanFactory     bean工厂
     */
    public InRedisOAuth2AuthorizationConsentService(RedisOperations<String, String> redisOperations, AutowireCapableBeanFactory beanFactory) {
        Assert.notNull(redisOperations, "redisOperations mut not be null");
        this.redisOperations = redisOperations;
        ClassLoader classLoader = this.getClass().getClassLoader();
        List<Module> securityModules = SecurityJackson2Modules.getModules(classLoader);

        utils.register(securityModules);
        utils.register(new OAuth2AuthorizationConsentModule());

        ObjectMapper objectMapper = utils.getObjectMapper();
        objectMapper.setHandlerInstantiator(new SpringHandlerInstantiator(beanFactory));
    }

    private static String getId(String registeredClientId, String principalName) {
        return CONSENT + Math.abs(Objects.hash(registeredClientId, principalName)) + ":";
    }

    private static String getId(OAuth2AuthorizationConsent authorizationConsent) {
        return getId(authorizationConsent.getRegisteredClientId(), authorizationConsent.getPrincipalName());
    }

    @Override
    public void save(OAuth2AuthorizationConsent authorizationConsent) {
        Assert.notNull(authorizationConsent, "authorizationConsent cannot be null");
        String id = getId(authorizationConsent);
        this.redisOperations.opsForValue().set(id, utils.write(authorizationConsent));
    }

    @Override
    public void remove(OAuth2AuthorizationConsent authorizationConsent) {
        Assert.notNull(authorizationConsent, "authorizationConsent cannot be null");
        String id = getId(authorizationConsent);
        this.redisOperations.delete(id);
    }

    @Override
    @Nullable
    public OAuth2AuthorizationConsent findById(String registeredClientId, String principalName) {
        Assert.hasText(registeredClientId, "registeredClientId cannot be empty");
        Assert.hasText(principalName, "principalName cannot be empty");
        String id = getId(registeredClientId, principalName);
        return Optional.ofNullable(this.redisOperations.opsForValue().get(id)).map(utils::parse).orElse(null);
    }

}
