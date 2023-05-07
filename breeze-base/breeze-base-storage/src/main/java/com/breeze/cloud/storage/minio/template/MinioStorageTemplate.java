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

package com.breeze.cloud.storage.minio.template;

import cn.hutool.core.img.ImgUtil;
import cn.hutool.core.io.IoUtil;
import cn.hutool.core.util.StrUtil;
import com.breeze.cloud.core.enums.ContentType;
import com.breeze.cloud.core.enums.ResultCode;
import com.breeze.cloud.core.exception.SystemServiceException;
import com.breeze.cloud.storage.minio.config.BreezeMinioProperties;
import com.breeze.cloud.storage.minio.config.MinioImgMark;
import io.minio.*;
import io.minio.http.Method;
import io.minio.messages.Bucket;
import io.minio.messages.DeleteObject;
import io.minio.messages.Item;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.compress.utils.Lists;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Collectors;

/**
 * minio 请求服务
 *
 * @author gaoweixuan
 * @date 2022-11-14
 */
@Slf4j
@RequiredArgsConstructor
public class MinioStorageTemplate {

    /**
     * minio客户
     */
    private final MinioClient minioClient;

    /**
     * minio属性
     */
    private final BreezeMinioProperties minioProperties;

    /**
     * 创建bucket
     *
     * @param bucketName bucket名称
     */
    public void createBucket(String bucketName) {
        try {
            if (minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build())) {
                log.debug("[桶已存在无需创建]：{}", bucketName);
                return;
            }
            minioClient.makeBucket(MakeBucketArgs.builder().bucket(bucketName).build());
        } catch (Exception e) {
            log.error("[Bucket 创建失败]", e);
        }
    }

    /**
     * 上传文件添加图片水印
     *
     * @param bucketName   bucket名称
     * @param objectName   对象名称
     * @param file         文件
     * @param minioImgMark minio img配置
     * @return {@link String}
     */
    public String uploadImageForImageMark(String bucketName,
                                          String objectName,
                                          MultipartFile file,
                                          MinioImgMark minioImgMark) {
        BufferedImage read;
        Image image = null;
        try {
            InputStream inputStream = file.getInputStream();
            read = ImgUtil.read(inputStream);
            image = ImgUtil.pressImage(
                    read,
                    //水印图片
                    minioImgMark.getPressImg(),
                    //x坐标修正值。 默认在中间，偏移量相对于中间偏移
                    0,
                    //y坐标修正值。 默认在中间，偏移量相对于中间偏移
                    0,
                    0.8f);
        } catch (IOException e) {
            log.error("", e);
        }
        return this.uploadImg(bucketName, objectName, (BufferedImage) image);
    }

    /**
     * 上传文件添加文本水印
     *
     * @param bucketName   bucket名称
     * @param objectName   对象名称
     * @param file         文件
     * @param minioImgMark minio img配置
     * @return {@link String}
     */
    public String uploadFileForTextMark(String bucketName,
                                        String objectName,
                                        MultipartFile file,
                                        MinioImgMark minioImgMark) {

        BufferedImage read;
        Image image = null;
        try {
            InputStream inputStream = file.getInputStream();
            read = ImgUtil.read(inputStream);
            image = ImgUtil.pressText(
                    read,
                    minioImgMark.getPressText(),
                    Color.WHITE,
                    new Font("微软雅黑", Font.BOLD, 40),
                    0,
                    0,
                    0.8F);
        } catch (Exception e) {
            log.error("上传失败", e);
        }
        return this.uploadImg(bucketName, objectName, (BufferedImage) image);
    }

    /**
     * 上传img
     *
     * @param bucketName 路径
     * @param objectName 原始文件名
     * @param image      图像
     * @return {@link String}
     */
    public String uploadImg(String bucketName, String objectName, BufferedImage image) {
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        try {
            // 一切图片转为 jpeg
            ImageIO.write(image, "jpeg", os);
        } catch (IOException e) {
            log.error("文件转换 bs IO 异常", e);
        }
        return this.putObject(bucketName, objectName, new ByteArrayInputStream(os.toByteArray()), ContentType.JPE.getContentType());
    }

    /**
     * 上传对象到minio
     *
     * @param bucketName  bucket名称
     * @param objectName  对象名称
     * @param stream      流
     * @param contentType 内容类型
     * @return {@link String}
     */
    public String putObject(String bucketName, String objectName, InputStream stream, String contentType) {
        this.createBucket(bucketName);
        ObjectWriteResponse response = null;
        try {
            response = this.minioClient.putObject(
                    PutObjectArgs.builder()
                            .bucket(bucketName)
                            .object(objectName)
                            .stream(stream, stream.available(), -1)
                            .contentType(contentType)
                            .build());
        } catch (Exception e) {
            log.error("文件上传失败", e);
        }
        String imageUrl = this.minioProperties.getNginxHost() + bucketName + '/' + objectName;
        log.info("[nginx访问地址]： {}, [上传的结果]：{}", imageUrl, response);
        return imageUrl;
    }


    /**
     * 桶是否存在
     *
     * @param bucketName bucket名称
     * @return boolean
     */
    public Boolean bucketIsExists(String bucketName) {
        try {
            return minioClient.bucketExists(BucketExistsArgs.builder().bucket(bucketName).build());
        } catch (Exception e) {
            log.error("[Bucket 获取失败]", e);
            return false;
        }
    }

    /**
     * 获取桶中对象列表
     *
     * @param bucketName bucket名称
     * @return {@link List}<{@link Item}>
     */
    public List<Item> listObjects(String bucketName) {
        if (StrUtil.isAllBlank(bucketName) || !bucketIsExists(bucketName)) {
            return Lists.newArrayList();
        }
        Iterable<Result<Item>> itemResult = getItemResult(bucketName);
        List<Item> items = Lists.newArrayList();
        try {
            for (Result<Item> result : itemResult) {
                items.add(result.get());
            }
        } catch (Exception e) {
            log.error("获取文件对象失败", e);
        }
        return items;
    }

    /**
     * 获取文件项
     *
     * @param bucketName bucket名称
     * @return {@link Iterable}<{@link Result}<{@link Item}>>
     */
    private Iterable<Result<Item>> getItemResult(String bucketName) {
        return this.minioClient.listObjects(ListObjectsArgs.builder().bucket(bucketName).build());
    }

    /**
     * 删除桶
     *
     * @param bucketName bucket名称
     * @return {@link Boolean}
     */
    public Boolean removeBucket(String bucketName) {
        try {
            minioClient.removeBucket(
                    RemoveBucketArgs
                            .builder()
                            .bucket(bucketName)
                            .build());
        } catch (Exception e) {
            log.error("[删除Bucket失败]", e);
            return false;
        }
        return true;
    }

    /**
     * 得到一个桶所有对象名称
     *
     * @param bucketName 桶名称
     * @return {@link List}<{@link String}>
     */
    public List<String> getOneBucketAllObjectName(String bucketName) {
        boolean isExists = this.bucketIsExists(bucketName);
        if (!isExists) {
            throw new SystemServiceException(ResultCode.exception("桶不存在"));
        }
        List<String> objNameList = Lists.newArrayList();
        try {
            Iterable<Result<Item>> resultIterable = getItemResult(bucketName);
            resultIterable.forEach(result -> this.getItem(objNameList, result));
            return objNameList;
        } catch (Exception e) {
            log.error("", e);
        }
        return Lists.newArrayList();
    }

    /**
     * 获取文件项
     *
     * @param objNameList 对象名称
     * @param resultItem  文件项
     */
    private void getItem(List<String> objNameList, Result<Item> resultItem) {
        try {
            Item item = resultItem.get();
            objNameList.add(item.objectName());
        } catch (Exception e) {
            log.error("", e);
        }
    }

    /**
     * 查询所有桶
     *
     * @return {@link List}<{@link Bucket}>
     */
    public List<Bucket> listAllBuckets() {
        try {
            return minioClient.listBuckets();
        } catch (Exception e) {
            log.error("获取失败", e);
        }
        return Lists.newArrayList();
    }

    /**
     * 删除
     *
     * @param bucketName bucket名称
     * @param objectName 对象名称
     * @return boolean
     */
    public boolean remove(String bucketName, String objectName) {
        try {
            this.minioClient.removeObject(RemoveObjectArgs.builder().bucket(bucketName)
                    .object(objectName).build());
        } catch (Exception e) {
            log.error("删除失败", e);
            return false;
        }
        return true;
    }

    /**
     * 批量删除文件
     *
     * @param bucket      桶名称
     * @param objectNames 对象名称
     * @return boolean
     */
    public boolean removeBatch(String bucket, List<String> objectNames) {
        boolean bucketIsExists = bucketIsExists(bucket);
        if (!bucketIsExists) {
            return false;
        }
        try {
            List<DeleteObject> deleteObjList = objectNames.stream().map(DeleteObject::new).collect(Collectors.toList());
            this.minioClient.removeObjects(RemoveObjectsArgs.builder().bucket(bucket).objects(deleteObjList).build());
            return true;
        } catch (Exception e) {
            log.error("删除失败", e);
        }
        return false;
    }

    /**
     * 预览图片
     *
     * @param bucketName bucket名称
     * @param objectName 对象名称
     * @return {@link String}
     */
    public String previewImage(String bucketName, String objectName) {
        // 查看文件地址
        GetPresignedObjectUrlArgs build = GetPresignedObjectUrlArgs.builder()
                .bucket(bucketName)
                .object(objectName)
                .method(Method.GET)
                .build();
        try {
            return this.minioClient.getPresignedObjectUrl(build);
        } catch (Exception e) {
            log.error("获取资源失败", e);
        }
        return "";
    }

    /**
     * 下载
     *
     * @param bucketName       bucket名称
     * @param objectName       对象名称
     * @param originalFilename 原文件名称
     * @param response         响应
     */
    public void download(String bucketName, String objectName, String originalFilename, HttpServletResponse response) {
        GetObjectArgs objectArgs = GetObjectArgs.builder().bucket(bucketName)
                .object(objectName).build();
        try (GetObjectResponse objectResponse = this.minioClient.getObject(objectArgs)) {
            response.setCharacterEncoding(StandardCharsets.UTF_8.name());
            response.setContentType(ContentType.getContentType(objectName));
            response.setHeader("Content-disposition", "attachment;filename*=utf-8" + URLEncoder.encode(originalFilename, StandardCharsets.UTF_8.name()));
            OutputStream os = response.getOutputStream();
            IoUtil.copy(objectResponse, os);
        } catch (Exception e) {
            log.error("下载失败", e);
        }
    }

}
