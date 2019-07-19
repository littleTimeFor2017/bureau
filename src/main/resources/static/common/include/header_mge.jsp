<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cn.kindee.common.core.utils.StringUtilsExt,
				 cn.kindee.moudle.ucenter.authentication.utils.PrivilegeCheckUtils,
				 cn.kindee.common.core.utils.ConfigUtil,
				 cn.kindee.common.core.utils.CookieUtil,
				 cn.kindee.common.core.support.PrivilegeConstants,
				 cn.kindee.common.core.support.UserToken,
				 cn.kindee.common.core.support.Constants" %>
<%
String path = request.getContextPath();
String host = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
UserToken userToken = ConfigUtil.getUserToken(session);
String target = request.getParameter("target");
target = StringUtilsExt.isNullToEmpty(target);
PrivilegeCheckUtils pChkUtils = new PrivilegeCheckUtils();
String dflogo = path + "/common/images/logo.png";

String logoPath = ConfigUtil.getUploadLogoPath(userToken.getSite_id(), "A");
String logo = ConfigUtil.getUserSiteInfo(request, Constants.LOGO);
if(logo != null && !logo.equals("")){
	logo = "//"+request.getServerName()+":"+request.getServerPort()+"/" + logoPath + logo;
}
String h5 = CookieUtil.getCookieValue(request, Constants.CUR_PAGE);
h5 = null == h5?"":h5;

String idxUrl = path + "/portal/index.action";
if(h5.equals("h5")){
	idxUrl = path + "/portal/indexh5.action";
}
String ahd_cl = ConfigUtil.getUserSiteInfo(request, Constants.AHDCL);
String ahd_bg = "", n_cl = "";
ahd_bg = ahd_cl == null || ahd_cl.equals("") ? "" : "style='background:"+ahd_cl+"'";
n_cl = ahd_cl == null || ahd_cl.equals("") ? "" : "style='color:#FFF'";
%>
<style type="text/css">
	.navbar-inverse {background: <%=ahd_cl %>; background-color: <%=ahd_cl %>}
	.navbar-inverse .navbar-nav > .open > a,
	.navbar-inverse .navbar-nav > .open > a:hover,
	.navbar-nav > li {margin-left: 2px;}
</style>
<div class="container">
   <div class="navbar-header">
     	<button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".bs-navba r-collapse">
       	<span class="sr-only">Toggle navigation</span>
       	<span class="icon-bar"></span>
       	<span class="icon-bar"></span>
       	<span class="icon-bar"></span>
     	</button>
     	<a href="javascript:;" class="navbar-brand" alt="Less">
       	<img src="<%=logo %>" onerror="this.src='<%=dflogo %>'">
     	</a>
   	</div>
 	<nav class="collapse navbar-collapse bs-navbar-collapse" role="navigation">
    	<ul class="nav navbar-nav" style="min-width: 750px">
    		<%=pChkUtils.initMenu("", path, target, "M") %>
    	</ul>
    	<ul class="nav navbar-nav navbar-right">
      		<li class="dropdown">
        		<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-user"></i> <%=userToken.getFull_name() %> <b class="caret"></b></a>
	          	<ul class="dropdown-menu">
	            	<li><a href="<%=idxUrl %>"><i class="glyphicon glyphicon-home"></i> 回首页</a></li>
<%--	            	<li class="divider"></li>
	            	<% if(userToken.getUsername().equals("admin")){ %>
	            	<li><a href="<%=path %>/system/goSetting.action"><i class="glyphicon glyphicon-cog"></i> 系统配置</a></li>
	            	<li class="divider"></li>
	            	<% } %>
--%>
	            	<li><a href="<%=path %>/util/exit.jsp"><i class="glyphicon glyphicon-off"></i> 退出</a></li>
	          	</ul>
      		</li>
    	</ul>
  	</nav>
</div>
<script type="text/javascript">
window.onload = function (){
	$('li.dropdown').mouseover(function(){
	$(this).addClass('open');}).mouseout(function(){$(this).removeClass('open');});
};
</script>