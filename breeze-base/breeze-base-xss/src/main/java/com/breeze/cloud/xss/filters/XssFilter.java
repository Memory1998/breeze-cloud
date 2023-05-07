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

package com.breeze.cloud.xss.filters;

import cn.hutool.core.text.AntPathMatcher;
import com.breeze.cloud.core.utils.LoadAnnotationUtils;
import com.breeze.cloud.xss.config.XssHttpServletRequestWrapper;
import com.breeze.cloud.xss.config.XssProperties;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.ApplicationContext;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

/**
 * xss过滤器
 *
 * @author gaoweixuan
 * @date 2022-10-21
 */
@Slf4j
public class XssFilter implements Filter {

    /**
     * xss属性
     */
    private final XssProperties xssProperties;

    /**
     * 请求映射处理程序映射
     * 使用Bean名称注入
     */
    private final RequestMappingHandlerMapping requestMappingHandlerMapping;

    /**
     * 应用程序上下文
     */
    private final ApplicationContext applicationContext;

    /**
     * 匹配器
     */
    private final AntPathMatcher matcher = new AntPathMatcher("/");

    /**
     * xss过滤器
     *
     * @param xssProperties xss属性
     */
    public XssFilter(XssProperties xssProperties, RequestMappingHandlerMapping requestMappingHandlerMapping, ApplicationContext applicationContext) {
        this.xssProperties = xssProperties;
        this.requestMappingHandlerMapping = requestMappingHandlerMapping;
        this.applicationContext = applicationContext;
    }

    /**
     * 初始化
     *
     * @param config 配置
     */
    @Override
    public void init(FilterConfig config) {
        log.info("----- 初始化xss需要被过滤的路径开始 -----");
        LoadAnnotationUtils.loadControllerMapping(xssProperties, applicationContext, requestMappingHandlerMapping);
        log.info("----- 初始化xss需要被过滤的路径结束 -----");
    }

    /**
     * 过滤器
     *
     * @param request  请求
     * @param response 响应
     * @param chain    链
     * @throws IOException      IO异常
     * @throws ServletException servlet异常
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        if (this.match((HttpServletRequest) request)) {
            chain.doFilter(request, response);
            return;
        }
        chain.doFilter(new XssHttpServletRequestWrapper((HttpServletRequest) request), response);
    }

    private boolean match(HttpServletRequest request) {
        List<String> ignoreUrls = this.xssProperties.getIgnoreUrls();
        for (String ignoreUrl : ignoreUrls) {
            if (matcher.match(ignoreUrl, request.getRequestURI())) {
                return Boolean.TRUE;
            }
        }
        return Boolean.FALSE;
    }

    /**
     * 销毁
     */
    @Override
    public void destroy() {
    }

}
