package com.breeze.cloud.mybatis.exception;

import com.breeze.cloud.core.enums.ResultCode;

/**
 * 租户未获取到值异常
 *
 * @author gaoweixuan
 * @date 2023/04/16
 */
public class TenantNotValueException extends RuntimeException {

    private final String msg;
    private int code = 0;

    public TenantNotValueException(ResultCode resultCode) {
        super(resultCode.getMsg());
        this.code = resultCode.getCode();
        this.msg = resultCode.getMsg();
    }

    public TenantNotValueException(String msg) {
        super(msg);
        this.msg = msg;
    }
}
