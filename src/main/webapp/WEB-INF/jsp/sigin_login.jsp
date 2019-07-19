<%@ page language="java"
         pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<form id="addForm" method="post" class="form-horizontal" action="">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">登录</h4>
    </div>
    <div class="modal-body">
        <div class="form-group mu-fm-ipt-w">
            <div class="form-group mu-fm-ipt-w">
                <label class="col-sm-3 control-label">用户名 <span class="cl-red">*</span></label>
                <div class="col-sm-8">
                    <input type="text" placeholder=" 请输入用户名" class="form-control" name="name" id="name" maxlength="100"
                           value=""/>
                </div>
            </div>
        </div>
        <div class="form-group mu-fm-ipt-w">
            <div class="form-group mu-fm-ipt-w">
                <label class="col-sm-3 control-label">密码 <span class="cl-red">*</span></label>
                <div class="col-sm-8">
                    <input type="password" placeholder=" 请输入密码" class="form-control" name="password" id="password"
                           maxlength="100"
                           value=""/>
                </div>
            </div>
        </div>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-link" data-dismiss="modal" tabindex="6">取消</button>
        <button type="button" class="btn btn-primary" name="addBtn" id="addBtn">保存</button>
    </div>
</form>
<script type="text/javascript" src="<%=path%>/common/moment/min/moment.min.js"></script>
<script type="text/javascript">
    layer.close(idx);
    var path = '<%=path%>';
    var action_url = path + "/signLogin";
    $(document).ready(function () {
        $('#addForm').bootstrapValidator({
            message: '输入的数据没有验证通过',
            fields: {
                name: {message: '请输入用户名', validators: {notEmpty: {message: '请输入用户名'}}},
                password: {message: '请输入密码', validators: {notEmpty: {message: '请输入密码'}}}
            },
            submitButtons: "#addBtn"
        }).on('success.form.bv', function (e) {
            e.preventDefault();
            submitAddCourseTrain();

        });

        $("#addBtn").on('click', function (event) {
            $('#addForm').bootstrapValidator('validate', 'name');
            $('#addForm').bootstrapValidator('validate', 'password');
        });
    });

    function submitAddCourseTrain() {
        $.ajax({
            type: "POST",
            dataType: "json",
            url: action_url,
            data: {
                userName: $("#name").val(),
                password: $("#password").val(),
            },
            success: function (data) {
                if (data.success) {
                    $("#dModal").modal('hide');
                    setVal(true)
                    layer.msg("登陆成功，请重新签收", {icon: 1});
                } else {
                    $("#dModal").modal('hide');
                    setVal(false)
                    layer.msg("登陆失败，请检查用户名和密码", {icon: 2});
                }
            }, error: function (data) {
                layer.msg("未知异常", {icon: 2});
            }
        });
    }
</script>
<form id="ntForm" action="" method="post" target="_blank">
    <input id="id" name="id" type="hidden" value="0"/>
</form>