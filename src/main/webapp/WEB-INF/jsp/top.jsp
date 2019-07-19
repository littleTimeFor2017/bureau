<%@ page import="com.lixc.bureau.constants.BureauConstants" %>
<%@ page import="com.lixc.bureau.entity.User" %>
<%@ page import="org.springframework.util.StringUtils" %>
<%@page contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
%>
<div class="top_box">
    <% Object object = request.getSession().getAttribute(BureauConstants.USER_TOKEN);
        String userName = "";
        if (!StringUtils.isEmpty(object)) {
            User user = (User) object;
            userName = user.getUserName();
        }
    %>
    <%=userName%>你好，欢迎！&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="/bureau/user/loginforward">登录</a>&nbsp;
</div>