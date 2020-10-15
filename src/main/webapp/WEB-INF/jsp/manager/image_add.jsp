<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<body>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">添加图片</h4>
</div>
<form id="paper-add-form" action="<%=basePath %>manager/addImage" method="post" class="form-horizontal"
      enctype="multipart/form-data">
    <div class="modal-body">
        <div class="form-group">
            <div class="col-md-2 control-label">
                <label>图片</label>
            </div>
            <div class="col-md-9 controls">
                <input type="file" name="logoFile" id="logoFile" οnchange="setImg(this);" class="form-control">
                <input type="hidden" name="img" id="photoUrl"/>
                <span><img id="photourlShow" src="" width="300" height="197" style="display: none"/></span>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-2 control-label">
                <label>所属模块:</label>
            </div>
            <div class="col-md-9 controls">
                <div class="form-check form-check-inline">
                    <c:forEach items="${list}" var="obj">
                        <label class="form-check-label" style="margin-left:20px;">
                            <input type="checkbox" name="useModel" value="${obj.id}"><span>${obj.dictValue}</span>
                        </label>
                    </c:forEach>
                </div>

            </div>
        </div>
        <div class="form-group">
            <div class="col-md-9" style="margin-left: 20px;margin-bottom: 5px;">上传时最好选择图片大小：500*328</div>
            <%--<div class="alert alert-warning">上传时最好选择图片大小：500*328</div>--%>
            <div class="col-md-9" style="margin-left: 20px;margin-bottom: 5px;">首页轮播图最好不要超过三张</div>
        </div>
    </div>
    <div class="modal-footer">
        <button class="btn btn-primary pull-right" type="button" id="add-paper-btn">提交</button>
        <button data-dismiss="modal" class="btn btn-link pull-right" type="button">取消</button>
    </div>
</form>
<script type="text/javascript">
    var c_id = $("#c_id").val();
    var path = '<%=path%>'
    $(document).ready(function () {
        $('#paper-add-form').bootstrapValidator({}).on('success.form.bv', function (e) {
            e.preventDefault();
            var fd = new FormData($("#paper-add-form")[0]);
            fd.append('file', $('#logoFile')[0].files[0]);
            if($("input[type=checkbox]:checked").length == 0){
                layer.msg("请选择所属模块", {icon: 2});
                $("#add-paper-btn").button('reset');
                return;
            }
            var $form = $(e.target);
            setImg(fd);
        });

        $("#add-paper-btn").on('click', function (event) {
            //提交时验证表单
            $('#paper-add-form').bootstrapValidator('validate');
        });

    });

    //用于进行图片上传，返回地址
    function setImg(data) {
        $.ajax({
            type: "POST",
            url: path + "/manager/addImage",
            data: data,
            cache: false,
            contentType: false, //不可缺
            processData: false, //不可缺
            dataType: "json",
            success: function (ret) {
                if (ret && ret.success) {
                    layer.msg(ret.message, {icon: 1});
                    loadData()
                    $("#dModal").modal('hide');
                } else {
                    layer.msg(ret.message, {icon: 2});
                    $("#url").val("");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.alert("上传失败，请检查网络后重试");
            }
        });
    }
</script>
</body>