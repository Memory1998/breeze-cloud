/*
 * Copyright 2021 the original author or authors.
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

package com.breeze.cloud.core;

import com.breeze.cloud.core.enums.ResultCode;

import java.io.Serializable;

/**
 * @param <T>
 * @author breeze
 * @date 2021/10/1
 */
public class Result<T> implements Serializable {

    private static final long serialVersionUID = 1L;

    private int code;

    private String message;

    private T data;

    private Result() {

    }

    public static <T> Result<T> ok(T data) {
        Result<T> result = new Result();
        result.setCode(ResultCode.OK.getCode());
        result.setMessage(ResultCode.OK.getDesc());
        result.setData(data);
        return result;
    }

    public static Result ok() {
        Result result = new Result();
        result.setCode(ResultCode.OK.getCode());
        result.setMessage(ResultCode.OK.getDesc());
        return result;
    }

    public static <T> Result<T> fail(String message) {
        Result<T> result = new Result();
        result.setCode(ResultCode.FAIL.getCode());
        result.setMessage(ResultCode.FAIL.getDesc());
        return result;
    }

    public static <T> Result<T> fail(T data, String message) {
        Result<T> result = new Result();
        result.setCode(ResultCode.FAIL.getCode());
        result.setMessage(message);
        result.setData(data);
        return result;
    }

    public static <T> Result<T> fail(ResultCode resultCode) {
        Result<T> result = new Result();
        result.setCode(resultCode.getCode());
        result.setMessage(resultCode.getDesc());
        return result;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
