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

package com.example.sentinel.controller;

import com.alibaba.csp.sentinel.annotation.SentinelResource;
import com.alibaba.csp.sentinel.slots.block.BlockException;
import com.example.sentinel.domain.Order;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author breeze
 * @date 2022/04/03
 */
@RestController
@RequestMapping("/demo")
public class DemoController {

    @GetMapping("/getOrderDetail")
    @SentinelResource(value = "getOrderDetail", blockHandler = "handleFlowQpsException",
            fallback = "getOrderDetailFallback")
    public Order getOrderDetail(@RequestParam("orderId") String orderId) {
        if ("1".equals(orderId)) {
            throw new RuntimeException();
        }
        return new Order();
    }


    /**
     * 订单查询接口抛出限流或降级时的处理逻辑
     * <p>
     * 注意: 方法参数、返回值要与原函数保持一致
     *
     * @return
     */
    public String handleFlowQpsException(String orderId, BlockException e) {
        e.printStackTrace();
        return "handleFlowQpsException for getOrderDetail: " + orderId;
    }

    /**
     * 订单查询接口运行时抛出的异常提供fallback处理
     * <p>
     * 注意: 方法参数、返回值要与原函数保持一致
     *
     * @return
     */
    public String getOrderDetailFallback(String orderId, Throwable e) {
        return "fallback queryOrderInfo2: " + orderId;
    }
}
