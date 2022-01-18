package com.breeze.security.config;

import com.breeze.core.Result;
import com.breeze.core.enums.ResultCode;
import com.breeze.core.utils.ResponseUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
@Component
public class BreezeOauthServerAuthenticationEntryPoint implements AuthenticationEntryPoint {

    private final Logger logger = LoggerFactory.getLogger(BreezeOauthServerAuthenticationEntryPoint.class);

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
        ResponseUtil.response(response, Result.fail(ResultCode.CLIENT_AUTHENTICATION_FAILED));
    }

}
