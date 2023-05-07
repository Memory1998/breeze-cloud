package com.breeze.cloud.flow.client;

import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.flow.params.ProcessStartParam;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.validation.Valid;

/**
 * 可流动过程假装
 *
 * @author gaoweixuan
 * @date 2023-04-11
 */
@FeignClient(name = "breeze-flowable-server", contextId = "flowableProcessFeign")
public interface FlowableProcessFeign {

    /**
     * 开启审批流
     *
     * @param startParam 启动参数
     * @return {@link Result}<{@link Boolean}>
     */
    @PostMapping("/startProcess")
    Result<Boolean> startProcess(@Valid @RequestBody ProcessStartParam startParam);

}
