<%@ page language="java" contentType="text/html; charset=UTF-8"
         import="com.baidu.ueditor.ActionEnter"
         pageEncoding="UTF-8"%>
<%

    request.setCharacterEncoding("utf-8");
    response.setHeader("Content-Type", "text/html");
    String rootPath = application.getRealPath("/");
    System.out.println("rootPath!"+rootPath);
    out.write(new ActionEnter(request, rootPath).exec());

%>