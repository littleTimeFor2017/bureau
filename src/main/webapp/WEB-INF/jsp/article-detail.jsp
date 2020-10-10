<%@ page import="com.lixc.bureau.entity.Article" %>
<%@ page import="com.lixc.bureau.constants.BureauConstants" %>
<%@ page import="org.springframework.util.StringUtils" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String is_login = "N";
    Object attribute = request.getSession().getAttribute(BureauConstants.USER_TOKEN);
    if (!StringUtils.isEmpty(attribute)) {
        is_login = "Y";
    }
%>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <link rel="shortcut icon" href="<%=path %>/common/ico/favicon.ico">
    <link href="<%=path%>/common/bootstrap/validator/css/bootstrapValidator.css" rel="stylesheet">
    <link href="<%=path%>/common/bootstrap/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="<%=path%>/common/bootstrap/3.3.4/css/bootstrap.css" rel="stylesheet">
    <link href="<%=path%>/common/css/global.css" rel="stylesheet">
    <link href="<%=path%>/common/css/public.css" rel="stylesheet">
    <link href="<%=path %>/common/css/details_top.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=path %>/common/zTree3.5/css/custom/zTreeStyle.css" type="text/css">
    <script src="<%=path %>/common/jquery/jquery-1.11.2.min.js"></script>

    <script src="<%=path %>/common/js/html5shiv.js"></script>
    <script src="<%=path %>/common/js/respond.min.js"></script>

</head>

<body>

<div class="main">
    <div class="main_box" style="position: relative;z-index: 1;">
        <jsp:include page="header.jsp"></jsp:include>
        <div class="search_wx">
        </div>
        <div style="width: auto;height: 10px;"></div>
        <div style="margin-left: 40px; margin-right: 40px;">
            <% Article article = (Article) request.getAttribute("entity"); %>
            <span id="article_content"><%=article.getContent()%></span>
            <input type="hidden" name="Aid" id="Aid" value="<%=article.getId()%>"/>

            <% if (article.getAnnex() != null) { %>
            <span>附件</span>
            <div style="margin-top: 20px;margin-bottom: 20px;">
                <span><%=article.getAnnex().getFileName()%></span>
                <a class="btn btn-default" href="/bureau/manager/download?id=<%=article.getAnnex().getId()%>">下载</a>
            </div>
            <%}%>
            <%--<a href="javascript:downloadFile('<%=article.getAnnex().getId()%>')"><%=article.getAnnex().getFileName()%></a>--%>
            <%--<a href="file://<%=article.getAnnex().getId()%>"><%=article.getAnnex().getFileName()%></a>--%>
        </div>
        <div style="margin-top: 30px;" align="center">
            <c:if test="${type=='S'}">
                <input class="btn btn-primary well-p" type="button" name="sign" style="margin-left: 30px;"
                       onclick="myshow()" value="签收">
                <% if ((Boolean) request.getAttribute("is_super") == true) { %>
                <a class="btn btn-primary well-p" type="button" name="signAl" style="margin-left: 30px;"
                   onclick="sign(-1,'all')" value="全部签收">全部签收</a>
                <% } %>
            </c:if>
            <input class="btn btn-warning well-p" type="button" name="goBack" style="margin-left: 30px;"
                   onclick="goBack('index','${fromSite}','${siteId}')" value="返回"></input>
        </div>
        <form id="form" action="/bureau/sign" method="post">
            <div id="showDiv" style="display: none">
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th data-field="id">序号</th>
                        <th data-field="name">部门名称</th>
                        <th data-field="status">操作</th>
                    </tr>
                    </thead>
                    <tbody id="table_head">
                    <tr id="content">
                        <td>{{id}}</td>
                        <td>{{name}}</td>
                        <td>{{status}}</td>
                    </tr>
                    </tbody>
                </table>
                <div class="pagination-main">
                    <ul id="pagination" class="pagination"></ul>
                    <span class="page-list"></span>
                </div>
            </div>
        </form>
    </div>
    <!-- main 结束 -->
    <input type="hidden" id="pageSize" value="15"/>
    <input type="hidden" id="curPage" value="1"/>
    <input type="hidden" id="totCount" value="100000"/>
    <div id="dModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>
</div>
<script type="text/javascript" src="<%=path %>/common/bootstrap/muselect/bootstrap-select.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/validator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/bootstrap/validator/js/language/zh_CN.js"></script>
<script src="<%=path %>/common/bootstrap/paginator/bootstrap-paginator.min.js"></script>
<script src="<%=path %>/common/bootstrap/paginator/b3paginator.js"></script>
<script type="text/javascript" src="<%=path %>/common/js/placeholder.js"></script>
<script type="text/javascript" src="<%=path %>/common/layer/3.0.3/layer.js"></script>
<script type="text/javascript" src="<%=path %>/ucenter/usergroup/js/usergroup-tree.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="<%=path %>/common/zTree3.5/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript">
    var idx;
    var path = '<%=path%>';
    var is_login = '<%=is_login%>';
    var flag = false;
    var content_html = $('#content').prop("outerHTML");
    jQuery(document).ready(function () {
        loadData();
        $("#dModal").on("hide.bs.modal hidden.bs.modal", function (e) {
            $(this).removeData("bs.modal");
        });
    });

    function myshow() {
        $("#showDiv").show();
    }

    function sign(dep_id, type) {
        // 将id发送到后台
        var url = $("#form").attr("action");
        var article_id = $("#Aid").val();
        $.ajax({
            url: url,
            data: {
                "dep_id": dep_id,
                "article_id": article_id,
                "type": type
            },
            type: "POST",
            async: true,
            beforeSend: function () {
                loading = layer.load();
            },
            success: function (data) {
                layer.close(loading);
                console.log(flag)
                console.log(is_login == "N")
                if (data && data.success) {
                    layer.msg(data.message, {icon: 1});
                    loadData()
                    $("#showDiv").show()
                } else {
                    if (is_login == "N") {
                        if (!flag) {
                            openModel();
                        } else {
                            layer.msg(data.message, {icon: 2});
                        }
                    } else {
                        layer.msg(data.message, {icon: 2});
                    }
                }
            },
            error: function () {
                layer.close(loading);
                layer.msg("签收异常，请稍后重试", {icon: 2});
            }
        })
    }


    function downloadFile(id) {
        // downloadFileDe(path+'/manager/downLoadFile','id',id)
        downloadFileAjax(id);
    }

    function downloadFileDe(action, type, value) {
        var form = document.createElement('form');
        document.body.appendChild(form);
        form.style.display = "none";
        form.action = action;
        form.id = 'excel';
        form.method = 'post';

        var newElement = document.createElement("input");
        newElement.setAttribute("type", "hidden");
        newElement.name = type;
        newElement.value = value;
        form.appendChild(newElement);
        form.submit();
    }

    function downloadFileAjax(id) {
        $.ajax({
            url: path + '/manager/download',
            data: {
                "id": id
            },
            dataType: 'json',
            type: "POST",
            async: true,
            success: function (data) {
                console.log(data);
            },
            error: function () {
                console.log("error")
            }
        })
    }

    function openModel() {
        var article_id = $("#Aid").val();
        var remote_url = path + "/signForward?article_id=" + article_id + "&r=" + Math.random();
        $("#dModal").modal({backdrop: 'static', keyboard: false, show: true, remote: remote_url});
    }

    function setVal(value) {
        flag = value;
    }

    function loadData() {
        var article_id = $("#Aid").val()
        var remote_url = path + '/getLoadData/' + article_id + "?r=" + Math.random();
        var department = {};
        department.pageSize = $('#pageSize').val();
        department.curPage = $('#curPage').val();
        $.ajax({
            url: remote_url,
            data: JSON.stringify(department),
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
                            var html = content_html;
                            var cno = $('#pageSize').val() * ($('#curPage').val() - 1);
                            var cvalue = '';
                            if (e.status == 0) {
                                cvalue += "<button type=\"button\" class=\"btn btn-default\"  onclick=\"sign(this.value,'one')\"   value=\"" + e.id + "\">"
                                cvalue += " 签 收</button> "
                            } else {
                                cvalue += "<button type=\"button\"  class=\"btn btn-success disabled\">";
                                cvalue += "已经签收</button> "
                            }
                            html = html.replace('{{id}}', (cno + i + 1))
                                .replace('{{name}}', e.name)
                                .replace('{{status}}', cvalue)
                            content += html;
                        });
                    } else {
                        content = '<tr class="warning text-center"><td colspan="9"> 没有找到匹配的记录</td></tr>'
                    }
                } else {
                    layer.msg(data.msg, {icon: 2});
                }
                $('#table_head').html(content);
                $('#table_head').show();
                initB3paginator(data.obj)
            },
            error: function (data) {
                layer.close(loading);
                console.log(data)
            }
        })
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

    function goBack(type, fromSite, siteId) {
        var url = "";
        if (!fromSite) {
            url = path + "/index?r=" + Math.random();
        } else {
            url = path + "/other?type=zgdj";
        }
        window.location.href = url;
    }
</script>
</body>
</html>