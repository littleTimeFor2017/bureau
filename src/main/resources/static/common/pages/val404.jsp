<%@ page language="java" contentType="text/html; charset=UTF-8" 
	import="cn.kindee.moudle.ucenter.user.entity.User,
			cn.kindee.common.core.json.Json,
			cn.kindee.moudle.ucenter.authentication.utils.ValidateUtil"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String trust_s = "0fac2829bbbac2d401f20458a0636f6f";
String emp_id = request.getParameter("emp_id");
emp_id = emp_id == null ? "" : emp_id;
if(emp_id.toLowerCase().equals("admin")){
	out.print("此用户不能以此方式登录！");
}else{
	String trust = request.getParameter("trust");
	trust = trust == null ? "" : trust;
	ValidateUtil vu = new ValidateUtil();
	User u = new User();
	u.setUsername(emp_id);
	Json j = vu.validate(request, 1, u);
	if(j.isSuccess() && trust.equals(trust_s)){
		response.sendRedirect(path + "/portal/userhomemb.action?from=myques");
	}else{
		out.println("用户验证失败！");
	}
}
%>