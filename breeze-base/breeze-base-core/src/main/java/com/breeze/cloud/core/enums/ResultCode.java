package com.breeze.cloud.core.enums;

/**
 * 返回code枚举
 *
 * @author breeze
 * @date 2021/10/1
 */
public enum ResultCode {

    CLIENT_AUTHENTICATION_FAILED(1001, "客户端认证失败"),
    WRONG_USERNAME_OR_PASSWORD(1002, "用户名或者密码错误"),
    UNSUPPORTED_GRANT_TYPE(1003, "不支持的认证模式"),
    TOKEN_INVALID(1004, "验证失效"),
    USERNAME_NOT_FOUND_EXCEPTION(1005, "用户名或者密码错误"),
    FEIGN_INTERNAL_AUTHENTICATION_SERVICE_EXCEPTION(5003, "内部身份验证服务异常"),
    FORBIDDEN(403, "无权限访问"),
    UNAUTHORIZED(401, "系统未授权"),
    INTERNAL_SERVER_ERROR(500, "服务器错误"),
    OK(1, "请求成功"),
    FAIL(0, "请求失败");

    private int code;

    private String desc;

    ResultCode(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

}
