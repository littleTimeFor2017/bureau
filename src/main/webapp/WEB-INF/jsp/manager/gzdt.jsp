<%@ page import="org.springframework.util.StringUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<head>
    <title>工作动态</title>
    <link href="<%=path %>/common/bootstrap/3.3.4/css/bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=path %>/common/bootstrap/3.3.4/css/bootstrapSwitch.css">
    <link href="<%=path%>/common/bootstrap/colorpicker/css/bootstrap-colorpicker.min.css" rel="stylesheet">
    <link href="<%=path %>/common/css/global.css" rel="stylesheet">
    <link href="<%=path %>/common/css/public.css" rel="stylesheet">
    <script src="<%=path %>/common/jquery/jquery-1.11.2.min.js"></script>

    <link href="<%=path%>/common/bootstrap/validator/css/bootstrapValidator.css" rel="stylesheet">
    <link href="<%=path%>/common/bootstrap/datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=path%>/common/jquery/dateRangePicker/daterangepicker.css">
    <link href="<%=path %>/common/css/details_top.css" rel="stylesheet">
    <script src="<%=path %>/common/bootstrap/3.3.4/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=path %>/common/bootstrap/validator/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="<%=path %>/common/bootstrap/validator/js/language/zh_CN.js"></script>
    <script type="text/javascript" src="<%=path %>/common/bootstrap/paginator/bootstrap-paginator.min.js"></script>
    <script type="text/javascript" src="<%=path %>/common/bootstrap/paginator/b3paginator.js"></script>
    <script type="text/javascript" src="<%=path %>/common/bootstrap/3.3.4/js/bootstrapSwitch.js"></script>
    <script type="text/javascript" src="<%=path %>/common/js/placeholder.js"></script>
    <script src="<%=path %>/common/js/form_gb.js"></script>
    <script type="text/javascript" src="<%=path %>/common/layer/3.0.3/layer.js"></script>
    <script src="<%=path %>/common/js/global.js"></script>
    <script src="<%=path %>/common/js/form_gb.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=path %>/common/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=path %>/common/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" src="<%=path %>/common/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="<%=path %>/common/bootstrap/colorpicker/js/bootstrap-colorpicker.min.js"></script>
</head>
<body class="index">
<div class="col-md-12">
    <div id="data_header" class="page-header clearfix" style="margin: 0px 0 20px">
        <h1 class="pull-left">${categoryEntity.name}</h1>
        <input type="hidden" id="category_id" name="category_id" value="${categoryEntity.id}">
        <a href="javascript:openDialog('add','${categoryEntity.id}');" class="btn btn-info btn-sm pull-right">添加</a>
    </div>
    <div class="form-inline well well-sm">
        <div class="form-group right">
            <span>标题：</span>
            <input class="form-control" type="text" placeholder="" id="title" value="" name="sort[6]"
                   size="10">

        </div>
        <div class="form-group">
            <span>发布者：</span>
            <input class="form-control" type="text" placeholder="" id="createBy" value="" name="sort[6]"
                   size="10">

        </div>
        <span class="btn btn-primary" id='bt_gosearch' onclick="loadData()">查询</span>
    </div>
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>序号</th>
            <th>标题</th>
            <th>发布者</th>
            <th>发布时间</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="table_head">
        <tr id="content">
            <td>{{id}}</td>
            <td>{{title}}</td>
            <td>{{createBy}}</td>
            <td>{{createTime}}</td>
            <td>{{is_deleted}}</td>
        </tr>
        </tbody>
    </table>
    <div class="pagination-main">
        <ul id="pagination" class="pagination"></ul>
        <span class="page-list"></span>
    </div>
    <input type="hidden" id="pageSize" value="15"/>
    <input type="hidden" id="curPage" value="1"/>
    <input type="hidden" id="totCount" value="100000"/>
    <div id="dModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content"></div>
        </div>
    </div>
</div>

</body>

<script type="text/javascript">
    var path = '<%=path%>';
    var content_html = $('#content').prop("outerHTML");
    $(document).ready(function () {
        loadData();
        $("#dModal").on("hide.bs.modal hidden.bs.modal", function (e) {
            $(this).removeData("bs.modal");
        });
    })

    function loadData() {
        var article = {}
        article.c_id = $("#category_id").val();
        article.title = $("#title").val();
        article.createBy = $("#createBy").val();
        article.pageSize = $('#pageSize').val();
        article.curPage = $('#curPage').val();
        $.ajax({
                url: path + '/manager/gzdtListJson?r=' + Math.random(),
                contentType: 'application/json',
                data: JSON.stringify(article),
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
                        var content = '<tr>';

                        if (list && list.length > 0) {
                            $(list).each(function (i, e) {
                                var title = e.title;
                                if (e.title.length > 25) {
                                    title = e.title.substring(0, 25) + "...";
                                }
                                var html = content_html;
                                var cno = $('#pageSize').val() * ($('#curPage').val() - 1);
                                html = html.replace('{{id}}', (cno + i + 1))
                                    .replace('{{title}}', title)
                                    .replace('{{createBy}}', e.createBy)
                                    .replace('{{createTime}}', e.createTime)
                                    .replace('{{is_deleted}}', '<a href="javascript:openDialog(\'edit\',' + e.id + ');" class="btn btn-info btn-sm pull-left">修改</a> <a href="javascript:openDialog(\'del\',' + e.id + ');" class="btn btn-info btn-sm pull-right">删除</a>')
                                content += html;
                            })
                        } else {
                            content = '<tr class="warning text-center"><td colspan="9"> 没有找到匹配的记录</td></tr>'
                        }
                        $('#table_head').html(content);
                        $('#table_head').show();
                        initB3paginator(data.obj)
                    }
                },
                error: function (data) {
                    layer.close(loading);
                }
            }
        )
    }

    function openDialog(type, ctId) {
        var remote_url = "";
        if (type == "add") {
            remote_url = path + "/manager/addArticleForward?c_id=" + ctId + "&r=" + Math.random();
            $("#dModal").modal({backdrop: 'static', keyboard: false, show: true, remote: remote_url});
        }
        if (type == "edit") {
            remote_url = path + "/manager/editArticleForward?id=" + ctId + "&r=" + Math.random();
            $("#dModal").modal({backdrop: 'static', keyboard: false, show: true, remote: remote_url});
        }
        if (type == "del") {
            layer.confirm("是否删除此数据？", {icon: 3, title: '温馨提示'}, function (index) {
                remote_url = path + "/manager/delArticle?id=" + ctId + "&r=" + Math.random();
                $.ajax({
                    url: remote_url,
                    dataType: 'json',
                    type: 'POST',
                    beforeSend: function () {
                        loading = layer.load();
                    },
                    success: function (data) {
                        console.log(data)
                        layer.close(loading);
                        if (data && data.success) {
                            loadData();
                            layer.msg(data.message, {icon: 1});
                        } else {
                            layer.msg(data.message, {icon: 2});
                        }
                    }
                })

            });
        }
    }

    function initB3paginator(data) {
        $("#pageSize").val(data['pageSize']);
        $("#curPage").val(data['curPage']);
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
            totcount: data['totCount']
        });
    }
</script>
</html>
