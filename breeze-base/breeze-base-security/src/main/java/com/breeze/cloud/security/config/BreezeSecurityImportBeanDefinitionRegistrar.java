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

package com.breeze.cloud.security.config;

import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.context.annotation.ImportBeanDefinitionRegistrar;
import org.springframework.core.type.AnnotationMetadata;
import org.springframework.util.StringUtils;

/**
 * 使用 自定义配置 实现 ImportBeanDefinitionRegistrar 自动加载类
 *
 * @author breeze
 * @date 2021/10/10
 */
public class BreezeSecurityImportBeanDefinitionRegistrar implements ImportBeanDefinitionRegistrar {

    /**
     * @param metadata
     * @param registry
     */
    @Override
    public void registerBeanDefinitions(AnnotationMetadata metadata, BeanDefinitionRegistry registry) {
        String beanName = StringUtils.uncapitalize(BreezeResourceServerConfig.class.getSimpleName());
        BeanDefinitionBuilder beanDefinitionBuilder = BeanDefinitionBuilder.genericBeanDefinition(BreezeResourceServerConfig.class);
        registry.registerBeanDefinition(beanName, beanDefinitionBuilder.getBeanDefinition());
    }

}
