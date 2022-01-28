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

package com.breeze.cloud.oauth2.config;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.breeze.cloud.admin.api.OauthClientDetailsFeign;
import com.breeze.cloud.admin.entity.SysOauthClientDetailsEntity;
import com.breeze.cloud.core.constants.CacheConstants;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.context.annotation.Configuration;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.oauth2.common.exceptions.InvalidClientException;
import org.springframework.security.oauth2.provider.ClientDetails;
import org.springframework.security.oauth2.provider.ClientDetailsService;
import org.springframework.security.oauth2.provider.NoSuchClientException;
import org.springframework.security.oauth2.provider.client.BaseClientDetails;
import org.springframework.util.StringUtils;

import java.util.Map;
import java.util.Objects;

/**
 * @author breeze
 * @date 2021/10/1
 * <p>
 * 重写原生方法支持redis缓存 可以参考 JdbcClientDetailsService 实现类
 */
@Configuration
public class BreezeRedisClientDetailsService implements ClientDetailsService {

    private static final Log logger = LogFactory.getLog(BreezeRedisClientDetailsService.class);

    private OauthClientDetailsFeign oauthClientDetailsFeign;

    public BreezeRedisClientDetailsService(OauthClientDetailsFeign oauthClientDetailsFeign) {
        this.oauthClientDetailsFeign = oauthClientDetailsFeign;
    }

    @Override
    @Cacheable(value = CacheConstants.CLIENT_DETAILS_KEY, key = "#clientId", unless = "#result == null")
    public ClientDetails loadClientByClientId(String clientId) throws InvalidClientException {
        ClientDetails details;
        try {
            SysOauthClientDetailsEntity info = this.oauthClientDetailsFeign.info(clientId);
            if (Objects.isNull(info)) {
                logger.info("client id is not found.");
                throw new NoSuchClientException("No client with requested id: " + clientId);
            }
            details = this.getFieldsForSelect(info);
        } catch (EmptyResultDataAccessException e) {
            throw new NoSuchClientException("No client with requested id: " + clientId);
        }
        return details;
    }

    private BaseClientDetails getFieldsForSelect(SysOauthClientDetailsEntity clientDetails) {

        BaseClientDetails baseClientDetails = new BaseClientDetails();

        if (StrUtil.isNotBlank(clientDetails.getResourceIds())) {
            baseClientDetails.setResourceIds(StringUtils.commaDelimitedListToSet(clientDetails.getResourceIds()));
        }

        if (StrUtil.isNotBlank(clientDetails.getAdditionalInformation())) {
            String json = JSONUtil.formatJsonStr(clientDetails.getAdditionalInformation());
            Map<String, Object> additionalInformationMap = BeanUtil.beanToMap(json);
            baseClientDetails.setAdditionalInformation(additionalInformationMap);
        }

        if (StrUtil.isNotBlank(clientDetails.getScope())) {
            baseClientDetails.setScope(StringUtils.commaDelimitedListToSet(clientDetails.getScope()));
        }

        if (StrUtil.isNotBlank(clientDetails.getAuthorizedGrantTypes())) {
            baseClientDetails.setAuthorizedGrantTypes(StringUtils.commaDelimitedListToSet(clientDetails.getAuthorizedGrantTypes()));
        }

        if (StrUtil.isNotBlank(clientDetails.getWebServerRedirectUri())) {
            baseClientDetails.setRegisteredRedirectUri(StringUtils.commaDelimitedListToSet(clientDetails.getWebServerRedirectUri()));
        }

        if (StrUtil.isNotBlank(clientDetails.getAuthorities())) {
            baseClientDetails.setAuthorities(AuthorityUtils.commaSeparatedStringToAuthorityList(clientDetails.getAuthorities()));
        }

        if (Objects.nonNull(clientDetails.getAccessTokenValidity())) {
            baseClientDetails.setAccessTokenValiditySeconds(clientDetails.getAccessTokenValidity());
        }

        if (Objects.nonNull(clientDetails.getRefreshTokenValidity())) {
            baseClientDetails.setRefreshTokenValiditySeconds(clientDetails.getRefreshTokenValidity());
        }

        if (Objects.nonNull(clientDetails.getRefreshTokenValidity())) {
            baseClientDetails.setRefreshTokenValiditySeconds(clientDetails.getRefreshTokenValidity());
        }

        if (Objects.nonNull(clientDetails.getRefreshTokenValidity())) {
            baseClientDetails.setRefreshTokenValiditySeconds(clientDetails.getRefreshTokenValidity());
        }

        if (StrUtil.isNotBlank(clientDetails.getAutoapprove())) {
            baseClientDetails.setAutoApproveScopes(StringUtils.commaDelimitedListToSet(clientDetails.getAutoapprove()));
        }

        baseClientDetails.setClientId(clientDetails.getClientId());

        baseClientDetails.setClientSecret(clientDetails.getClientSecret());

        return baseClientDetails;
    }

}
