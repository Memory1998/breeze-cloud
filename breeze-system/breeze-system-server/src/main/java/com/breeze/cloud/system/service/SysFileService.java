/*
 * Copyright (c) 2023, gaoweixuan (breeze-cloud@foxmail.com).
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.breeze.cloud.system.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.breeze.cloud.core.utils.Result;
import com.breeze.cloud.system.domain.SysFile;
import com.breeze.cloud.system.params.FileParam;
import com.breeze.cloud.system.query.FileQuery;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * 系统文件服务
 *
 * @author gaoweixuan
 * @date 2022-09-02
 */
public interface SysFileService extends IService<SysFile> {

    /**
     * 列表页面
     *
     * @param fileQuery 文件查询
     * @return {@link Page}<{@link SysFile}>
     */
    Page<SysFile> listPage(FileQuery fileQuery);

    /**
     * 上传minio
     *
     * @param fileParam 文件上传参数
     * @param request   请求
     * @param response  响应
     * @return {@link Result}<{@link Map}<{@link String}, {@link Object}>>
     */
    Result<Map<String, Object>> uploadMinioS3(FileParam fileParam, HttpServletRequest request, HttpServletResponse response);

    /**
     * 上传本地存储
     *
     * @param fileParam 文件参数
     * @param request   请求
     * @param response  响应
     * @return {@link Result}<{@link Map}<{@link String}, {@link Object}>>
     */
    Result<Map<String, Object>> uploadLocalStorage(FileParam fileParam, HttpServletRequest request, HttpServletResponse response);

    /**
     * 预览
     *
     * @param fileId 文件ID
     * @return {@link Result}<{@link Boolean}>
     */
    String preview(Long fileId);

    /**
     * 下载
     *
     * @param fileId   文件标识
     * @param response 响应
     */
    void download(Long fileId, HttpServletResponse response);

    /**
     * 通过id删除文件
     *
     * @param fileIds 文件IDS
     * @return {@link Result}<{@link Boolean}>
     */
    Result<Boolean> removeFileByIds(List<Long> fileIds);

}
