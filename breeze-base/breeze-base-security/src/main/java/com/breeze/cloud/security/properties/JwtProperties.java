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

package com.breeze.cloud.security.properties;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;

/**
 * jwt属性
 *
 * @author gaoweixuan
 * @date 2022-10-29
 */
@Getter
@Setter
@ConfigurationProperties(prefix = "breeze.jwt")
public class JwtProperties {

    /**
     * rsa公钥
     */
    private RSAPublicKey rsaPublicKey;

    /**
     * rsa私钥
     */
    private RSAPrivateKey rsaPrivateKey;

}
