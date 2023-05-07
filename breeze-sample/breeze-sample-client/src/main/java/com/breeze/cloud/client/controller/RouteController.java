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

package com.breeze.cloud.client.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 路由控制器
 *
 * @author gaoweixuan
 * @date 2023-04-20
 */
@Controller
public class RouteController {

    /**
     * 根路径。转发到index
     *
     * @return {@link String}
     */
    @GetMapping("/")
    public String root() {
        return "redirect:/index";
    }

    /**
     * index
     *
     * @return {@link String}
     */
    @GetMapping("/index")
    public String index() {
        return "index";
    }

    /**
     * 注销
     *
     * @param request  请求
     * @param response 响应
     */
    @GetMapping("/custom/client/logout")
    public void logout(HttpServletRequest request,
                       HttpServletResponse response) {

        // 清除客户端的session
        request.getSession().invalidate();
        // 清除客户端的安全上下文
        SecurityContextHolder.clearContext();

        // 跳转认证中心退出页面
        try {
            response.sendRedirect("http://localhost:8000/custom/auth/logout");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
