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

package com.breeze.cloud.storage.minio.config;

import cn.hutool.core.img.ImgUtil;
import cn.hutool.core.io.FileUtil;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.awt.*;

/**
 * minio配置
 *
 * @author gaoweixuan
 * @date 2022-11-15
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class MinioImgMark {

    /**
     * 水印文本
     */
    private String pressText;

    /**
     * 水印图片
     * TODO
     */
    private Image pressImg = ImgUtil.read(FileUtil.file("D:/logo.jpg"));

    /**
     * x
     */
    private int x;

    /**
     * y
     */
    private int y;

    /**
     * 透明度
     */
    private float alpha;

}
