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

package com.breeze.cloud.resource.controller;

import com.google.common.collect.Lists;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 测试控制器
 *
 * @author gaoweixuan
 * @date 2023-04-20
 */
@RestController
public class ResourceTestController {

    /**
     * jwt 中自定义的 【scope】 中的标识
     *
     * @return
     */
    @PreAuthorize("hasAnyAuthority('sys:dept:create')")
    @GetMapping("/write/{hello}")
    public List<String> read(@PathVariable("hello") String hello, HttpServletRequest request) {
        return Lists.newArrayList("hello world", hello);
    }

    /**
     * 阅读范围
     * 由于指定中自定义的 【scope】 作为权限标识
     *
     * @param hello   你好
     * @param request 请求
     * @return {@link List}<{@link String}>
     */
    @PreAuthorize("hasAnyAuthority('read')")
    @GetMapping("/read/{hello}")
    public List<String> Read(@PathVariable("hello") String hello, HttpServletRequest request) {
        return Lists.newArrayList(hello);
    }

}
