<%@ page language="java" contentType="text/html; charset=UTF-8" 
	import="cn.kindee.common.core.support.Constants,
			cn.kindee.common.core.utils.ConfigUtil,
			cn.kindee.common.core.support.UserToken,cn.kindee.common.core.support.SessionContext"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String domain = request.getServerName();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
//本地不SSO
//if("localhost".equals(domain) || "127.0.0.1".equals(domain)){

	String target = request.getParameter("target");
	if(target ==null ||  "".equals(target) )
	{response.sendRedirect(path);  return;}


if(target.indexOf("getIndexRegisterDetailsToReg") >= 0){
	String toUrl = path + "/goLogin.action";
	Cookie cookie = null;
		cookie = new Cookie("sso_target", target);
		cookie.setMaxAge(-1);
		cookie.setPath("/");
		response.addCookie(cookie);
		if(target.indexOf("getIndexRegisterDetailsToReg") >= 0){
			toUrl = path + "/" + target;
		}
	response.sendRedirect(toUrl);
	return;
}else if(target.indexOf("gfexam") >= 0) {
	String uid = request.getParameter("uid");
	String uname = request.getParameter("uname");
	String examid = request.getParameter("examid");
	String etime = request.getParameter("etime");
	if (uid == null || uname == null || examid == null || etime == null) {
		response.sendRedirect(path);
		return;
	}
	UserToken ut = new UserToken();
	ut.setUser_id(0 - Integer.parseInt(uid));
	ut.setUser_group_id(-1);
	ut.setUsername("gfexam" + uid);
	ut.setFull_name(uname);
	ut.setSite_id(3);
	ut.setTop_group_ids(new String[]{"3"});
	SessionContext.setSpringSessionValue(Constants.USERTOKEN, ut);
	session.setAttribute(Constants.USERTOKEN, ut);
	String toUrl = path + "/exam/goExamHome.action?exam.id=" + examid;
	{
		response.sendRedirect(toUrl);
		return;
	}
}else if(target.indexOf("goSurveyAnonymous") >= 0){
	String toUrl = path + "/"+target;
	response.sendRedirect(toUrl);
	return;
}else if(target.indexOf("out_teacher_mark") >= 0){
	String toUrl = path + "/"+target;
	response.sendRedirect(toUrl);
	return;
}else{
	{response.sendRedirect(path);  return;}
/*
	Cookie cookie = null;
	if(target != null && !"".equals(target)){
		cookie = new Cookie("sso_target", target);
	}else{
		cookie = new Cookie("sso_target", "");
	}
	cookie.setMaxAge(-1);
	response.addCookie(cookie);
	UserToken utk = ConfigUtil.getUserToken(session);
	if(utk == null){
		String source = request.getParameter("source");
		String sso_service = "https://sso.sohu-inc.com";
		String sso_oa = basePath + "common/pages/sso_oa.jsp";
		if(source != null && "ps".equals(source)){
			sso_service = "https://appws.ehr.sohu-inc.com/cas";
			sso_oa = basePath + "common/pages/sso_ps.jsp";
		}
		response.sendRedirect(sso_service + "/login?service=" + sso_oa);
	}else{
		if(target != null && !"".equals(target)){
			response.sendRedirect(path + "/" + target);
		}else{
			response.sendRedirect(path + "/portal/index.action");
		}
	}
	*/
}
%>