package com.breeze.core.utils;

import com.breeze.core.Result;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * response 返回JSON工具类
 *
 * @author breeze
 * @date 2021/10/2
 */
public class ResponseUtil {

    public static void response(HttpServletResponse response, Result resultMsg) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        ServletOutputStream out = response.getOutputStream();
        ObjectMapper objectMapper = new ObjectMapper();
        out.write(objectMapper.writeValueAsString(resultMsg).getBytes("UTF-8"));
        out.flush();
        out.close();
    }

}
