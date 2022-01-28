package com.breeze.cloud.admin.entity;

import com.alibaba.excel.annotation.ExcelIgnore;
import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDateTime;

/**
 * @author breeze
 * @date 2021-12-06 22:03:39
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class BaseModel<T> extends Model<BaseModel<T>> {

    /**
     * id
     */
    @TableId(value = "id", type = IdType.ASSIGN_ID)
    @ApiModelProperty(value = "主键")
    @ExcelIgnore
    private Long id;

    /**
     * 是否删除 1 已删除 0 未删除
     */
    @JsonIgnore
    @ApiModelProperty(value = "是否删除 1 已删除 0 未删除", hidden = true)
    @ExcelIgnore
    @TableLogic
    private Integer isDelete;

    /**
     * 删除人工号
     */
    @JsonIgnore
    @ApiModelProperty(value = "删除人工号", hidden = true)
    @ExcelIgnore
    private String deleteBy;

    /**
     * createdBy
     */
    @ApiModelProperty(value = "创建人", hidden = true)
    @ExcelIgnore
    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    /**
     * createdTime
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty(value = "创建人", hidden = true)
    @ExcelIgnore
    @TableField(fill = FieldFill.INSERT)
    private String createName;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty(value = "创建时间", hidden = true)
    @ExcelIgnore
    @TableField(fill = FieldFill.INSERT)
    private LocalDateTime createTime;

    /**
     * 修改人
     */
    @ApiModelProperty(value = "修改人", hidden = true)
    @ExcelIgnore
    @TableField(fill = FieldFill.UPDATE)
    private String updateBy;

    /**
     * 修改人
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty(value = "修改人", hidden = true)
    @TableField(fill = FieldFill.UPDATE)
    private String updateName;

    /**
     * 修改时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    @ApiModelProperty(value = "修改时间", hidden = true)
    @TableField(fill = FieldFill.UPDATE)
    private LocalDateTime updateTime;

}
