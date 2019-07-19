<%--
  Created by IntelliJ IDEA.
  User: 11930
  Date: 2019/5/24
  Time: 15:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
//    String chosenSiteId = (String) session.getAttribute(Constants.chosenSiteId);
//    String site_id = (StringUtilsExt.isEmpty(chosenSiteId)) ? (slst.get(0)).getId() + "" : chosenSiteId;
//
//    boolean isChangeSite = true;
%>
<div class="sidebar hidden-print" role="complementary">
    <div id="navigation">
        <%--<div class="well well-sm table-responsive">--%>
        <%--<% if (slst != null && slst.size() > 0) { %>--%>
        <%--<select class="form-control" name="site_id" id="site_id" onchange="changeSite(this.value);">--%>
        <%--<% for (Site site : slst) {--%>
        <%--if(site_id.equalsIgnoreCase(site.getId() + "")){--%>
        <%--isChangeSite = false;--%>
        <%--}--%>
        <%--%>--%>
        <%--<option value="<%=site.getId() %>"    <%=(site_id.equalsIgnoreCase(site.getId() + "") ? "selected" : "") %>   ><%=site.getName() %>--%>
        <%--</option>--%>
        <%--<% } %>--%>
        <%--</select>--%>
        <%--<% } %>--%>
        <%--</div>--%>
        <div id="setting_menu" class="list-group"></div>
    </div>
</div>
<script type="text/javascript">
    var path = '<%=path%>'
    $(function () {
        getMenu();
    });
    var currentMenu = "";

    function getMenu() {
        $.ajax({
            url: path + "/manager/getAllCategorys?r=" + Math.random(),
            type: 'POST',
            dataType: "json",
            success: function (data) {
                if (data.success) {
                    //组装菜单
                    var list = data.list;
                    var content = " <div class=\"panel-group list-group-panel\" id=\"accordion\">";
                    if (list && list.length > 0) {
                        $(list).each(function (i, e) {
                            if (i == 0) {
                                if (list[i].id != -1) {
                                    content += "<div class=\"panel panel-default\" onclick='changeGroupStatus(this)'>"
                                    content += "    <div class=\"panel-heading col-head\" >" +
                                        "                <h4 class=\"panel-title\">" +
                                        "                    <label  class=\"collapse-a\" data-toggle=\"collapse\" data-parent=\"#accordion\" >" + e.name + "</label>" +
                                        "                </h4>" +
                                        "            </div>" +
                                        "       </div>"

                                    content += "<div id=\"collapse_" + e.id + "\" class=\"panel-collapse collapse in \" >"
                                    content += "<div class=\"panel-body\">"
                                    content += "<div class=\"list-group\">"
                                    content += "<a id=" + e.id + " class='list-group-item'  href='#'>" + e.name + "</a>"
                                }
                            } else {
                                if (list[i - 1].parentId != list[i].parentId) {
                                    content += "       </div>"
                                    content += "       </div>"
                                    content += "       </div>"
                                    content += "<div class=\"panel panel-default\" onclick='changeGroupStatus(this)'>"
                                    content += "    <div class=\"panel-heading col-head\" >" +
                                        "                <h4 class=\"panel-title\">" +
                                        "                    <label  class=\"collapse-a\" data-toggle=\"collapse\" data-parent=\"#accordion\" >" + e.name + "</label>" +
                                        "                </h4>" +
                                        "            </div>" +
                                        "       </div>"

                                    content += "<div id=\"collapse_" + e.id + "\" class=\"panel-collapse collapse \" >"
                                    content += "<div class=\"panel-body\">"
                                    content += "<div class=\"list-group\">"
                                    content += "<a id=" + e.id + " class='list-group-item'  href='#'>" + e.name + "</a>"
                                } else {
                                    content += "<a id=" + e.id + " class='list-group-item'  href='#'>" + e.name + "</a>"
                                }
                            }
                        })
                    }
                    content += "</div>";
                    $('#setting_menu').html(content);
                    var currentId = '';

                    if (currentMenu != null && currentMenu != '' && $('#' + currentMenu).attr('id') != undefined) {
                        currentId = currentMenu
                    } else {
                        currentId = $($('#setting_menu').find('a')[0]).attr('id');
                    }

                    $('#' + currentId).addClass('active');

                    changeMenuPage(currentId);

                    $('#setting_menu').find('a').each(function (index, element) {
                        bindClickEvent($(element).attr('id'));
                    })
                }
            },
            error: function () {
                console.log("error")
            }
        });

    }


    function changeGroupStatus(id) {
        var status = $(id).next().attr("class");
        $(id).parent().children().each(function () {
            if (typeof ($(this).attr("id")) != "undefined") {
                if ($(this).attr("class").trim() == "panel-collapse collapse in".trim()) {
                    $(this).removeClass().addClass("panel-collapse collapse");
                }
            }
        })
        if (status.trim() == "panel-collapse collapse in".trim()) {
            $(id).next().removeClass().addClass("panel-collapse collapse")
        } else {
            $(id).next().removeClass().addClass("panel-collapse collapse in")
        }
    }

    function bindClickEvent(currentId) {
        $('#' + currentId).on('click', function () {
            $('#setting_menu').find('a').removeClass('active');
            $('#' + currentId).addClass('active');
            changeMenuPage(currentId);
        })
    }


    function changeMenuPage(currentId) {
        // currentMenu = currentId;
        //10 表示今日值班
        if(currentId == '9'){
            $('#system_date').load(path + '/due/dueForward?r='+Math.random());
        }/*else  if(currentId == '8'){
            $('#system_date').load(path + '/user/phoneForward?r='+Math.random());
        }*/else{
            $('#system_date').load(path + '/manager/gzdtForward?id=' + currentId);
        }
        // if (currentId == 'menu_setting') {
        //     $('#system_date').load(path + '/system/goSetting.action');
        // } else if (currentId == '-1') {
        //     $('#system_date').load(path + '/index');
        // } else if (currentId == '1') {
        //     $('#system_date').load(path + '/manager/gzdtForward');
        // } else if (currentId == '2') {
        //     $('#system_date').load(path + '/admin/report/user_top_10.jsp');
        // } else if (currentId == '3') {
        //     $('#system_date').load(path + '/admin/system/report/sys_login_info.jsp');
        // } else if (currentId == '4') {
        //     $('#system_date').load(path + '/admin/report/util/inter_index.jsp');
        // } else if (currentId == 'SCR') {
        //     $('#system_date').load(path + '/admin/report/util/credit_index.jsp');
        // } else if (currentId == '5') {
        //     $('#system_date').load(path + '/admin/system/report/course_count_report.jsp');
        // } else if (currentId == '6') {
        //     $('#system_date').load(path + '/admin/system/report/course_study_report.jsp');
        // } else if (currentId == '7') {
        //     $('#system_date').load(path + '/admin/system/report/course_lh_study_report.jsp');
        // } else if (currentId == '8') {
        //     $('#system_date').load(path + '/admin/system/report/class_count_report.jsp');
        // } else if (currentId == '9') {
        //     $('#system_date').load(path + '/admin/system/report/class_study_report.jsp');
        // } else if (currentId == '10') {
        //     $('#system_date').load(path + '/admin/system/report/class_course_report.jsp');
        // } else if (currentId == '11') {
        //     $('#system_date').load(path + '/admin/system/report/exam_count_report.jsp');
        // } else if (currentId == '12') {
        //     $('#system_date').load(path + '/admin/system/report/document_view_report.jsp');
        // } else if (currentId == '13') {
        //     $('#system_date').load(path + '/admin/system/report/sms_count_report.jsp');
        // } else if (currentId == '14') {
        //     $('#system_date').load(path + '/admin/system/report/sms_detail.jsp');
        // }
    }
</script>