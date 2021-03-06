package com.breeze.cloud.security.config;

import com.breeze.cloud.core.Result;
import com.breeze.cloud.core.enums.ResultCode;
import com.breeze.cloud.core.utils.ResponseUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 客户端认证出错
 * eg: 包括客户端id、密码错误
 *
 * @author breeze
 * @date 2021/10/1
 */
@Slf4j
@Component
public class BreezeOauthServerAuthenticationEntryPoint implements AuthenticationEntryPoint {

    /**
     * 认证失败处理器会调用这个方法返回提示信息
     *
     * @param request
     * @param response
     * @param authException
     * @throws IOException
     * @throws ServletException
     */
    @Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
        log.error("{}", ResultCode.CLIENT_AUTHENTICATION_FAILED.getDesc());
        ResponseUtil.response(response, Result.fail(ResultCode.CLIENT_AUTHENTICATION_FAILED));
    }

}
