<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<%@include file="../common.jsp" %>

<head>
    <title>Title</title>
</head>
<body>
<div class="page-header">
    <%--<a class="btn btn-info pull-right" data-toggle='modal' data-target='#dt_modal'--%>
    <%--href="<%=path %>/manager/addDue" style="margin-right: 5px;">添加</a>--%>
    <h1> 今日值班 </h1>
</div>
<form id="addForm" method="post" class="form-horizontal" action="">
    <table class="table table-striped table-hover">
        <thead>
        <tr>
            <th>序号</th>
            <th>值班单位</th>
            <th>值班人员</th>
        </tr>
        </thead>
        <tbody id="table_head">
        <tr id="content">
            <td>{{id}}</td>
            <td>{{key}}</td>
            <td>{{value}}</td>
        </tr>
        </tbody>
    </table>
    <div class="modal-footer border:0px;">
        <%--<button type="button" class="btn btn-link" data-dismiss="modal" tabindex="6">取消</button>--%>
        <button type="button" class="btn btn-primary" name="addBtn" id="addBtn">保存</button>
    </div>
</form>
<input type="hidden" id="pageSize" value="5"/>
<input type="hidden" id="curPage" value="1"/>
<input type="hidden" id="totCount" value="100000"/>
</body>
<script type="text/javascript">
    var idx;
    var path = '<%=path%>';
    var content_html = $('#content').prop("outerHTML");
    var add_url = path + "/due/editDue"
    $(document).ready(function () {
        loadData();
    })
    var myArray = new Array()
    $("#addBtn").click(function () {
        $("#content input[name='due_value']").each(function (i, e) {
            var obj = {}
            obj.id = e.id;
            obj.value = e.value;
            myArray[i] = obj;
        })
        var str= JSON.stringify(myArray);
        $.ajax({
            type: 'POST',
            url: add_url,
            data: str,
            dataType: 'json',
            contentType:'application/json;charset=utf-8',
            success: function (data) {
                console.log(data)
                if(data&& data.success){
                    layer.msg(data.message, {icon: 1});
                    loadData();
                }else{
                    layer.msg(data.message, {icon: 2});
                }
            }
        });
    })

    function loadData() {
        var remote_url = path + '/due/getDueList?type=D'
        $.ajax({
            url: remote_url,
            contentType: 'application/json',
            type: 'POST',
            dataType: 'json',
            beforeSend: function () {
                loading = layer.load();
            },
            success: function (data) {
                layer.close(loading);
                if (data && data.success) {
                    var list = data.list;
                    var content = '';
                    if (list && list.length > 0) {
                        var cno = $('#pageSize').val() * ($('#curPage').val() - 1);
                        $(list).each(function (i, e) {
                            var html = content_html;
                            html = html.replace('{{id}}', (cno + i + 1))
                                .replace('{{key}}', e.key)
                                .replace('{{value}}', "<input type='text' id='" + e.id + "' style='width:auto;' name='due_value' value='" + e.value + "'/>")
                            content += html;
                        });
                    } else {
                        content = '<tr class="warning text-center"><td colspan="9"> 没有找到匹配的记录</td></tr>'
                    }
                } else {
                    layer.msg(data.message, {icon: 2});
                }
                $('#table_head').html(content);
                $('#table_head').show();
            }
        })
    }
</script>
</html>
