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

package com.breeze.cloud.core.utils;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.write.style.column.SimpleColumnWidthStyleStrategy;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

/**
 * 简单excel导出
 *
 * @author gaoweixuan
 * @date 2022-12-09
 */
@Slf4j
public class EasyExcelExport {

    /**
     * EasyExcel导出
     *
     * @param response  响应
     * @param excelName excel名字
     * @param sheetName 表名字
     * @param dataList  数据列表
     * @param clazz     clazz
     */
    public static void export(HttpServletResponse response, String excelName, String sheetName, List<?> dataList, Class clazz) {
        response.setContentType("application/vnd.ms-excel");
        response.setCharacterEncoding("utf-8");
        String fileName = null;
        try {
            fileName = URLEncoder.encode(excelName, "UTF-8").replaceAll("\\+", "%20");
            response.setHeader("original-file-name", fileName);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        response.setHeader("Content-disposition", "attachment;filename=" + fileName + ".xlsx");
        try {
            EasyExcel.write(response.getOutputStream(), clazz)
                    .registerWriteHandler(new SimpleColumnWidthStyleStrategy(25))
                    .sheet(sheetName)
                    .doWrite(dataList);
        } catch (IOException e) {
            log.error("导出失败", e);
        }
    }
}
