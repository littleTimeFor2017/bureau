<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<body>
<title>网站专栏-修改文章</title>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">修改</h4>
</div>
<form id="paper-add-form" action="<%=basePath %>manager/addArticle" method="post" class="form-horizontal"
      enctype="multipart/form-data">
    <div class="modal-body">
        <div class="row form-group">
            <div class="col-md-2 control-label">
                <label>标题</label>
            </div>
            <div class="col-md-9 controls">
                <input type="text" class="form-control" id="Atitle" value="${articleById.title}" name="title"
                       placeholder="请输入标题">
            </div>
        </div>
        <div class="row form-group">
            <div class="col-md-2 control-label">
                <label>内容</label>
            </div>
            <div class="col-md-9 controls">
                <input type="hidden" id="siteId" name="siteId" value="${siteId}">
                <input type="hidden" id="articleId" name="articleId" value="${articleById.id}">
                <input type="hidden" id="description" name="article.content" value="">
                <input type="hidden" id="paperrich" name="article.content.richtext" value="${articleById.content}">
                <div id="ue_content_e"></div>
            </div>
        </div>
        <div class="row form-group">
            <div class="col-md-2 control-label">
                <label>是否展示</label>
            </div>
            <div class="col-md-9 controls">
                <div class="radio-inline">
                    <label style="margin-left:20px;"> <input type="radio" name="unit" value="Y" checked="checked"/>是
                    </label>
                    <label style="margin-left:20px;"> <input type="radio" name="unit" value="N"/>否 </label>
                </div>
            </div>
        </div>
        <div class="row form-group">
            <div class="col-md-2 control-label">
                <label>所属模块</label>
            </div>
            <div class="col-md-9 controls">
                <div class="radio-inline" id="modules">
                    <%--                    <c:forEach items="${list}" var="obj" varStatus="status">--%>
                    <%--                        <label style="margin-left:20px;"> <input type="radio" name="module"--%>
                    <%--                                                                 <c:if test="${obj.id==siteArticle.moduleId}">checked="checked"</c:if>--%>
                    <%--                                                                 value="${obj.id}"/>${obj.dictValue} </label>--%>
                    <%--                        </label>--%>
                    <%--                    </c:forEach>--%>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button class="btn btn-primary pull-right" type="button" id="add-paper-btn">提交</button>
        <button data-dismiss="modal" class="btn btn-link pull-right" type="button">取消</button>
    </div>
</form>
<script type="text/javascript">
    var path = '<%=path%>'
    $(document).ready(function () {
        var content = $("#paperrich").val();
        //实例化编辑器
        var random = Math.random();
        var ue_id = "myEditor" + random;
        var content1 = "<script type=\"text/plain\"  id=" + ue_id + " style=\"width:100%;\">" + content + "<\/script>"
        $("#ue_content_e").html(content1);
        var ue = UE.getEditor(ue_id, {
            toolbars: [['undo', 'redo', '|',
                'Bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat',
                'formatmatch', '|',
                'paragraph', 'fontfamily', 'fontsize', '|', 'forecolor',
                'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', 'justifyleft',
                'justifycenter',
                'justifyright', 'justifyjustify', '|', 'emotion', 'insertimage', 'insertcode', 'pagebreak', 'template', '|',
                'link', 'unlink'
                , 'test']],
            //focus时自动清空初始化时的内容
            autoClearinitialContent: true,
            //关闭字数统计
            wordCount: false,
            //关闭elementPath
            elementPathEnabled: false,
            //默认的编辑区域高度
            initialFrameHeight: 150,
            imagePath: "",
            filePath: "",
            imageManagerPath: "",
            serverurl: ""
            //更多其他参数，请参考ueditor.config.js中的配置项
        });
        $('#paper-add-form').bootstrapValidator({}).on('success.form.bv', function (e) {
            var description = ue.getContent();
            $("#description").val(description);
            e.preventDefault();
            var $form = $(e.target);
            if ($("#Atitle").val() == null || $("#Atitle").val() == '') {
                layer.msg("请输入标题", {icon: 2});
                $("#add-paper-btn").button('reset');
                return;
            } else if ($("#description").val() == null || $("#description").val() == '') {
                layer.msg("请输入内容", {icon: 2});
                $("#add-paper-btn").button('reset');
                return;
            } else if ($("input[type=radio]:checked").length == 0) {
                layer.msg("请选择所属模块", {icon: 2});
                $("#add-paper-btn").button('reset');
                return;
            } // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');
            editArticleOnly()
        });

        $("#add-paper-btn").on('click', function (event) {
            //提交时验证表单
            $('#paper-add-form').bootstrapValidator('validate');
        });
        loadModuleData();
    });

    function loadModuleData() {
        $.ajax({
                url: path + "/site/getModulesJson?id="+$("#articleId").val()+"&siteId="+ $("#siteId").val()+"&r="+Math.random(),
                dataType: 'json',
                async: false,
                type: 'POST',
                contentType: 'application/json',
                success: function (data) {
                    console.log(data);
                    if (data.success) {
                        var list = data.list;
                        var obj = data.siteArticle;
                        var content = '';
                        if (list.length > 0) {
                            for (var i = 0; i < list.length; i++) {
                                if (list[i].id == obj.moduleId) {
                                    content += '<label style="margin-left:20px;"> <input type="radio" name="module"  checked="checked" value = "' + list[i].id + '" /> ' + list[i].dictValue+ '</label>'
                                } else {
                                    content += '<label style="margin-left:20px;"> <input type="radio" name="module"  value = "' + list[i].id + '" /> ' + list[i].dictValue + '</label>'
                                }

                            }
                        }
                        $("#modules").append(content);
                    } else {
                        layer.msg(data.msg, {icon: 2});
                    }
                },
                error: function (data) {
                    console.log(data);
                    layer.msg(data.msg, {icon: 2});
                }
            }
        )
    }


    function editArticleOnly() {
        var moduleId = $("input[name=module ]:checked").val();
        var siteQuery = {};
        siteQuery.title = $("#Atitle").val();
        siteQuery.content = $("#description").val();
        siteQuery.siteId = $("#siteId").val();
        siteQuery.articleId = $("#articleId").val();
        siteQuery.moduleId = moduleId;
        $.ajax({
                url: path + "/site/editArticle",
            dataType: 'json',
            async: false,
            data: JSON.stringify(siteQuery),
            type: 'POST',
            contentType: 'application/json',
            success: function (data) {
                console.log(data);
                if (data.resultCode == 200) {
                    loadData();
                    $('#dModal').modal('hide');
                    layer.msg("修改成功", {icon: 1});
                } else {
                    layer.msg(data.msg, {icon: 2});
                }
            },
            error: function (data) {
                console.log(data);
                layer.msg(data.msg, {icon: 2});
            }
        })
    }

</script>
</body>