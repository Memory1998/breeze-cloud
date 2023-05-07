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

package com.breeze.cloud.mybatis;

import cn.hutool.core.collection.CollUtil;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.plugins.handler.TenantLineHandler;
import com.baomidou.mybatisplus.extension.plugins.inner.PaginationInnerInterceptor;
import com.baomidou.mybatisplus.extension.plugins.inner.TenantLineInnerInterceptor;
import com.breeze.cloud.core.utils.BreezeThreadLocal;
import com.breeze.cloud.mybatis.config.BreezeLogicSqlInjector;
import com.breeze.cloud.mybatis.filters.TenantProperties;
import com.breeze.cloud.mybatis.plugins.BreezeDataPermissionInterceptor;
import com.breeze.cloud.mybatis.plugins.BreezeSqlLogInnerInterceptor;
import lombok.extern.slf4j.Slf4j;
import net.sf.jsqlparser.expression.Expression;
import net.sf.jsqlparser.expression.LongValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

import java.util.Objects;

/**
 * mybatis +配置
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
@Slf4j
public class MybatisPlusConfiguration {

    @Autowired
    private TenantProperties tenantProperties;

    /**
     * 自定义 SqlInjector 包含自定义的全局方法
     */
    @Bean
    public BreezeLogicSqlInjector logicSqlInjector() {
        return new BreezeLogicSqlInjector();
    }

    /**
     * mybatis +拦截器
     *
     * @return {@link MybatisPlusInterceptor}
     */
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        interceptor.addInnerInterceptor(customTenantLineInnerInterceptor(this.tenantProperties));
        interceptor.addInnerInterceptor(new BreezeDataPermissionInterceptor());
        // 如果用了分页插件注意先 add TenantLineInnerInterceptor 再 add PaginationInnerInterceptor
        interceptor.addInnerInterceptor(new PaginationInnerInterceptor());
        interceptor.addInnerInterceptor(new BreezeSqlLogInnerInterceptor());
        return interceptor;
    }

    /**
     * 定制租户拦截器
     *
     * @return {@link TenantLineInnerInterceptor}
     */
    private TenantLineInnerInterceptor customTenantLineInnerInterceptor(TenantProperties tenantProperties) {
        return new TenantLineInnerInterceptor(new TenantLineHandler() {
            @Override
            public Expression getTenantId() {
                Long tenantId = BreezeThreadLocal.get();
                log.info("[当前租户]： {}", tenantId);

                if (Objects.isNull(tenantId)) {
                    tenantId = 1L;
//                    throw new TenantNotValueException("租户信息未获取到");
                }
                return new LongValue(tenantId);
            }

            @Override
            public String getTenantIdColumn() {
                return tenantProperties.getColumn();
            }

            /**
             * 这是 default 方法
             * <p>
             * 默认返回 false 表示需要拼多租户条件
             * 默认返回 true 表示不需要拼多租户条件
             */
            @Override
            public boolean ignoreTable(String tableName) {
                log.debug("[当前拦截的表名] {}", tableName);
                log.debug("[在多租户表序列中？] {}", CollUtil.contains(tenantProperties.getTables(), tableName));
                return !CollUtil.contains(tenantProperties.getTables(), tableName);
            }
        });
    }

}

