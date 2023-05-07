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
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.cloud.system.domain.SysMsg;
import com.breeze.cloud.system.mapper.SysMsgMapper;
import com.breeze.cloud.system.query.MsgQuery;
import com.breeze.cloud.system.service.SysMsgService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * 系统消息服务
 *
 * @author gaoweixuan
 * @date 2022-11-20
 */
@Service
@AllArgsConstructor
public class SysMsgServiceImpl extends ServiceImpl<SysMsgMapper, SysMsg> implements SysMsgService {

    /**
     * 列表页面
     *
     * @param msgQuery 消息查询
     * @return {@link IPage}<{@link SysMsg}>
     */
    @Override
    public IPage<SysMsg> listPage(MsgQuery msgQuery) {
        Page<SysMsg> msgPage = new Page<>(msgQuery.getCurrent(), msgQuery.getSize());
        return new LambdaQueryChainWrapper<>(this.getBaseMapper())
                .like(StrUtil.isAllNotBlank(msgQuery.getMsgTitle()), SysMsg::getMsgTitle, msgQuery.getMsgTitle())
                .like(StrUtil.isAllNotBlank(msgQuery.getMsgCode()), SysMsg::getMsgCode, msgQuery.getMsgCode())
                .page(msgPage);
    }

    /**
     * 得到系统消息
     *
     * @param msgCode 消息代码
     * @return {@link SysMsg}
     */
    @Override
    public SysMsg getSysMsg(String msgCode) {
        return this.getOne(Wrappers.<SysMsg>lambdaQuery().eq(SysMsg::getMsgCode, msgCode));
    }
}
