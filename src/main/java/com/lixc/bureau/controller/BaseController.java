package com.lixc.bureau.controller;

import com.lixc.bureau.util.Json;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class BaseController {

    protected Json json;

    protected Map<String, Object> map;

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpServletResponse response;

}
