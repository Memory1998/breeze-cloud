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

package com.breeze.cloud.storage.local.template;

import cn.hutool.core.io.IoUtil;
import cn.hutool.core.lang.UUID;
import cn.hutool.core.util.StrUtil;
import com.breeze.cloud.core.enums.ContentType;
import com.breeze.cloud.core.enums.ResultCode;
import com.breeze.cloud.core.exception.SystemServiceException;
import com.breeze.cloud.storage.local.config.LocalProperties;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * 本地上传 工具
 *
 * @author gaoweixuan
 * @date 2022-11-14
 */
@Slf4j
public class LocalStorageTemplate {

    /**
     * 局部属性
     */
    @Autowired
    private LocalProperties localProperties;

    /**
     * 获取扩展名
     *
     * @param originalFileName 原始文件名字
     * @return {@link String}
     */
    public String getExtension(String originalFileName) {
        return originalFileName.substring(originalFileName.lastIndexOf("."));
    }

    /**
     * 获得新文件名
     *
     * @param exName 文件类型
     * @return {@link String}
     */
    public String getNewFileName(String exName) {
        return UUID.randomUUID() + exName;
    }

    /**
     * 上传文件
     *
     * @param file        文件
     * @param path        路径
     * @param newFileName 新文件名字
     * @return {@link String}
     */
    public String uploadFile(MultipartFile file, String path, String newFileName) {
        String originalFilename = file.getOriginalFilename();
        if (StrUtil.isEmpty(newFileName)) {
            assert originalFilename != null;
            //文件类型
            String extension = this.getExtension(originalFilename);
            newFileName = getNewFileName(extension);
        }
        File newFilePath = new File(localProperties.getRootPath() + path);
        if (!newFilePath.exists()) {
            newFilePath.mkdirs();
        }
        try {
            if (log.isInfoEnabled()) {
                log.info("[文件名]： {}， [类型]: {}，[文件大小]：{}", originalFilename, file.getContentType(), file.getSize());
            }
            FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(new File(newFilePath, newFileName)));
        } catch (IOException e) {
            log.error("[上传失败] {}", e.getMessage());
        }
        return path + "/" + newFileName;
    }

    /**
     * 下载
     *
     * @param path     路径
     * @param fileName 文件名称
     * @param response 响应
     */
    @SneakyThrows
    public void download(String path, String fileName, HttpServletResponse response) {
        File file = this.getFile(path);
        if (!file.exists()) {
            throw new SystemServiceException(ResultCode.exception("下载文件失败"));
        }
        response.setCharacterEncoding("utf-8");
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.setContentType(ContentType.getContentType(fileName));
        response.setHeader("Content-disposition", "attachment;filename*=utf-8" + URLEncoder.encode(fileName, StandardCharsets.UTF_8.name()));
        try (FileInputStream fis = new FileInputStream(file)) {
            OutputStream os = response.getOutputStream();
            IoUtil.copy(fis, os);
        } catch (Exception e) {
            log.error("[下载失败]", e);
        }
    }

    /**
     * @param path 路径 + 名称
     * @return {@link File}
     */
    @NotNull
    private File getFile(String path) {
        return new File(this.localProperties.getRootPath(), path);
    }

    /**
     * 预览
     *
     * @param path        路径
     * @param newFileName 名称
     * @return {@link String}
     */
    public String previewImg(String path, String newFileName) {
        return this.localProperties.getNginxHost() + path + newFileName;
    }

    /**
     * 删除
     *
     * @param path 路径 + 名称
     * @return boolean
     */
    public boolean remove(String path) {
        File file = getFile(path);
        if (!file.exists()) {
            log.error("[文件不存在]");
            return false;
        }
        return file.delete();
    }
}
