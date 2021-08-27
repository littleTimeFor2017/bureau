<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.springframework.util.StringUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">修改</h4>
</div>
<form id="paper-edit-form" action="<%=basePath %>manager/editArticle" method="post" class="form-horizontal">
    <div class="modal-body">
        <%--titile--%>
        <div class="row form-group">
            <div class="col-md-2 control-label">
                <label>标题</label>
            </div>
            <div class="col-md-9 controls">
                <input type="text" class="form-control" id="title_e" name="title" value="${article.title}">
            </div>
        </div>
        <div class="row form-group">
            <div class="col-md-2 control-label">
                <label>内容</label>
            </div>
            <div class="col-md-9 controls">
                <input type="hidden" id="id_e" name="id" value="${article.id}">
                <input type="hidden" id="c_id_e" name="c_id_e" value="${article.c_id }">
                <input type="hidden" id="description_e" name="article.content" value="">
                <input type="hidden" id="paperrich_e" name="article.content.richtext" value='${article.content}'><%--//TODO 需要展示富文本内容--%>
                <div id="ue_content_e"></div>
            </div>
        </div>
        <div class="row form-group" <c:if test="${article.c_id !=2  }">style="display: none"</c:if>>
            <div class="col-md-2 control-label">
                <label>选择部门</label>
            </div>
            <div class="col-md-9 controls" id="dep_content_e">

            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button class="btn btn-primary pull-right" type="button" id="edit-paper-btn">提交</button>
        <button data-dismiss="modal" class="btn btn-link pull-right" type="button">取消</button>
    </div>
</form>
<script type="text/javascript">
    $(document).ready(function () {
        //实例化编辑器kx`
        var c_id_e = $("#c_id_e").val();
        var random = Math.random();
        var ue_id = "myEditor" + random;
        var content = $("#paperrich_e").val();
        <%--var ue_content = '<script type="text/plain" id=' + ue_id--%>        <%--ue +='style="width:100%;">'--%>
        <%--ue+= ${article.content};--%>
        <%--ue+='<\/script>'--%>
        var content1="<script type=\"text/plain\"  id="+ue_id+" style=\"width:100%;\">"+content+"<\/script>"
        <%--$("#ue_content_e").html('<script type="text/plain" id=' + ue_id + ' style="width:100%;">'+${article.content}+' <\/script>')--%>
        $("#ue_content_e").html(content);
        var ue = UE.getEditor(ue_id, {
            //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
            toolbars: [['Bold', 'italic', 'underline', '|',
                'paragraph', 'fontfamily', 'fontsize', '|', 'forecolor',
                'backcolor', 'justifyleft', 'justifycenter',
                'justifyright', 'justifyjustify', '|',
                'emotion', 'insertimage']],
            //focus时自动清空初始化时的内容
            autoClearinitialContent: false,
            //关闭字数统计
            wordCount: false,
            //关闭elementPath
            elementPathEnabled: false,
            //默认的编辑区域高度
            initialFrameHeight: 150,
            imagePath: "",
            filePath: "",
            imageManagerPath: ""
            //更多其他参数，请参考ueditor.config.js中的配置项
        });
        $('#paper-edit-form').bootstrapValidator({}).on('success.form.bv', function (e) {
            var description = ue.getContent();
            $("#description_e").val(description);
            e.preventDefault();
            var $form = $(e.target);
            var keys = gbForm.getCheckboxValue("ck_R_e");
            var ids = getids('depListDiv_e');
            if ($("#title_e").val() == null || $("#title_e").val() == '') {
                layer.msg("请输入标题", {icon: 2});
                $("#edit-paper-btn").button('reset');
                return;
            } else if ($("#description_e").val() == null || $("#description_e").val() == '') {
                layer.msg("请输入内容", {icon: 2});
                $("#edit-paper-btn").button('reset');
                return;
            } else if (c_id_e == 2) {
                if (keys == null || keys == "") {
                    layer.msg("部门至少要选择一个，请选择！", {icon: 2});
                    $("#edit-paper-btn").button('reset');
                    return;
                }
            } else {
                if (c_id_e != 2) {
                    ids = "-1";
                }
            }
            var bv = $form.data('bootstrapValidator');
            var article = {};
            article.title = $("#title_e").val();
            article.content = $("#description_e").val();
            article.id = $("#id_e").val();
            $.ajax({
                url: $("#paper-edit-form").attr('action') + '/' + ids,
                dataType: 'json',
                data: JSON.stringify(article),
                type: 'POST',
                contentType: 'application/json',
                success: function (data) {
                    console.log(data)
                    if(data.resultCode == 200){
                        loadData();
                        $('#dModal').modal('hide');
                        layer.msg('修改成功', {icon: 1});
                    }else{
                        layer.msg(data.msg, {icon: 2});
                    }
                },
                error: function (data) {
                    console.log(data);
                    layer.msg(data.msg, {icon: 2});
                }
            })
        });

        $("#edit-paper-btn").on('click', function (event) {
            //提交时验证表单
            $('#edit-paper-btn').bootstrapValidator('validate');
        });
        loadDepData();
    })

    function loadDepData() {
        $.ajax({
            url: path + '/dep/getAllDepsWithStatus?article_id=' + $("#id_e").val(),
            dataType: 'json',
            type: "POST",
            async: true,
            contentType: 'application/json;charset=UTF-8',
            beforeSend: function () {
                loading = layer.load();
            },
            success: function (data) {
                layer.close(loading);
                var ckcount4 = 0;
                var content = "<div class=\"panel-body\">"
                if (data && data.success) {
                    var list = data.list;
                    if (list && list.length > 0) {
                        content += '<div class="panel-heading col-head"> ' +
                            '<input  class="form-control pull-left"   style="height: 25px;width: 25px;margin: 0;" type="checkbox" name="ck_C" id="checkAll_e" onclick="checkDepAll()">' +
                            '<label class="collapse-a" data-toggle="collapse" data-parent="#accordion" href="#collapse_SLS">全选</label>' +
                            '</div>' +
                            '<div name="depListDiv_e">'
                        $(list).each(function (i, e) {
                            var ck = '';
                            if (e.checked == "Y") {
                                ck = 'checked';
                            }
                            ckcount4++;
                            content += '<div class="btn btn-default" style="border:0px;margin:0px;"> <span class="btn btn-default" style="margin: 5px;padding:5px;"><input type="text"  readonly="true" id="' + e.id + '_nm" value="' + e.name + '" style="width: 60px;margin-bottom: 2px;border-radius: 5px;padding:2px;border:1px solid #999;"><br/>' +
                                '<input ' + ck + ' class="form-control pull-left" style="height: 25px;width: 25px;margin: 0;" type="checkbox" name="ck_R_e" value="' + e.id + '" onclick="checkOne(this)">' +
                                '<input maxlength="2" class="form-control" style="height: 25px;width: 25px" type="text" id="' + e.id + '_od" name="' + e.name + '_od" value="' + ckcount4 + '"  >' +
                                '</span></div>';
                        })
                    }
                }
                content += '</div>';
                content += '</div>';
                $("#dep_content_e").html(content);
                checkStatus();
            }
        })

    }

    function checkStatus() {
        var count = 0;
        $("input[name=ck_R_e]").each(function (i, e) {
            if (!$(e).is(':checked')) {
                count++;
            }
        })
        if (count > 0) {
            $("#checkAll_e").prop("checked", false);
        } else {
            $("#checkAll_e").prop("checked", true);
        }
    }

    function checkDepAll() {
        $("  input[name=ck_R_e]").each(function (i, e) {
            $(e).prop("checked", $("#checkAll_e").is(':checked'))
        })
    }

    function getids(name) {
        var ids = "";
        $("div[name=" + name + "]  input[type=checkbox]").each(function (i, e) {
            if ($(e).prop("checked")) {
                ids += $(e).val();
                ids += "_";
            }
        });
        console.log(ids.substr(0, ids.length - 1))
        return ids.substr(0, ids.length - 1);
    }

    function checkOne() {
        var count = 0;
        $("input[name=ck_R_e]").each(function (i, e) {
            if (!$(e).prop("checked")) {
                count++;
            }
        })
        if (count > 0) {
            $("#checkAll_e").prop("checked", false);
        } else {
            $("#checkAll_e").prop("checked", true);
        }
    }
</script>
</body>