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

package com.breeze.base.oss.s3.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * oss属性
 *
 * @author gaoweixuan
 * @date 2023-04-18
 */
@Data
@ConfigurationProperties(prefix = "breeze.oss.s3")
public class OssProperties {

    /**
     * 对象存储服务的URL
     */
    private String endpoint;

    /**
     * 区域
     */
    private String region;

    /**
     * minio连接用户名
     */
    private String minioRootUser;

    /**
     * minio连接密码
     */
    private String minioRootPassword;

    /**
     * 最大线程数
     */
    private Integer maxConnections = 60;

    /**
     * 路径方式访问
     */
    private Boolean pathStyleAccess = true;

}
