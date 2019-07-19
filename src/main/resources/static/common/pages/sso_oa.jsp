<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="cn.kindee.common.core.support.UserToken,
				java.util.*,
				cn.kindee.moudle.ucenter.user.entity.User,
				cn.kindee.common.core.support.SystemContext,
				cn.kindee.common.core.json.JsonUtils,
				cn.kindee.moudle.ucenter.authentication.provider.IAuthenticationProvider"
%>

<%
	//response.setHeader("Access-Control-Allow-Origin","*");
	//response.setHeader("Access-Control-Allow-Credentials","true");

	String way=request.getParameter("way");
	if(way ==null || way.equals(""))   {out.print("callbackget({\"msg\":\"parameter way is null\",\"status\":0,\"success\":false,\"valid\":false})"); return;}
	else if(way.equals("get")){
		String wxid=request.getParameter("wxid");
		if(wxid ==null || wxid.equals(""))   {out.print("callbackget({\"msg\":\"parameter wxid is null\",\"status\":0,\"success\":false,\"valid\":false})"); return;}
		IAuthenticationProvider  iser_sso =SystemContext.getSpringBean("ssoAuthenticationProvider");
		User user = new User(); user.setWx_openid(wxid); user.setFrom("gfosget");
		cn.kindee.common.core.json.Json json= iser_sso.authenticate(user);

		out.print("callbackget "+"("+ JsonUtils.toJsonString(json)+")");
	}
	else if(way.equals("post")){
		String wxid=request.getParameter("wxid");
		if(wxid ==null || wxid.equals(""))   {out.print("callbackget({\"msg\":\"parameter wxid is null\",\"status\":0,\"success\":false,\"valid\":false})"); return;}
		String uname=request.getParameter("membername");
		String pwd=request.getParameter("password");
		if(uname ==null || uname.equals("") || pwd ==null || pwd.equals(""))   {out.print("callbackget({\"msg\":\"parameter username is null\",\"status\":0,\"success\":false,\"valid\":false})"); return;}
		User user = new User(); user.setWx_openid(wxid); user.setFrom("gfospost");
		user.setUsername(uname); user.setPassword(pwd);
		IAuthenticationProvider  iser_sso =SystemContext.getSpringBean("ssoAuthenticationProvider");
		cn.kindee.common.core.json.Json json= iser_sso.authenticate(user);
		out.print("callbackset "+"("+ JsonUtils.toJsonString(json)+")");
	}
	else
	{out.print("callbackget({\"msg\":\"parameter way is null\",\"status\":0,\"success\":false,\"valid\":false})"); return;}
	%>
