<%@ page language="java" contentType="text/html; charset=UTF-8" 
	import="cn.kindee.moudle.ucenter.authentication.utils.ValidateUtil,
			cn.kindee.common.core.json.Json,
			cn.kindee.moudle.ucenter.user.entity.User,
			cn.kindee.common.core.utils.StringUtilsExt,
			cn.kindee.common.core.utils.ConfigUtil,
			cn.kindee.common.core.support.Constants,
			cn.kindee.common.core.utils.CookieUtil"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String domain = StringUtilsExt.isNullToEmpty(request.getServerName());
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String idxUrl = path + "/portal/index.action";
String target = CookieUtil.getCookieValue(request,"sso_target");
if(target != null && !"".equals(target)){
	idxUrl = path + "/" + target;
}
if(session.getAttribute(Constants.USERTOKEN) == null){
	String sso_ps = basePath + "common/pages/sso_ps.jsp";
	String sso_service = "https://appws.ehr.sohu-inc.com/cas";
	String ticket = request.getParameter("ticket");
	if(ticket == null || "".equals(ticket)){
		//response.sendRedirect(sso_service + "/login?service=" + sso_oa);
		out.println("缺少登录凭证！");
	}else{
		ValidateUtil vu = new ValidateUtil();
		boolean flag = vu.checkTicketLogin(request, sso_service, ticket, sso_ps);
		if(flag){ 
			session.removeAttribute(Constants.USERSSO);
			session.setAttribute(Constants.USERSSO, "ps");
			response.sendRedirect(idxUrl);
	 	}else{
			out.println("用户身份验证失败 ！");
		}
	}
}else{ 
	response.sendRedirect(idxUrl);
} %>
