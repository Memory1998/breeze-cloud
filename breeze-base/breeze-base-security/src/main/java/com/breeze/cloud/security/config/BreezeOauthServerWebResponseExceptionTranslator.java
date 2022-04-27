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

import com.breeze.cloud.core.Result;
import com.breeze.cloud.core.enums.ResultCode;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.oauth2.common.exceptions.InvalidGrantException;
import org.springframework.security.oauth2.common.exceptions.UnsupportedGrantTypeException;
import org.springframework.security.oauth2.provider.error.WebResponseExceptionTranslator;

/**
 * 授权机制的异常处理
 *
 * @author breeze
 * @date 2021/01/10
 */
@Slf4j
public class BreezeOauthServerWebResponseExceptionTranslator implements WebResponseExceptionTranslator {

    @Override
    public ResponseEntity translate(Exception ex) {
        Result result = getResponseEntity(ex);
        return ResponseEntity.ok(result);
    }

    private Result getResponseEntity(Exception ex) {
        ex.printStackTrace();
        if (ex instanceof UnsupportedGrantTypeException) {
            log.error("不支持的认证模式 {}", ResultCode.UNSUPPORTED_GRANT_TYPE.getCode());
            return Result.fail(ResultCode.UNSUPPORTED_GRANT_TYPE);
        } else if (ex instanceof InvalidGrantException) {
            log.error("用户名或者密码错误 {}", ResultCode.WRONG_USERNAME_OR_PASSWORD.getCode());
            return Result.fail(ResultCode.WRONG_USERNAME_OR_PASSWORD);
        } else if (ex instanceof UsernameNotFoundException) {
            log.error("用户不存在 {}", ResultCode.USERNAME_NOT_FOUND_EXCEPTION.getCode());
            return Result.fail(ResultCode.USERNAME_NOT_FOUND_EXCEPTION);
        } else if (ex instanceof InternalAuthenticationServiceException) {
            log.error("内部身份验证服务异常 {}", ResultCode.FEIGN_INTERNAL_AUTHENTICATION_SERVICE_EXCEPTION.getCode());
            return Result.fail(ResultCode.FEIGN_INTERNAL_AUTHENTICATION_SERVICE_EXCEPTION);
        }
        log.error("系统未授权 {}", ResultCode.UNAUTHORIZED.getCode());
        return Result.fail(ResultCode.UNAUTHORIZED);
    }

}
