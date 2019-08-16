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
<form id="paper-add-form" action="<%=basePath %>manager/addImage" method="post" class="form-horizontal"  enctype="multipart/form-data">
    <div class="modal-body">
        <div class="form-group">
            <div class="col-md-2 control-label">
                <label>标题</label>
            </div>
            <div class="col-md-9 controls">
                <input type="text" class="form-control" id="Atitle" name="title" placeholder="请输入标题">
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-2 control-label">
                <label>图片</label>
            </div>
            <div class="col-md-9 controls">
                <input type="file" name="logoFile" id="logoFile" οnchange="setImg(this);" class="form-control">
                <input type="hidden" name="img"  id="photoUrl"/>
                <span><img id="photourlShow" src="" width="300" height="197" style="display: none"/></span>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-2 control-label">
                <label>是否展示</label>
            </div>
            <div class="col-md-9 controls">
                <label><input type="radio" name="is_default"  value="Y"/> 是</label> &nbsp;
                <label><input type="radio" name="is_default"  value="N" checked/> 否</label>
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
    var path = '<%=path%>'
    // $(document).ready(function () {
    //     $('#paper-add-form').bootstrapValidator({}).on('success.form.bv', function (e) {
    //         // var description = ue.getContent();
    //         // $("#description").val(description);
    //         e.preventDefault();
    //         var $form = $(e.target);
    //         if ($("#Atitle").val() == null || $("#Atitle").val() == '') {
    //             layer.msg("请输入标题", {icon: 2});
    //             $("#add-paper-btn").button('reset');
    //             return;
    //         }  // Get the BootstrapValidator instance
    //         if($("#annex").val()){
    //             // uploadAnnex()
    //         }else{
    //             // addArticle()
    //         }
    //
    //     });
    //
    //     $("#add-paper-btn").on('click', function (event) {
    //         //提交时验证表单
    //         $('#paper-add-form').bootstrapValidator('validate');
    //     });
    //
    // });

    //用于进行图片上传，返回地址
    function setImg(obj){
        var f=$(obj).val();
        alert(f);
        console.log(obj);
        if(f == null || f ==undefined || f == ''){
            return false;
        }
        if(!/\.(?:png|jpg|bmp|gif|PNG|JPG|BMP|GIF)$/.test(f))
        {
           layer.alert("类型必须是图片(.png|jpg|bmp|gif|PNG|JPG|BMP|GIF)");
            $(obj).val('');
            return false;
        }
        var data = new FormData();
        console.log(data);
        $.each($(obj)[0].files,function(i,file){
            data.append('file', file);
        });
        console.log(data);
        $.ajax({
            type: "POST",
            url: path+"/manager/addImage",
            data: data,
            cache: false,
            contentType: false,    //不可缺
            processData: false,    //不可缺
            dataType:"json",
            success: function(ret) {
                if(ret && ret.success){
                    $("#photoUrl").val(ret.url);//将地址存储好
                    $("#photourlShow").attr("src",ret.url);//显示图片
                    layer.msg(ret.message,{icon:1});
                }else{
                    layer.msg(ret.message,{icon:2});
                    $("#url").val("");
                    $(obj).val('');
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                layer.alert("上传失败，请检查网络后重试");
            }
        });
    }


</script>
</body>