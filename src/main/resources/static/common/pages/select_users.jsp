<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    String path = request.getContextPath();

    String type= request.getParameter("type");

%>
<div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h4 class="modal-title">选择学员</h4>
</div>
<div class="modal-body">
    <div class="row">
        <div class="col-md-3 left_column">
            <a href="javascript:" class="bar"><i class="glyphicon glyphicon-chevron-left"></i></a>
            <iframe id="treeIfm" style="border:1px solid #D4D0C8;" name="treeIfm" frameborder="0" height="480px" width="100%" scrolling="auto" src="<%=path %>/common/pages/sel_users_ugtree.jsp"></iframe>
        </div>
        <div class="col-md-6 centre_column" >
            <form id="message-search-form" class="form-inline well well-sm well-cln sel_frm" action="" method="post">
				<input type="hidden" name="keyTypeUs" id="keyTypeUs" value="" />
                <input type="text" id="keywordUs" class="form-control ipt-mgn" name="keywordUs" value="" placeholder="用户ID/姓名">
                <input type="text" id="keywordEmail" class="form-control ipt-mgn" name="keywordEmail" value="" placeholder="邮件地址">
                <%--<input type="text" id="keywordMobile" class="form-control ipt-mgn" name="keywordMobile" value="" placeholder="手机号">--%>
                <select class="form-control" name="keywordSex" id="keywordSex">
                    <option value="">选择性别</option>
                    <option value="M">男</option>
                    <option value="F">女</option>
                </select>
                <div id="search" class="collapse">
                    <%--<input type="text" class="form-control" id="manager_name" name="manager_name" value="" placeholder="上级主管">--%>
                    <input type="text" class="form-control" id="emplid" name="emplid" value="" placeholder="员工编号">
                    <input type="text" class="form-control" id="postname" name="postname" value="" placeholder="岗位名称">
                    <div class="form-group" style="margin-top: 13px">
                        <label>入司时间</label>
                        <input class="form-control" id="join_company_start_date" name="join_company_start_date" size="16" type="text" value="" placeholder="开始" readonly>
                        <input class="form-control" id="join_company_end_date" name="join_company_end_date" size="16" type="text" value="" placeholder="结束" readonly>
                    </div>
<%--
                    <div class="form-group" style="margin-top: 13px">
                        <label>开始工作时间</label>
                        <input class="form-control" id="start_work_start_date" name="start_work_start_date" size="16" type="text" value="" placeholder="开始" readonly>
                        <input class="form-control" id="start_work_end_date" name="start_work_end_date" size="16" type="text" value="" placeholder="结束" readonly>
                    </div>
--%>

                    <select class="form-control" name="probation" id="probation" style="margin-top: 13px">
                        <option value="">是否试用期</option>
                        <option value="1">是</option>
                        <option value="0">否</option>
                    </select>
                </div>

                <input type="button" class="btn btn-primary ipt-mgn" onclick="loadSelUsers(1);" value='搜索' />
                <a href="#search" data-toggle="collapse" class="btn btn-link pull-right">高级搜索</a>
                <a class="btn btn-link pull-right" href="javascript:clearnSearch();" >重置搜索条件</a>
            </form>
            <div id="users_data">请输入搜索条件查询用户。</div>
        </div>
        <div class="col-md-3">
            <div class="text-center" style="border:1px solid #D4D0C8;height:45px;overflow: auto;padding: 12px 0 0 2px;background-color: #CCCCCC">
                已选用户
            </div>
            <div id="sel_user" style="border:1px solid #D4D0C8;height:440px;overflow: auto;padding: 0 0 0 2px;"></div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-primary" onclick="getAllSearchUsers();return false;"  name="addAllBtn" id="addAllBtn" >使用查询结果全集</button>
    <button type="button" class="btn btn-link" data-dismiss="modal" tabindex="6">取消</button>
    <button type="button" class="btn btn-primary" onclick="returnVal();return false;"  name="addBtn" id="addBtn" >使用已选用户</button>
</div>
<script type="text/javascript">
    var path = "<%=path %>";
    var us_site_id = 0,us_user_group_id = 0;
    var flag = true;
    $('input, textarea').placeholder();
    function loadSelUsers(cp){
        idx = layer.load(300);
        var data = getParametersforSelUsers(cp);
        var sel_user_url = path + "/user/getAllUsersOfUserGroupToSel.action?r="+Math.random();
        $("#users_data").load(sel_user_url,data,function(res){
            //$('input, textarea').placeholder();
            loadSelUser();setChkSel();layer.close(idx);initB3paginatorForSelUsers();setPagerShowHide();
        });
    }
    function getAllSearchUsers(){
        var data = getParametersforSelUsers(1);
        selAllConditonUsers(data);
    }

    //获得提交参数
    function getParametersforSelUsers(cp){
        var no_search_condition=true;
        if(us_site_id != 0)	no_search_condition=false;
        if($('#keywordUs').val()!=null && $('#keywordUs').val()!="" ) no_search_condition=false;
        if($('#keywordEmail').val()!=null && $('#keywordEmail').val()!="" ) no_search_condition=false;
        if($('#keywordUsJob').val()!=null && $('#keywordUsJob').val()!="" ) no_search_condition=false;
        if($('#keywordUsSupvLvl').val()!=null && $('#keywordUsSupvLvl').val()!="" ) no_search_condition=false;
        if($('#keywordMobile').val()!=null && $('#keywordMobile').val()!="" ) no_search_condition=false;
        if($('#start_work_start_date').val()!=null && $('#start_work_start_date').val()!="" ) no_search_condition=false;
        if($('#start_work_end_date').val()!=null && $('#start_work_end_date').val()!="" ) no_search_condition=false;
        if($('#join_company_start_date').val()!=null && $('#join_company_start_date').val()!="" ) no_search_condition=false;
        if($('#join_company_end_date').val()!=null && $('#join_company_end_date').val()!="" ) no_search_condition=false;
        if($('#postname').val()!=null && $('#postname').val()!="" ) no_search_condition=false;
        if($('#probation').val()!=null && $('#probation').val()!="" ) no_search_condition=false;
        if($('#emplid').val()!=null && $('#emplid').val()!="" ) no_search_condition=false;
        if($('#manager_name').val()!=null && $('#manager_name').val()!="" ) no_search_condition=false;
        if(no_search_condition) {layer.alert('请输入合适必要的查询条件才能执行此操作', 8);  return false;}

        var curp = $('#curPageUs').val();
        if(us_site_id == 0 && !flag){us_site_id = 1;}
        if(cp != null && cp != ''){ curp = cp; }

        var data = {
            "user.pageSize": $('#pageSizeUs').val() == null ? "0" : $('#pageSizeUs').val(),
            "user.curPage": curp,
            "user.totPage": $('#totPageUs').val() == null ? "0" : $('#totPageUs').val(),
            "user.totCount": $('#totCount').val() == null ? "0" : $('#totCount').val(),
            "user.site_id": us_site_id,
            "user.user_group_id": us_user_group_id,
            "keyType": $('#keyTypeUs').val(),
            "keyword": $('#keywordUs').val(),
            "user.username": $('#keywordUs').val(),
            "user.email":$("#keywordEmail").val(),
            "user.userAttr.jobcode":$("#keywordUsJob").val(),
            "user.userAttr.supv_lvl_id":$("#keywordUsSupvLvl").val(),
            "user.mobile":$('#keywordMobile').val(),
            "user.userAttr.sex":$('#keywordSex').val(),
            "user.userAttr.start_work_start_date":$('#start_work_start_date').val(),
            "user.userAttr.start_work_end_date":$('#start_work_end_date').val(),
            "user.userAttr.join_company_start_date":$('#join_company_start_date').val(),
            "user.userAttr.join_company_end_date":$('#join_company_end_date').val(),
            "user.userAttr.postname":$('#postname').val(),
            "user.userAttr.probation":$('#probation').val(),
            "user.emplid":$('#emplid').val(),
            "user.manager_name":$('#manager_name').val(),
            "user.is_invalid":'N' /*禁封用户*/
        };
        return data;
    }
    function clearnSearch(){
        flag = false;
        us_site_id = 0;
        $('#keywordUs').val("");
        $("#keywordEmail").val("");
        $("#keywordUsJob").val("");
        $("#keywordUsSupvLvl").val("");
        $("#keywordMobile").val("");
        $("#keywordSex").val("");
        $('#emplid').val('');
        $('#manager_name').val('');
        $('#probation').val('');
        $('#start_work_start_date').val('');
        $('#start_work_end_date').val('');
        $('#join_company_start_date').val('');
        $('#join_company_end_date').val('');
        $('#postname').val('');
        $("#users_data").html("请输入搜索条件查询用户。");
        getIframe("treeIfm").cancelSelectNote();
    }
    function setPagerShowHide(){
        if(us_site_id == 1 && !flag){
            $("#pagination_main").hide();
        }else{
            $("#pagination_main").show();
        }
    }
    //初始化分页
    function initB3paginatorForSelUsers(){
        var data = getParametersforSelUsers();
        //基本分页
        b3Paginator('paginationUs', 5, data['user.curPage'], data['user.pageSize'], data['user.totPage'],
            function(event, originalEvent, type, page){
                var goPage = 1;
                if(type == "first") goPage = 1;
                else if(type == "prev") goPage = parseInt(data['user.curPage']) - 1;
                else if(type == "next") goPage = parseInt(data['user.curPage']) + 1;
                else if(type == "last") goPage = data['user.totPage'];
                else if(type == "page") goPage = page;
                //页面跳转方法自行定义
                loadSelUsers(goPage);
            }, function (type, page, current) {
                return null;
            });

        //初始化每页显示条数
        $(".page-list").b3paginatorext({
            onPageSizeChange:function(){loadSelUsers();},
            pagesizeinput:"#pageSizeUs",
            pagesize:data['user.pageSize'],
            totcount:data['user.totCount']});
    }


    var umap = new JHashMap();
    function loadSelUser(){
        if(umap.size() == 0){
            $("#sel_user").html("没有选择学员");
        }else{
            var keys = umap.keySet();
            var nameStr = "";
            if(keys != null && keys.length > 0){
                for(var i=0;i<keys.length;i++){
                    nameStr = nameStr + "<nobr>" + umap.get(keys[i]) + " <img style='cursor: pointer;' onclick='delSelUser(\""+keys[i]+"\")' src='"+path+"/common/images/delete.gif'/></nobr><br/>";
                }
            }
            if(nameStr != null && nameStr != ''){
                $("#sel_user").html(nameStr);
            }else{
                $("#sel_user").html("没有选择学员");
            }
        }
    }
    function delSelUser(chkey){
        if(umap.get(chkey) != null && umap.get(chkey)!= ""){
            umap.remove(chkey);
            var rowNum = $("#row_"+chkey).val();
            if(rowNum != null && rowNum != ""){
                if(rowNum%2==0){
                    $("#tr_"+chkey).removeClass("XCLTableList_trChecked");
                    $("#tr_"+chkey).addClass("XCLTableList_trEven");
                }else{
                    $("#tr_"+chkey).removeClass("XCLTableList_trChecked");
                    $("#tr_"+chkey).addClass("XCLTableList_trOdd");
                }
                $("#ck_"+chkey).attr("checked",false);
            }
            loadSelUser();
        }
    }
    function setChkSel(){
        if(umap.size() != 0){
            var keys = umap.keySet();
            var rowNum = 0;
            if(keys != null && keys.length > 0){
                for(var i=0;i<keys.length;i++){
                    $("#ck_"+keys[i]).attr("checked",true);
                    rowNum = $("#row_"+keys[i]).val();
                    if(rowNum%2==0){
                        $("#tr_"+keys[i]).removeClass("XCLTableList_trEven");
                    }else{
                        $("#tr_"+keys[i]).removeClass("XCLTableList_trOdd");
                    }
                    $("#tr_"+keys[i]).addClass("XCLTableList_trChecked");
                }
            }
        }
    }
    function setCheckboxValues(chkName){
        var checkbox = document.getElementsByName(chkName);
        var uname = "";
        var rowNum = 0;
        if(checkbox && checkbox.length > 0){
            for(var i = 0;i < checkbox.length;i++){
                if(checkbox[i].checked && checkbox[i].disabled == false){
                    if(umap.get(checkbox[i].value) == null || umap.get(checkbox[i].value) == ""){
                        uname = $("#name_"+checkbox[i].value).val();
                        umap.put(checkbox[i].value,uname);
                    }
                }else{
                    if(umap.get(checkbox[i].value) != null && umap.get(checkbox[i].value)!= ""){
                        umap.remove(checkbox[i].value);
                        rowNum = $("#row_"+checkbox[i].value).val();
                        if(rowNum%2==0){
                            $("#tr_"+checkbox[i].value).removeClass("XCLTableList_trChecked");
                            $("#tr_"+checkbox[i].value).addClass("XCLTableList_trEven");
                        }else{
                            $("#tr_"+checkbox[i].value).removeClass("XCLTableList_trChecked");
                            $("#tr_"+checkbox[i].value).addClass("XCLTableList_trOdd");
                        }
                    }
                }
            }
        }
        loadSelUser();
    }
    var type ='<%=type%>';
    function returnVal(){
        var uids = umap.keySet();
        if(uids == null || uids.length == 0){
            layer.alert('请选择学员后再点击确定按钮！', 8);
        }else{
            if(type=='KBMS'){
                uids=$(uids).map(function (index,ele) {
                    return  {"id":ele,"name":umap.get(ele),"type":"U"};
                });
            }
            if(type=='UCENTER'){
                uids=$(uids).map(function (index,ele) {
                    return  {"id":ele,"name":umap.get(ele)};
                });
            }

            selUsers(uids);

        }
    }
    function getIframe(ifr){
        var obj;
        if(navigator.appName == "Netscape") {//firefox等兼容
            obj = document.getElementById(ifr).contentWindow;
        }else{//ie兼容
            obj = document.frames[ifr];
        }
        return obj;
    }


    $(function () {
        initTime('join_company_start_date','join_company_end_date');
        initTime('start_work_start_date','start_work_end_date');

        //var bar_before_style='width:25px;height:105px;position:absolute;right:-10px;top:-1px;background-color: red;';
        var bar_before_style='width:25px;height:20px;position:absolute;right:-10px;';
        //var bar_after_style='width:25px;height:105px;position:absolute;top:15px;z-index:999;background:rgba(0, 0, 0, 0);';
        var bar_after_style='width:25px;height:20px;position:absolute;top:15px;z-index:999;';
        $('.bar').attr('style',bar_before_style);
        $('.left_column').css('left','0px');
        var expanded = true;

        $('.bar').click(function(){
            var bar_left = $('.bar').position().left;

            if(expanded){
                $('.left_column').animate({left:-parseFloat(bar_left)},500,function () {
                    $('#treeIfm').hide();
                    $('.bar').attr('style',bar_after_style);
                    $('.left_column').removeClass('col-md-3');
                    $('.centre_column').removeClass('col-md-6');
                    $('.centre_column').addClass('col-md-9');
                    $('.bar i').removeClass();
                    $('.bar i').addClass('glyphicon glyphicon-chevron-right');
                    $('#join_company_start_date').parent().attr('style','');
                    /* $('.bar').mouseover(function () {
                     var bar_active_style='width:25px;height:105px;position:absolute;top:15px;z-index:999;background-color: red;';
                     $('.bar').attr('style',bar_active_style);
                     });
                     $(".bar").mouseout(function(){
                     $('.bar').attr('style',bar_after_style);
                     });*/
                });
                $('.bar').css('background-position','-10px 0px');
            }else{
                $('#treeIfm').show();
                $('.bar').attr('style',bar_before_style);
                $('.left_column').addClass('col-md-3');
                $('.centre_column').removeClass('col-md-9');
                $('.centre_column').addClass('col-md-6');

                $('.bar i').removeClass();
                $('.bar i').addClass('glyphicon glyphicon-chevron-left');

                /* $('.bar').mouseover(function () {
                 $('.bar').attr('style',bar_before_style);
                 });
                 $(".bar").mouseout(function(){
                 $('.bar').attr('style',bar_before_style);
                 });*/

                $('.left_column').animate({left:'0px'},500);

                $('.bar').css('background-position','-0px 0px');
            }
            expanded = !expanded;
        });
    });
    function initTime(start_date,end_date){
        var start;
        var end;
        var $start_date=$('#'+start_date);
        var $end_date=$('#'+end_date);
        $start_date.datetimepicker({
            format: 'yyyy-mm-dd',
            language:  'zh-CN',
            autoclose: 1,
            startView: 2,
            minView: 2,
            linkField: "mirror_field",
            linkFormat: "yyyy-mm-dd"
        }).on('changeDate',function(ev){
            start = $start_date.val();
            end = $end_date.val();
            if(start != null && start != "" && end != null && end != "" && start > end){
                $start_date.val("");
                layer.alert("提示，开始如期不能大于结束日期！",{icon:7});
            }
        }).on('hide',function(event){
            event.preventDefault();
            event.stopPropagation();
        });

        $end_date.datetimepicker({
            format: 'yyyy-mm-dd',
            language:  'zh-CN',
            autoclose: 1,
            startView: 2,
            minView: 2,
            linkField: "mirror_field",
            linkFormat: "yyyy-mm-dd"
        }).on('changeDate',function(ev){
            start = $start_date.val();
            end = $end_date.val();
            if(start != null && start != "" && end != null && end != "" && end < start){
                $end_date.val("");
                layer.alert("提示，结束日期不能小于开始日期！",{icon:7});
            }
        }).on('hide',function(event){
            event.preventDefault();
            event.stopPropagation();
        });
    }
</script>