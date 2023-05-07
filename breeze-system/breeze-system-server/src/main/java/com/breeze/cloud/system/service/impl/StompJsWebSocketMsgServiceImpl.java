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

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.system.domain.SysMsg;
import com.breeze.cloud.system.domain.SysUser;
import com.breeze.cloud.system.domain.SysUserMsg;
import com.breeze.cloud.system.domain.SysUserMsgSnapshot;
import com.breeze.cloud.system.service.SysMsgService;
import com.breeze.cloud.system.service.SysUserMsgService;
import com.breeze.cloud.system.service.SysUserMsgSnapshotService;
import com.breeze.cloud.system.service.SysUserService;
import com.breeze.cloud.websocket.bo.UserMsgBO;
import com.breeze.cloud.websocket.events.MsgSaveEvent;
import com.breeze.cloud.websocket.events.PublisherSaveMsgEvent;
import com.breeze.cloud.websocket.params.MsgParam;
import com.breeze.cloud.websocket.service.WebSocketMsgService;
import com.breeze.cloud.websocket.vo.MsgVO;
import com.google.common.collect.Lists;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

/**
 * stompJs 消息模块接口impl
 *
 * @author gaoweixuan
 * @date 2022-10-08
 */
@Slf4j
@Service("stompJsMsgService")
@AllArgsConstructor
public class StompJsWebSocketMsgServiceImpl extends WebSocketMsgService {

    /**
     * 简单消息模板
     */
    private final SimpMessagingTemplate simpMessagingTemplate;

    /**
     * 保存消息事件
     */
    private final PublisherSaveMsgEvent publisherSaveMsgEvent;

    /**
     * 系统用户消息服务
     */
    private final SysUserMsgService sysUserMsgService;

    /**
     * 系统用户消息快照服务
     */
    private final SysUserMsgSnapshotService sysUserMsgSnapshotService;

    /**
     * 系统消息服务
     */
    private final SysMsgService sysMsgService;

    /**
     * 系统用户服务
     */
    private final SysUserService sysUserService;

    /**
     * 消息广播
     *
     * @param msgParam 消息参数
     * @return {@link Result}<{@link MsgVO}>
     */
    @Override
    public Result<MsgVO> sendBroadcastMsg(MsgParam msgParam) {
        SysMsg sysMsg = this.sysMsgService.getById(msgParam.getMsgId());
        List<SysUser> userList = this.sysUserService.list();
        List<UserMsgBO.MsgBodyBO> msgBodyBOList = Lists.newArrayList();
        for (SysUser user : userList) {
            msgBodyBOList.add(UserMsgBO.MsgBodyBO.builder()
                    .msgCode(sysMsg.getMsgCode())
                    .userId(user.getId())
                    .build());
        }
        this.asyncSendMsg(sysMsg, msgBodyBOList);
        return Result.ok(MsgVO.builder()
                .msgTitle(sysMsg.getMsgTitle())
                .msgCode(sysMsg.getMsgCode())
                .msgLevel(sysMsg.getMsgLevel())
                .msgType(sysMsg.getMsgType())
                .content(sysMsg.getContent())
                .build());
    }

    /**
     * 发送消息给用户
     *
     * @param msgParam  消息参数
     * @param principal 主要
     * @return {@link Result}<{@link MsgVO}>
     */
    @Override
    public Result<MsgVO> sendMsgToSingleUser(Principal principal, MsgParam msgParam) {
        log.debug("[msgId]：{}, [username]： {}", msgParam, principal.getName());
        SysMsg sysMsg = this.sysMsgService.getById(msgParam);
        this.asyncSendMsg(sysMsg, Lists.newArrayList());
        return Result.ok(MsgVO.builder()
                .msgTitle(sysMsg.getMsgTitle())
                .msgCode(sysMsg.getMsgCode())
                .msgLevel(sysMsg.getMsgLevel())
                .content(sysMsg.getContent())
                .msgType(sysMsg.getMsgType())
                .build());
    }

    /**
     * 异步发送消息
     *
     * @param sysMsg        系统消息
     * @param msgBodyBOList 系统用户消息BO列表
     */
    private void asyncSendMsg(SysMsg sysMsg, List<UserMsgBO.MsgBodyBO> msgBodyBOList) {
        UserMsgBO userMsgBO = new UserMsgBO();
        userMsgBO.setMsgBodyBOList(msgBodyBOList);
        userMsgBO.setSysUserMsgSnapshotBO(this.buildSysUserMsgSnapshot(sysMsg));
        this.publisherSaveMsgEvent.publisherEvent(new MsgSaveEvent(userMsgBO));
    }

    /**
     * 构建系统用户消息快照BO
     *
     * @param sysMsg sys消息
     * @return {@link UserMsgBO.SysUserMsgSnapshotBO}
     */
    private UserMsgBO.SysUserMsgSnapshotBO buildSysUserMsgSnapshot(SysMsg sysMsg) {
        UserMsgBO.SysUserMsgSnapshotBO userMsgSnapshot = com.breeze.cloud.websocket.bo.UserMsgBO.SysUserMsgSnapshotBO.builder().build();
        BeanUtil.copyProperties(sysMsg, userMsgSnapshot, CopyOptions.create().setIgnoreProperties("id").setIgnoreNullValue(true).setIgnoreError(true));
        userMsgSnapshot.setMsgId(sysMsg.getId());
        return userMsgSnapshot;
    }

    /**
     * 保存消息快照
     *
     * @param userMsgBO 用户消息BO
     */
    public void saveMsgSnapped(UserMsgBO userMsgBO) {
        // 保存的实体
        SysUserMsgSnapshot userMsgContent = SysUserMsgSnapshot.builder().build();
        BeanUtil.copyProperties(userMsgBO.getSysUserMsgSnapshotBO(), userMsgContent,
                CopyOptions.create().setIgnoreProperties("id").setIgnoreNullValue(true).setIgnoreError(true));
        this.sysUserMsgSnapshotService.save(userMsgContent);
        List<SysUserMsg> sysUserMsgList = userMsgBO.getMsgBodyBOList().stream()
                .map(sysMsgBO -> SysUserMsg.builder()
                        .userId(sysMsgBO.getUserId())
                        .msgCode(sysMsgBO.getMsgCode())
                        .msgSnapshotId(userMsgContent.getId())
                        .build())
                .collect(Collectors.toList());
        this.sysUserMsgService.saveBatch(sysUserMsgList);
    }

    /**
     * 发送消息给指定用户
     *
     * @param msgParam  消息参数
     * @param principal 主要
     */
    @Override
    public void sendMsgToUser(Principal principal, MsgParam msgParam) {
        log.debug("[msgId]： {}, [username]： {}", msgParam.getMsgId(), principal.getName());
        SysMsg sysMsg = this.sysMsgService.getById(msgParam.getMsgId());
        MsgVO msgVO = MsgVO.builder().msgTitle(sysMsg.getMsgTitle())
                .msgCode(sysMsg.getMsgCode())
                .msgLevel(sysMsg.getMsgLevel())
                .content(sysMsg.getContent())
                .msgType(sysMsg.getMsgType()).build();
        List<UserMsgBO.MsgBodyBO> sysUserMsgList = Lists.newArrayList();
        List<SysUser> sysUserList = this.sysUserService.listByIds(msgParam.getUserIds());
        for (SysUser sysUser : sysUserList) {
            this.simpMessagingTemplate.convertAndSendToUser(sysUser.getUsername(), "/queue/userMsg", Result.ok(msgVO));
            sysUserMsgList.add(UserMsgBO.MsgBodyBO.builder()
                    .msgCode(sysMsg.getMsgCode()).userId(sysUser.getId())
                    .build());
        }
        this.asyncSendMsg(sysMsg, sysUserMsgList);
    }

}
