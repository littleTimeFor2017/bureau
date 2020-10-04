<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%--bootstrap--%>
<%--<link rel="stylesheet" href="//res.layui.com/layui/dist/css/layui.css"  media="all">--%>
<link rel="stylesheet" href="<%=path %>/common/layer/3.0.3/mobile/need/layer.css"  media="all">
<link href="<%=path %>/common/bootstrap/3.3.4/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" href="<%=path %>/common/bootstrap/3.3.4/css/bootstrapSwitch.css">
<link href="<%=path%>/common/bootstrap/colorpicker/css/bootstrap-colorpicker.min.css" rel="stylesheet">
<link href="<%=path %>/common/css/global.css" rel="stylesheet">
<link href="<%=path %>/common/css/public.css" rel="stylesheet">
<link href="<%=path%>/common/bootstrap/validator/css/bootstrapValidator.css" rel="stylesheet">
<link href="<%=path%>/common/bootstrap/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<link rel="stylesheet" href="<%=path%>/common/jquery/dateRangePicker/daterangepicker.css">
<link href="<%=path %>/common/css/details_top.css" rel="stylesheet">

<script type="text/javascript" src="<%=path %>/common/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/jquery/jquery.browser.js"></script>
<!--<script type="text/javascript" src="<%=path %>/common/jquery/jquery.zclip.min.js"></script>-->
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.exedit-3.5.min.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=path %>/common/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=path %>/common/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/ueditor/lang/zh-cn/zh-cn.js"></script>

<script type="text/javascript" src="<%=path %>/common/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/validator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/validator/js/language/zh_CN.js"></script>

<script type="text/javascript" src="<%=path %>/common/bootstrap/paginator/bootstrap-paginator.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/paginator/b3paginator.js"></script>
<script type="text/javascript" src="<%=path %>/common/js/b3alert.js"></script>


<script type="text/javascript" src="<%=path %>/common/js/placeholder.js"></script>
<script type="text/javascript" src="<%=path%>/common/moment/min/moment.min.js"></script>
<script type="text/javascript" src="<%=path%>/common/js/StringUtils.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/muselect/bootstrap-select.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap-wizard/js/bwizard.min.js"></script>
<script src="<%=path %>/common/js/form_gb.js"></script>
<script src="<%=path %>/common/js/hashmap.js"></script>
<script src="<%=path %>/common/js/table.js"></script>
<script src="<%=path %>/common/js/table_map.js"></script>
<html>
<head>
    <title>管理后台</title>
</head>
<body>
<div class="container admin-container">
    <header class="navbar navbar-inverse navbar-fixed-top docs-nav" role="banner">
        <jsp:include page="manager_header.jsp"></jsp:include>
    </header>
    <div class="row">
        <div class="col-md-2" style="float: left">
            <jsp:include page="menu.jsp"></jsp:include>
        </div>
        <div class="col-md-10" role="main" id="system_date"></div>
    </div>
</div>
<div class="container admin-container">
</div>
</body>
</html>
