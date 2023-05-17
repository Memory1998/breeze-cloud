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

package com.breeze.cloud.mybatis.annotation;

import com.baomidou.mybatisplus.autoconfigure.MybatisPlusAutoConfiguration;
import com.breeze.cloud.core.enums.DataRole;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;

import java.lang.annotation.*;

/**
 * 数据权限
 *
 * @author gaoweixuan
 * @date 2022-10-29
 */
@Inherited
@Documented
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@ConditionalOnWebApplication
@ConditionalOnBean(MybatisPlusAutoConfiguration.class)
public @interface BreezeDataPermission {

    /**
     * 范围权限字段名称
     */
    DataRole scope() default DataRole.DEPT_ID;

    /**
     * 个人权限字段名称
     */
    DataRole own() default DataRole.USER_ID;

}
