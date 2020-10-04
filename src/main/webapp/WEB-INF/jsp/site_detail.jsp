<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>网站专栏详情</title>
    <%@ include file="common.jsp" %>
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
        <input type="hidden" id="site_id" value="${siteId}">
        <div class="list_main">
            <div class="col-md-2" style="float: left;margin-top: 50px;margin-left: 20px;">
    <div class="list-group">
                <c:forEach items="${list}" var="obj">
                    <div style="width: 100%" name="moduleButtonDiv">
                        <input type="hidden" value="${obj.id}" name="dictId">
                        <input type="hidden" value="${obj.dictValue}" name="dictValue">
                        <a class="list-group-item"  onclick="loadData('${obj.id}','${obj.dictValue}')">${obj.dictValue}</a>
                    </div>
                </c:forEach>
            </div>
    </div>
            <div class="col-md-9">
                <div class="list_con">
                    <div class="list_con_title">
                        <span id="list_con_title"></span>
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
        <input type="hidden" id="type" value="${entity.id}"/>
        <input type="hidden" id="pageSize" value="15"/>
        <input type="hidden" id="curPage" value="1"/>
        <input type="hidden" id="totCount" value="100000"/>
        <jsp:include page="bottom.jsp"></jsp:include>
    </div>
</div>
</body>
<script type="text/javascript" src="<%=path %>/common/bootstrap/muselect/bootstrap-select.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/validator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/validator/js/language/zh_CN.js"></script>
<script src="<%=path %>/common/bootstrap/paginator/bootstrap-paginator.min.js"></script>
<script src="<%=path %>/common/bootstrap/paginator/b3paginator.js"></script>
<script type="text/javascript" src="<%=path %>/common/js/placeholder.js"></script>
<script type="text/javascript" src="<%=path %>/common/layer/3.0.3/layer.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.excheck-3.5.min.js"></script>
<script>
    var path = '<%=path%>';
    $(document).ready(function () {
        var defaultObject =document.getElementsByName("moduleButtonDiv")[0];
        let dictId = defaultObject.children[0].value;
        let dictValue = defaultObject.children[1].value;
        loadData(dictId,dictValue);
    });


    //加载文章列表数据
    function loadData(dictId, dictValue) {
        var siteId = $("#site_id").val();
        $("#list_con_title").empty().append(dictValue);
        loadListData(dictId, siteId);
    }

    function loadListData(dictId, siteId) {
        var siteQuery = {};
        siteQuery.siteId = siteId;
        siteQuery.moduleId = dictId;
        siteQuery.pageSize = $('#pageSize').val();
        siteQuery.curPage = $('#curPage').val();
        $.ajax({
                url: path + '/site/articleList?r=' + Math.random(),
                contentType: 'application/json',
                data: JSON.stringify(siteQuery),
                type: 'POST',
                dataType: 'json',
                beforeSend: function () {
                    loading = layer.load();
                },
                success: function (data) {
                    console.log(data);
                    layer.close(loading);
                    if (data && data.success) {
                        var list = data.list;
                        var content = ' <ul id="content">';
                        if (list && list.length > 0) {
                            $(list).each(function (i, e) {
                                content += "<li><img src=\"img/list_con_ico.png\">";
                                content += "<a href=\"<%=path%>/articleDetail?siteId=" + siteId + "&fromSite=true&id=" + e.id + "\">";
                                content += " <div>" + e.title + "</div>";
                                content += "</a>"
                                content += "<span>" + e.createTime + "</span>"
                                content += "</li> "
                            });
                            content += "</ul>";
                            $('#content-div').empty().append(content);
                            initB3paginator(data.obj);
                        } else {
                            content += "<ul class='media-list thread-list' style='margin:20px;'>"
                                + "<li class='title' style='text-align: center;'>暂无匹配的数据！</li>"
                                + "</ul>";
                            $("#content-div").empty().append(content)
                        }
                    }
                },
                error: function (data) {
                    layer.close(loading);
                }
            }
        )
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

    function goIndex() {
        window.location.href = "/bureau/index";
    }
</script>
</html>
