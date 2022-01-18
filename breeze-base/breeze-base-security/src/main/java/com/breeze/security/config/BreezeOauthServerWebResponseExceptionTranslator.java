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

package com.breeze.security.config;

import com.breeze.core.Result;
import com.breeze.core.enums.ResultCode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.oauth2.common.exceptions.InvalidGrantException;
import org.springframework.security.oauth2.common.exceptions.UnsupportedGrantTypeException;
import org.springframework.security.oauth2.provider.error.WebResponseExceptionTranslator;

/**
 * 授权机制的异常处理
 *
 * @author breeze
 * @date 2021/01/10
 */
public class BreezeOauthServerWebResponseExceptionTranslator implements WebResponseExceptionTranslator {

    private final Logger logger = LoggerFactory.getLogger(BreezeOauthServerWebResponseExceptionTranslator.class);

    @Override
    public ResponseEntity translate(Exception ex) {
        Result result = getResponseEntity(ex);
        return ResponseEntity.ok(result);
    }

    private Result getResponseEntity(Exception ex) {
        if (ex instanceof UnsupportedGrantTypeException) {
            logger.info("不支持的认证模式 {}", ResultCode.UNSUPPORTED_GRANT_TYPE.getCode());
            return Result.fail(ResultCode.UNSUPPORTED_GRANT_TYPE);
        } else if (ex instanceof InvalidGrantException) {
            logger.info("用户名或者密码错误 {}", ResultCode.WRONG_USERNAME_OR_PASSWORD.getCode());
            return Result.fail(ResultCode.WRONG_USERNAME_OR_PASSWORD);
        }
        logger.info("权限不足 {}", ResultCode.INSUFFICIENT_PERMISSIONS.getCode());
        return Result.fail(ResultCode.INSUFFICIENT_PERMISSIONS);
    }

}
