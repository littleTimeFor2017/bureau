<%@ page import="org.springframework.util.StringUtils" %>
<%@ page import="com.lixc.bureau.entity.CategoryEntity" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    Object obj = request.getAttribute("entity");
    CategoryEntity categoryEntit = new CategoryEntity();
    if (!StringUtils.isEmpty(obj)) {
        categoryEntit = (CategoryEntity) obj;
    }
    int id = categoryEntit.getId() + 1;
%>
<html lang="zh-CN">
<style type="text/css">
</style>
<head>
    <link rel="shortcut icon" href="<%=path %>/common/ico/favicon.ico">
    <link href="<%=path%>/common/bootstrap/validator/css/bootstrapValidator.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=path%>/common/jquery/dateRangePicker/daterangepicker.css">
    <link href="<%=path%>/common/bootstrap/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="<%=path%>/common/bootstrap/3.3.4/css/bootstrap.css" rel="stylesheet">
    <link href="<%=path%>/common/css/global.css" rel="stylesheet">
    <link href="<%=path%>/common/css/public.css" rel="stylesheet">
    <link href="<%=path %>/common/css/details_top.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=path %>/common/zTree3.5/css/custom/zTreeStyle.css" type="text/css">
    <meta charset="utf-8">
    <title>${entity.name}</title>
</head>

<body>
<!-- main 开始 -->
<div class="main">
    <div class="main_box">
        <jsp:include page="header.jsp"></jsp:include>
        <div class="address">
            <img src="/img/address_ico.png"/><a href="javascript:goIndex();">首页</a>
            <%--<a>：</a><a href="javascript:void(0);">警务快讯</a><a>&gt;</a><a--%>
            <%--href="javascript:void(0);">警务快讯</a><a>&gt;</a><a href="javascript:void(0);">局内要闻</a>--%>
        </div>
        <!-- address 结束 -->

        <!-- list_main 开始 -->
        <div class="list_main">
            <%--            增加左侧菜单显示--%>
            <div class="col-md-2" style="float: left;margin-top: 50px;margin-left: 20px;">
                <div class="list-group">
                    <c:forEach items="${list}" var="obj">
                        <div style="width: 100%" name="moduleButtonDiv">
                            <input type="hidden" value="${obj.id}" name="dictId">
                            <input type="hidden" value="${obj.name}" name="dictValue">
                            <a class="list-group-item" onclick="loadData('${obj.id}','${obj.name}')">${obj.name}</a>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="col_md-9">
                <%--            右侧内容--%>
                <div class="list_con">
                    <div class="list_con_title">
                        <span id="contentName"></span>
                    </div>
                    <div class="list_con_content" id="content-div">
                    </div>
                </div>
            </div>
        </div>
        <div class="pagination-main" style="margin-left: 300px;">
            <ul id="pagination" class="pagination"></ul>
            <span class="page-list"></span>
        </div>
        <%--        <input type="hidden" id="type" value="${entity.id}"/>--%>
        <input type="hidden" id="pageSize" value="15"/>
        <input type="hidden" id="curPage" value="1"/>
        <input type="hidden" id="totCount" value="100000"/>
        <div id="dModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content"></div>
            </div>
        </div>
        <jsp:include page="bottom.jsp"></jsp:include>
    </div>
</div>
</body>
<%--<script src="<%=path %>/common/jquery/jquery-1.11.2.min.js"></script>--%>
<script type="text/javascript" src="<%=path %>/common/bootstrap/muselect/bootstrap-select.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/validator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/validator/js/language/zh_CN.js"></script>
<script src="<%=path %>/common/bootstrap/paginator/bootstrap-paginator.min.js"></script>
<script src="<%=path %>/common/bootstrap/paginator/b3paginator.js"></script>
<script type="text/javascript" src="<%=path %>/common/js/placeholder.js"></script>
<script type="text/javascript" src="<%=path %>/common/layer/3.0.3/layer.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript">
    var path = '<%=path%>';
    var id = '<%=id%>'
    $(document).ready(function () {
        var defaultObject = document.getElementsByName("moduleButtonDiv")[0];
        var dictId = defaultObject.children[0].value;
        var dictValue = defaultObject.children[1].value;
        loadData(dictId, dictValue);
        changecolor();
    })

    function changecolor() {
        $(document).ready(function () {
            jQuery("#li" + id).css("color", "red");
        });
    }


    function goIndex() {
        window.location.href = "/bureau/index";
    }


    function loadData(id, name) {
        $("#contentName").empty().append(name);
        var remote_url = path + '/getArticleListByTypeJSon/' + id + "?r=" + Math.random();
        var article = {};
        article.pageSize = $('#pageSize').val();
        article.curPage = $('#curPage').val();
        $.ajax({
            url: remote_url,
            data: JSON.stringify(article),
            dataType: "json",
            type: "POST",
            async: true,
            contentType: 'application/json;charset=UTF-8',
            beforeSend: function () {
                loading = layer.load();
            },
            success: function (data) {
                layer.close(loading);
                if (data && data.success) {
                    var list = data.list;
                    var content = '';
                    if (list && list.length > 0) {
                        content += "     <ul id=\"content\">";
                        $(list).each(function (i, e) {
                            content += "<li><img src=\"img/list_con_ico.png\">";
                            content += "<a href=\"<%=path%>/articleDetail?id=" + e.id + "\">"
                            content += " <div>" + e.title + "</div>";
                            content += "</a>"
                            content += "<span>" + e.createTime + "</span>";
                            content += "</li> "
                        });
                        content+="</ul>";
                        $('#content-div').empty().append(content);
                        initB3paginator(data.obj)
                    } else {
                        content += "<ul class='media-list thread-list' style='margin:20px;'>"
                            + "<li class='title' style='text-align: center;'>暂无匹配的数据！</li>"
                            + "</ul>";
                        $("#content-div").empty().append(content);
                    }
                }
            }
        });
    }

    function initB3paginator(data) {
        console.log(data)
        $("#pageSize").val(data['pageSize']);
        $("#curPage").val(data['curPage']);
        $("#totCount").val(data['totCount']);
        //基本分页
        b3Paginator('pagination', 5, data['curPage'], data['pageSize'], data['totPage'],
            function (event, originalEvent, type, page) {
                var goPage = 1;
                if (type == "first") goPage = 1;
                else if (type == "prev") goPage = parseInt(data['curPage']) - 1;
                else if (type == "next") goPage = parseInt(data['curPage']) + 1;
                else if (type == "last") goPage = data['totPage'];
                else if (type == "page") goPage = page;

                $("#curPage").val(goPage);
                //页面跳转方法自行定义
                loadData();
            },
            function (type, page, current) {
                return null;
            }
        );
        //初始化每页显示条数
        $(".page-list").b3paginatorext({
            onPageSizeChange: function () {
                loadData();
            },
            pagesizeinput: "#pageSize",
            pagesize: data['pageSize'],
            totcount: data['totCount'],
        });
        //移动到数据位置
        //$("html,body").animate({scrollTop:0},1);
    }
</script>

</html>