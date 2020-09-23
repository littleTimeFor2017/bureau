<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<body>
<title>添加专栏</title>
<link rel="stylesheet" href="../../css/css/style.css"/>
<link rel="stylesheet" href="../../css/css/bootstrap.css"/>
<link rel="stylesheet" href="../../css/webuploader/bootstrap-theme.min.css">
<link rel="stylesheet" type="text/css" href="../../css/webuploader/demo.css">
<link rel="stylesheet" type="text/css" href="../../css/webuploader/webuploader.css">
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">添加</h4>
</div>
<form id="paper-add-form" action="<%=basePath %>manager/addArticle" method="post" class="form-horizontal"
      enctype="multipart/form-data">
    <div class="modal-body">
        <div class="page-container">
            <div id="uploader" class="wu-example">
                <div class="queueList">
                    <div id="dndArea" class="placeholder">
                        <div id="filePicker"></div>
                        <p>或将照片拖到这里</p>
                    </div>
                </div>
                <div class="statusBar" style="display:none">
                    <div class="progress">
                        <span class="text">0%</span>
                        <span class="percentage"></span>
                    </div>
                    <div class="btns">
                        <div class="uploadBtn">开始上传</div>
                    </div>
                </div>
            </div>
        </div>
        <%--titile--%>
        <div class="row form-group">
            <div class="col-md-2 control-label">
                <label>标题</label>
            </div>
            <div class="col-md-9 controls">
                <input type="text" class="form-control" id="Atitle" name="title" placeholder="请输入标题">
            </div>
        </div>
        <div class="row form-group">
            <div class="col-md-2 control-label">
                <label>内容</label>
            </div>
            <div class="col-md-9 controls">
                <input type="hidden" id="c_id" name="c_id" value="${c_id}">
                <input type="hidden" id="description" name="article.content" value="">
                <input type="hidden" id="paperrich" name="article.content.richtext" value=''>
                <div id="ue_content"></div>
            </div>
        </div>
        <div class="row form-group" <c:if test="${c_id ==10}">style="display: none"</c:if>>
            <div class="col-md-2 control-label">
                <label>展示图片</label>
            </div>
            <div class="col-md-9 controls">
                <input type="file" name="annex" id="annex" class="form-control">
                <input type="hidden" name="a_id" id="a_id">
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button class="btn btn-primary pull-right" type="button" id="add-paper-btn">提交</button>
        <button data-dismiss="modal" class="btn btn-link pull-right" type="button">取消</button>
    </div>
</form>
<script type="text/javascript">
    var c_id = $("#c_id").val();
    $(document).ready(function () {
        //实例化编辑器
        var random = Math.random();
        var ue_id = "myEditor" + random;
        $("#ue_content").html("<script type=\"text/plain\" id=" + ue_id + " style=\"width:100%;\"> <\/script>")
        var ue = UE.getEditor(ue_id, {
            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
            // toolbars: [['Bold', 'italic', 'underline', '|',
            // 'paragraph', 'fontfamily', 'fontsize', '|', 'forecolor',
            // 'backcolor', 'justifyleft', 'justifycenter',
            // 'justifyright', 'justifyjustify', '|',
            // 'emotion', 'insertimage']],
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
            var ids = getids('depListDiv');
            var $form = $(e.target);
            var keys = gbForm.getCheckboxValue("ck_R");
            if ($("#Atitle").val() == null || $("#Atitle").val() == '') {
                layer.msg("请输入标题", {icon: 2});
                $("#add-paper-btn").button('reset');
                return;
            } else if ($("#description").val() == null || $("#description").val() == '') {
                layer.msg("请输入内容", {icon: 2});
                $("#add-paper-btn").button('reset');
                return;
            } else {
                if (c_id != 2) {
                    ids = "-1";
                }
            } // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');
        });

        $("#add-paper-btn").on('click', function (event) {
            //提交时验证表单
            $('#paper-add-form').bootstrapValidator('validate');
        });

        loadDepData();
    })

    function uploadAnnex(ids) {
        var fd = new FormData($("#paper-add-form")[0]);
        fd.append('file', $('#annex')[0].files[0]);
        $.ajax({
            url: path + '/manager/uploadFile',
            dataType: 'json',
            async: false,
            data: fd,
            type: 'POST',
            processData: false,
            contentType: false,
            catch: false,
            success: function (data) {
                console.log(data)
                if (data && data.success) {
                    $("#a_id").val(data.result)
                    addArticle(ids);
                } else {
                    console.log("error")
                }
            },
            error: function (data) {
                console.log(data);
                layer.msg(data.msg, {icon: 2});
            }
        })
    }

    function addArticle(ids) {
        var article = {};
        article.title = $("#Atitle").val();
        article.content = $("#description").val();
        article.c_id = $("#c_id").val();
        article.a_id = $("#a_id").val();
        $.ajax({
            url: $("#paper-add-form").attr("action") + '/' + ids,
            dataType: 'json',
            async: false,
            data: JSON.stringify(article),
            type: 'POST',
            contentType: 'application/json',
            success: function (data) {
                console.log(data);
                if (data.resultCode == 200) {
                    loadData();
                    $('#dModal').modal('hide');
                    layer.msg("添加成功", {icon: 1});
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