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

package com.breeze.cloud.system.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.cloud.system.domain.SysPlatform;
import com.breeze.cloud.system.mapper.SysPlatformMapper;
import com.breeze.cloud.system.query.PlatformQuery;
import com.breeze.cloud.system.service.SysPlatformService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 系统平台服务impl
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
@Service
@AllArgsConstructor
public class SysPlatformServiceImpl extends ServiceImpl<SysPlatformMapper, SysPlatform> implements SysPlatformService {

    /**
     * 列表页面
     *
     * @param platformQuery 平台查询
     * @return {@link Page}<{@link SysPlatform}>
     */
    @Override
    public Page<SysPlatform> listPage(PlatformQuery platformQuery) {
        Page<SysPlatform> platformEntityPage = new Page<>(platformQuery.getCurrent(), platformQuery.getSize());
        return new LambdaQueryChainWrapper<>(this.getBaseMapper())
                .like(StrUtil.isAllNotBlank(platformQuery.getPlatformName()), SysPlatform::getPlatformCode, platformQuery.getPlatformName())
                .like(StrUtil.isAllNotBlank(platformQuery.getPlatformCode()), SysPlatform::getPlatformCode, platformQuery.getPlatformCode())
                .page(platformEntityPage);
    }

    /**
     * 批量保存
     *
     * @param platformQueryList 平台查询List
     * @return {@link Boolean}
     */
    @Override
    public Boolean saveAllBatch(List<PlatformQuery> platformQueryList) {
        return Boolean.TRUE;
    }

}
