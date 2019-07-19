<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>您没有访问的权限</title>
	<style type="text/css">
		body{background-color:#fff}
		.kc{font-size:16px;text-decoration:none;font-family:"新宋体";color:#333}
		.ed{width:90%;max-width:800px;margin:100px auto}
		.ec{width:100%;height:207px;margin:10px 0;background-color:#69bee6;-moz-border-radius:10px;-webkit-border-radius:10px;border-radius:10px;color:#fff}
		.et{margin-left:200px;font-size:30px;font-weight:bolder;font-family:"黑体";padding-top:65px}
		.ex{margin-left:200px;font-size:12px;padding-top:10px}
		.ex a{color:#fff}
		.fr{float:right}
		.fl{float:left}
		.bt{font-family:Arial;font-size:12px;color:#666}
		.bt a{color:#666;text-decoration:none}
		.bt a:hover{color:#69bee6;text-decoration:underline}
		.ei{margin-left:10px;margin-top:50px}
	</style>
	<style type="text/css">
		*{margin:0;padding:0}
		html,body{height:100%;overflow:hidden}
		#light{width:100%;height:100%;max-width:480px;margin:0 auto;position:relative;background:url(../common/images/light-err.jpg) no-repeat 50% 50%;background-size:100%;}
		.sh{position:absolute;left:0;bottom:20px;width:100%;text-align:center;color:#333;}
		@media only screen and (max-width:660px){
			.ei{display:none;}
			.ec{height:auto;padding-bottom:20px;}
			.et{margin:0 20px;font-size:20px;padding-top:20px;}
			.ex{margin:0 20px;}
		}
		@media only screen and (max-width:400px){
			.bt{float:left;}
		}
		.sinacloud{float:right;margin-right:40px;margin-top:30px;}
		.sinacloud a{color:#fff;text-decoration:none}
		.sinacloud a:hover{color:#2942FA;text-decoration:underline}
	</style>
</head>
<body>
	<div class="ed">
		<div class="ec">
			<img src="<%=path %>/common/images/error_img.gif" class="fl ei"/>
			<div class="et">您没有访问的权限！<br /></div>
			<div class="ex">请联系管理员。</div>
			<div class="sinacloud"></div>
		</div>
	</div>
</body>
</html>
