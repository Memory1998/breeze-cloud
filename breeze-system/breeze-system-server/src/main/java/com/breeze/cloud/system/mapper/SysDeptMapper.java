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

package com.breeze.cloud.system.mapper;

import com.breeze.cloud.mybatis.mapper.BreezeBaseMapper;
import com.breeze.cloud.system.domain.SysDept;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 系统部门映射器
 *
 * @author gaoweixuan
 * @date 2021-12-06 22:03:39
 */
@Mapper
public interface SysDeptMapper extends BreezeBaseMapper<SysDept> {


    /**
     * 查询部门
     *
     * @param id id
     * @return {@link List}<{@link SysDept}>
     */
    List<SysDept> selectDeptById(@Param("id") Long id);

    /**
     * 查询部门
     *
     * @param parentId 父id
     * @return {@link List}<{@link SysDept}>
     */
    List<SysDept> selectDeptByParentId(@Param("parentId") Long parentId);

}
