package com.lixc.bureau.util;

import org.springframework.http.HttpStatus;

import java.util.HashMap;
import java.util.Map;

public class EduResult extends HashMap<String,Object> {
    private static final long serialVersionUID = 1L;

    public static EduResult result (int code, String message){
        EduResult result = new EduResult();
        result.put("resultCode",code);
        result.put("message",message);
        return result;
    }

    public static EduResult ok(){
        return result(HttpStatus.OK.value(),HttpStatus.OK.name());
    }
    public static EduResult ok(String message){
        return result(HttpStatus.OK.value(),message);
    }
    public static EduResult error(){
        return result(HttpStatus.INTERNAL_SERVER_ERROR.value(),"未知异常，请联系管理员");
    }
    public static EduResult error(String message){ return result(HttpStatus.INTERNAL_SERVER_ERROR.value(),message); }
    public static EduResult error(int code, String message){
        return result(code,message);
    }

    public EduResult put(String key, Object value) {
        super.put(key, value);
        return this;
    }

    public EduResult put(Map<String,Object> map){
        super.putAll(map);
        return this;
    }
}
