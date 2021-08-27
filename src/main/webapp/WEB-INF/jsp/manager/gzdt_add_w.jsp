<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">添加</h4>
</div>
<form id="paper-add-form" action="<%=basePath %>manager/addArticle" method="post" class="form-horizontal"
      enctype="multipart/form-data">
    <div class="modal-body">
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
                <label>附件</label>
            </div>
            <div class="col-md-9 controls">
                <%--<input type="text" class="form-control" id="annex" name="annex">--%>
                <input type="file" name="annex" id="annex" class="form-control">
                <input type="hidden" name="a_id" id="a_id">
                    <%--<div class="post_box"></div>--%>
                    <%--<div class="upload_box clearfix"><input type="file" id="upload_file" name="file"/>--%>
                        <%--<label  for="upload_file" class="fl">点击上传简历</label> <span class="fl">（仅支持 pdf 格式文件；<br/> 文件大小需小于1M）</span>--%>
                    <%--</div>--%>
            </div>
        </div>
<%--    <div class="row form-group" <c:if test="${c_id} == 12">style="display: none"</c:if>>--%>
<%--        <div class="col-md-2 control-label">--%>
<%--        <label>选择模块</label>--%>
<%--        </div>--%>
<%--        <div class="col-md-9 controls" id="moudle_content">--%>
<%--        </div>--%>
<%--    </div>--%>


        <div class="row form-group" <c:if test="${c_id !=2}">style="display: none"</c:if>>
            <div class="col-md-2 control-label">
                <label>选择部门</label>
            </div>
            <div class="col-md-9 controls" id="dep_content">

            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button class="btn btn-primary pull-right" type="button" id="add-paper-btn">提交</button>
        <button data-dismiss="modal" class="btn btn-link pull-right" type="button">取消</button>
    </div>
</form>

<script src="<%=path %>/js/wangEditor.min.js"></script>
<script type="text/javascript">
    //实例化编辑器
    const E = window.wangEditor;
    const editor = new E('#ue_content');
    // 设置编辑区域高度为 500px
    // editor.config.height = 500;
    editor.config.customAlert = function (s) {
        console.log('customAlert: ' + s)
    };
    //隐藏插入网络图片的功能
    editor.config.showLinkImg = false;
    // 配置 server 接口地址
    editor.config.uploadImgServer = '/upload-img';

    // 默认限制图片大小是 5M ，可以自己修改。
    // editor.config.uploadImgMaxSize = 2 * 1024 * 1024 // 2M

    // 图片数量 默认为 100 张，需要限制可自己配置。
    // editor.config.uploadImgMaxLength = 5 // 一次最多上传 5 个图片

    // timeout 即上传接口等待的最大时间，默认是 10 秒钟，可以自己修改。
    // editor.config.uploadImgTimeout = 5 * 1000


    //如果想完全自己实现图片上传的过程，如上传图片到某个云服务器，可以使用如下代码。
    // editor.config.customUploadImg = function (resultFiles, insertImgFn) {
    //     // resultFiles 是 input 中选中的文件列表
    //     // insertImgFn 是获取图片 url 后，插入到编辑器的方法
    //
    //     // 上传图片，返回结果，将图片插入到编辑器中
    //     insertImgFn(imgUrl)
    // }
    editor.create();
    $(document).ready(function () {
        var c_id = $("#c_id").val();
        // 表单验证
        $('#paper-add-form').bootstrapValidator({}).on('success.form.bv', function (e) {
            e.preventDefault();
            var ids = getids('depListDiv');
            var $form = $(e.target);
            var keys = gbForm.getCheckboxValue("ck_R");
            if ($("#Atitle").val() == null || $("#Atitle").val() == '') {
                layer.msg("请输入标题", {icon: 2});
                $("#add-paper-btn").button('reset');
                return;
            } else if ( editor.txt.html() == null ||  editor.txt.html() == '') {
                layer.msg("请输入内容", {icon: 2});
                $("#add-paper-btn").button('reset');
                return;
            } else if (c_id == 2) {
                if (keys == null || keys == "") {
                    layer.msg("部门至少要选择一个，请选择！", {icon: 2});
                    $("#add-paper-btn").button('reset');
                    return;
                }
            } else {
                if (c_id != 2) {
                    ids = "-1";
                }
            }   // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');
            if($("#annex").val()){
                uploadAnnex(ids)
            }else{
                addArticle(ids)
            }

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
        //ids为部门id的集合
        var article = {};
        article.title = $("#Atitle").val();
        article.content = editor.txt.html();
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
        //加载部门数据
    function loadDepData() {
        $.ajax({
            url: path + '/dep/getAllDeps',
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
                var content = '<div class="panel-body">'
                if (data && data.success) {
                    var list = data.list;
                    if (list && list.length > 0) {
                        content += '<div class="panel-heading col-head"> ' +
                            '<input  class="form-control pull-left"   style="height: 25px;width: 25px;margin: 0;" type="checkbox" name="ck_C" id="checkAll" onclick="checkDepAll()">' +
                            '<label class="collapse-a" data-toggle="collapse" data-parent="#accordion" href="#collapse_SLS">全选</label>' +
                            '</div>' +
                            '<div name="depListDiv">'
                        $(list).each(function (i, e) {
                            var ck = '';
                            if (e.checked == "Y") {
                                ck = 'checked';
                            }
                            ckcount4++;
                            content += '<div class="btn btn-default" style="border:0px;margin:0px;"> <span class="btn btn-default" style="margin: 5px;padding:5px;"><input type="text"  readonly="true" id="' + e.id + '_nm" value="' + e.name + '" style="width: 60px;margin-bottom: 2px;border-radius: 5px;padding:2px;border:1px solid #999;"><br/>' +
                                '<input ' + ck + ' class="form-control pull-left" style="height: 25px;width: 25px;margin: 0;" type="checkbox" name="ck_R" value="' + e.id + '" onclick="checkOne(this)">' +
                                '<input maxlength="2" class="form-control" style="height: 25px;width: 25px" type="text" id="' + e.id + '_od" name="' + e.name + '_od" value="' + ckcount4 + '"  >' +
                                '</span></div>';
                        })
                    }
                }
                content += '</div>';
                content += '</div>';
                $("#dep_content").html(content);
            }
        })

    }

        //加载模块数据
        function loadModuleData(){
        }

    function checkDepAll() {
        $("  input[name=ck_R]").each(function (i, e) {
            $(e).prop("checked", $("#checkAll").is(':checked'))
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

    function checkOne(obj) {
        var categoryid = $($(obj).parent().parent()[0]).attr("name")
        var count = 0;
        $("input[name=ck_R]").each(function (i, e) {
            if (!$(e).prop("checked")) {
                count++;
            }
        })
        if (count > 0) {
            $("#checkAll").prop("checked", false);
        } else {
            $("#checkAll").prop("checked", true);
        }
    }

    function checkboxName(name) {
        var checkboxs = document.getElementsByName(checkboxName);
        var ck = new Array();
        var j = 0;
        for (var i = 0; i < checkboxs.length; i++) {
            var checkbox = checkboxs[i];
            if (checkbox.checked) {
                if (gbForm.isNullOrEmpty(checkbox.value)) return undefined;
                ck[j] = checkbox.value;
                j++;
            }
        }
        return j == 0 ? undefined : ck.join();
    }
</script>
</body>