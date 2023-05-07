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

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.breeze.cloud.system.domain.SysUserMsgSnapshot;
import com.breeze.cloud.system.mapper.SysUserMsgSnapshotMapper;
import com.breeze.cloud.system.query.UserMsgQuery;
import com.breeze.cloud.system.service.SysUserMsgSnapshotService;
import com.breeze.cloud.system.vo.SysUserMsgSnapshotVO;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 系统用户消息快照服务impl
 *
 * @author gaoweixuan
 * @date 2022-11-26
 */
@Service
@AllArgsConstructor
public class SysUserMsgSnapshotServiceImpl extends ServiceImpl<SysUserMsgSnapshotMapper, SysUserMsgSnapshot> implements SysUserMsgSnapshotService {

    /**
     * 列表页面
     *
     * @param userMsgQuery 用户消息查询
     * @return {@link IPage}<{@link SysUserMsgSnapshotVO}>
     */
    @Override
    public IPage<SysUserMsgSnapshotVO> listPage(UserMsgQuery userMsgQuery) {
        return this.baseMapper.listPage(new Page<>(userMsgQuery.getCurrent(), userMsgQuery.getSize()), userMsgQuery);
    }

    /**
     * 获取消息列表通过用户名
     *
     * @param username 用户名
     * @return {@link List}<{@link SysUserMsgSnapshotVO}>
     */
    @Override
    public List<SysUserMsgSnapshotVO> listMsgByUsername(String username) {
        return this.baseMapper.listMsgByUsername(username);
    }

}
