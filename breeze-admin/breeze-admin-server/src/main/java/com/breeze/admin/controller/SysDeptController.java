package com.breeze.admin.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.breeze.admin.entity.SysDeptEntity;
import com.breeze.admin.service.SysDeptService;
import com.breeze.core.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@RestController
@RequestMapping("/sys/dept")
public class SysDeptController {

    @Autowired
    private SysDeptService sysDeptService;

    /**
     * 列表
     */
    @GetMapping("/page")
    @PreAuthorize("hasAnyAuthority('sys:dept:page')")
    public Result<IPage<SysDeptEntity>> listPage(Page<SysDeptEntity> page, SysDeptEntity deptEntity) {
        return Result.ok(this.sysDeptService.page(page, Wrappers.query(deptEntity)));
    }

    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    @PreAuthorize("hasAnyAuthority('sys:dept:info')")
    public Result info(@PathVariable("id") Long id) {
        SysDeptEntity sysDept = sysDeptService.getById(id);
        return Result.ok(sysDept);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    @PreAuthorize("hasAnyAuthority('sys:dept:save')")
    public Result save(@RequestBody SysDeptEntity sysDept) {
        boolean save = sysDeptService.save(sysDept);
        return Result.ok(save);
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    @PreAuthorize("hasAnyAuthority('sys:dept:update')")
    public Result update(@RequestBody SysDeptEntity sysDept) {
        boolean updateById = this.sysDeptService.updateById(sysDept);
        return Result.ok(updateById);
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @PreAuthorize("hasAnyAuthority('sys:dept:delete')")
    public Result delete(@RequestBody Long[] ids) {
        boolean remove = this.sysDeptService.removeByIds(Arrays.asList(ids));
        return Result.ok(remove);
    }

}
