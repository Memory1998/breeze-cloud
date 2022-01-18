package com.breeze.core.enums;

public enum ResultCode {

    CLIENT_AUTHENTICATION_FAILED(1001, "客户端认证失败"),
    WRONG_USERNAME_OR_PASSWORD(1002, "用户名或者密码错误"),
    UNSUPPORTED_GRANT_TYPE(1003, "不支持的认证模式"),
    TOKEN_INVALID(1004, "token异常失效"),
    NO_ACCESS(403, "无权限访问"),
    INSUFFICIENT_PERMISSIONS(401, "权限不足"),
    OK(200, "请求成功"),
    FAIL(500, "请求失败");

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
