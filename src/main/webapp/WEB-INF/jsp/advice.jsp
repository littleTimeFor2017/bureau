<%@ page import="org.springframework.util.StringUtils" %>
<%@ page import="com.lixc.bureau.entity.CategoryEntity" %>
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
            <div class="list_con">
                <div class="list_con_title">
                    <span>${entity.name}</span>
                </div>
                <div class="list_con_content">
                    <ul id="content"></ul>
                </div>
            </div>
        </div>
        <input type="hidden" id="type" value="${entity.id}"/>
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
<link rel="shortcut icon" href="<%=path %>/common/ico/favicon.ico">
<link href="<%=path%>/common/bootstrap/validator/css/bootstrapValidator.css" rel="stylesheet">
<link href="<%=path%>/common/bootstrap/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
<link href="<%=path%>/common/bootstrap/3.3.4/css/bootstrap.css" rel="stylesheet">
<link href="<%=path%>/common/css/global.css" rel="stylesheet">
<link href="<%=path%>/common/css/public.css" rel="stylesheet">
<link href="<%=path %>/common/css/details_top.css" rel="stylesheet">
<link rel="stylesheet" href="<%=path %>/common/zTree3.5/css/custom/zTreeStyle.css" type="text/css">
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
        loadData();
        changecolor();
    })
function changecolor(){
    $(document).ready(function () {
        jQuery("#li" + id).css("color", "red");
    });
}


    function goIndex(){
        window.location.href="/bureau/index";
    }


    function loadData() {
        var category_id = $("#type").val()
        var remote_url = path + '/getArticleListByTypeJSon/' + category_id + "?r=" + Math.random();
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
                        $(list).each(function (i, e) {
                            content += "<li><img src=\"img/list_con_ico.png\">";
                            content += "<a href=\"<%=path%>/articleDetail?id=" + e.id + "\">"
                            content += " <div>"+e.title+"</div>";
                            content += "</a>"
                            content += "<span>" + e.createTime + "</span>"
                            content += "</li> "
                        });
                    }
                    $('#content').html(content);
                    initB3paginator(data.obj)
                }
            }
        });
    }

    function initB3paginator(data) {
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