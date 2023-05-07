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

package com.breeze.cloud.auth.controller;

import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.system.client.SysTenantFeign;
import lombok.AllArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * 路由控制器
 *
 * @author gaoweixuan
 * @date 2023-04-24
 */
@Controller
@AllArgsConstructor
public class RouteController {

    /**
     * 租户假装
     */
    private final SysTenantFeign tenantFeign;

    @RequestMapping("/login")
    public String login(Model model) {
        Result<List<Map<String, Object>>> mapResult = this.tenantFeign.selectTenant();
        List<Map<String, Object>> tenantMap = mapResult.getData();
        if (tenantMap == null) {
            return "error";
        }

        // 给login页面赋值
        model.addAttribute("tenant", tenantMap);
        return "login";
    }

    @RequestMapping("/custom/auth/logout")
    public String logout(HttpServletRequest request) {

        // 清理客户端的session
        request.getSession().invalidate();
        // 清理客户端的安全上下文
        SecurityContextHolder.clearContext();

        // 拓展需要跳转页面 TODO
        return "logout";
    }

}
