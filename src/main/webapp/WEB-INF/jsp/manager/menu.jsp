<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<div class="sidebar hidden-print" role="complementary">
    <div id="navigation">
        <%--        <div id="setting_menu" class="list-group">--%>
        <%--            <div class="panel panel-default" onclick='changeGroupStatus(this)'>--%>
        <%--                <div class="panel-heading col-head">--%>
        <%--                    <h4 class="panel-title">1234</h4>--%>
        <%--                </div>--%>
        <%--                <div id="collapse_1" class="panel-collapse collapse in ">--%>
        <%--                    <div class="panel-body">--%>
        <%--                        <div class="list-group">--%>
        <%--                            <a id="11" class='list-group-item' href='#'>秩序通报</a>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--            </div>--%>

        <%--            <div class="panel panel-default" onclick='changeGroupStatus(this)'>--%>
        <%--                <div class="panel-heading col-head">--%>
        <%--                    <h4 class="panel-title">1234</h4>--%>
        <%--                </div>--%>
        <%--                <div id="collapse_2" class="panel-collapse collapse in ">--%>
        <%--                    <div class="panel-body">--%>
        <%--                        <div class="list-group">--%>
        <%--                            <a id="1" class='list-group-item' href='#'>工作动态</a>--%>
        <%--                            <a id="2" class='list-group-item' href='#'>通知通报</a>--%>
        <%--                            <a id="3" class='list-group-item' href='#'>秩序通报</a>--%>
        <%--                            <a id="5" class='list-group-item' href='#'>宣传报道</a>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>
        <%--                </div>--%>
        <%--            </div>--%>

        <%--        </div>--%>
        <div id="test1"></div>
    </div>
</div>
<link href="<%=path %>/common/layui/css/layui.css" rel="stylesheet">
<script type="text/javascript" src="<%=path %>/common/layui/layui.all.js"></script>
<script type="text/javascript">
    var path = '<%=path%>';
    var currentMenu = "";
    $(function () {
        // getMenu();
        // layui.use('tree', function () {
        //     var tree = layui.tree;
        //     var result = test();
        //     console.log(result);
        //     var inst1 = tree.render({
        //         elem: '#test1',
        //         data: result,
        //     })
        // });

        resoleData();
    });
    var categoryList = [];

    function resoleData() {
        return new Promise(function (resolve) {
            $.ajax({
                url: path + "/manager/getAllCategorys?r=" + Math.random(),
                type: 'POST',
                dataType: "json",
                success: function (data) {
                    if (data && data.success) {
                        categoryList = data.list;
                        let convertElement = convert(categoryList);
                        //转换成json字符串，然后替换数据库字段name为title
                        let replaceAll = JSON.stringify(convertElement).replaceAll("name", "title");
                        //页面显示需要，需提供数组类型参数
                        resolve(eval(replaceAll));
                    }
                }
            })
        }).then(function (data) {
            layui.use('tree', function () {
                var tree = layui.tree;
                var inst1 = tree.render({
                    elem: '#test1',
                    data: data,
                    click:function(obj){
                        console.log(obj.data); //得到当前点击的节点数据
                        console.log(obj.state); //得到当前节点的展开状态：open、close、normal
                        console.log(obj.elem); //得到当前节点元素
                        console.log(obj.data.children); //当前节点下是否有子节点
                        //如果当前节点有子节点不做任何操作，如果为叶子节点，则填充页面右侧内容
                        if(!obj.data.children){
                            changeMenuPage(obj.data.id);
                        }
                    }
                })
            });
        })
    }

    function getData() {
        $.ajax({
            url: path + "/manager/getAllCategorys?r=" + Math.random(),
            type: 'POST',
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    categoryList = data.list;
                    let convertElement = convert(categoryList);
                    return JSON.stringify(convertElement).replaceAll("name", "title");
                }
            }
        })
    }

    function convert(list) {
        const res = []
        const map = list.reduce((res, v) => (res[v.id] = v, res), {})
        for (const item of list) {
            if (item.parentId === -1) {
                res.push(item);
                continue
            }
            if (item.parentId in map) {
                const parent = map[item.parentId]
                parent.children = parent.children || []
                parent.children.push(item)
            }
        }
        return res
    }

    function getMenu() {

        getList();
        // $.ajax({
        //     url: path + "/manager/getAllCategorys?r=" + Math.random(),
        //     type: 'POST',
        //     dataType: "json",
        //     success: function (data) {
        //         if (data.success) {
        //             //组装菜单  一级菜单和二级菜单  必须得有二级菜单
        //             var list = data.list;
        //             var content = " <div class=\"panel-group list-group-panel\" id=\"accordion\">";
        //             if (list.length > 0) {
        //                 for (var i = 0; i < list.length; i++) {
        //                     //组装根目录菜单 list[0]
        //                     if (list[i].id == -1) {
        //                         content += "<div class=\"panel panel-default\" onclick='changeGroupStatus(this)'>"
        //                         content += "    <div class=\"panel-heading col-head\" >" +
        //                             "                <h4 class=\"panel-title\">" +
        //                             "                    <label  class=\"collapse-a\" data-toggle=\"collapse\" data-parent=\"#accordion\" >" + list[i].name + "</label>" +
        //                             "                </h4>" +
        //                             "            </div>" +
        //                             "       </div>"
        //
        //                         content += "<a id=\"asdf\" class='list-group-item'  href='#'>测试子菜单</a>"
        //                         content += "<a id=\"asdf\" class='list-group-item'  href='#'>测试子菜单2</a>"
        //                         content += "       </div>"
        //                         content += "       </div>"
        //                         content += "       </div>"
        //                     } else {
        //                         //当为第一个子菜单的时候，拼接此参数  //否则不拼接
        //                         content += "<div id=\"collapse_1\" class=\"panel-collapse collapse in \" >"
        //                         content += "<div class=\"panel-body\">"
        //                         content += "<div class=\"list-group\">"
        //
        //
        //                         var chileFirstContent = "";
        //                         //表示一级菜单
        //                         if (list[i].parentId == -1) {
        //                             var childCount = 0;
        //                             var childStr = "";
        //                             for (var j = i; j < list.length; j++) {
        //                                 if (list[j].parentId == list[i].id) {
        //                                     childCount++;
        //                                     // 设置list[i] 拼接子菜单
        //                                     childStr += "";
        //                                 }
        //                             }
        //                             if (childCount > 0) {
        //                                 //设置list【i】为父级菜单，拼接子菜单childStr
        //                             } else {
        //                                 //设置list[i]为子菜单
        //                             }
        //                         }
        //                     }
        //                 }
        //             }
        //             // if (list && list.length > 0) {
        //             // $(list).each(function (i, e) {
        //             //     //返回结果按照id升序排列
        //             //         if (list[i].id == -1) {
        //             //             content += "<div class=\"panel panel-default\" onclick='changeGroupStatus(this)'>"
        //             //             content += "    <div class=\"panel-heading col-head\" >" +
        //             //                 "                <h4 class=\"panel-title\">" +
        //             //                 "                    <label  class=\"collapse-a\" data-toggle=\"collapse\" data-parent=\"#accordion\" >" + e.name + "</label>" +
        //             //                 "                </h4>" +
        //             //                 "            </div>" +
        //             //                 "       </div>"
        //             //
        //             //             content += "<div id=\"collapse_" + e.id + "\" class=\"panel-collapse collapse in \" >"
        //             //             content += "<div class=\"panel-body\">"
        //             //             content += "<div class=\"list-group\">"
        //             //             content += "<a id=" + e.id + " class='list-group-item'  href='#'>" + e.name + "</a>"
        //             //     } else {
        //             //         if (list[i - 1].parentId != list[i].parentId) {
        //             //             content += "       </div>"
        //             //             content += "       </div>"
        //             //             content += "       </div>"
        //             //         content += "<div class=\"panel panel-default\" onclick='changeGroupStatus(this)'>"
        //             //         content += "    <div class=\"panel-heading col-head\" >" +
        //             //             "                <h4 class=\"panel-title\">" +
        //             //             "                    <label  class=\"collapse-a\" data-toggle=\"collapse\" data-parent=\"#accordion\" >" + e.name + "</label>" +
        //             //             "                </h4>" +
        //             //             "            </div>" +
        //             //                 "       </div>"
        //             //
        //             //             content += "<div id=\"collapse_" + e.id + "\" class=\"panel-collapse collapse \" >"
        //             //             content += "<div class=\"panel-body\">"
        //             //             content += "<div class=\"list-group\">"
        //             //             content += "<a id=" + e.id + " class='list-group-item'  href='#'>" + e.name + "</a>"
        //             //         } else {
        //             //             content += "<a id=" + e.id + " class='list-group-item'  href='#'>" + e.name + "</a>"
        //             //         }
        //             //     }
        //             // })
        //             // }
        //             content += "</div>";
        //             $('#setting_menu').html(content);
        //             var currentId = '';
        //
        //             if (currentMenu != null && currentMenu != '' && $('#' + currentMenu).attr('id') != undefined) {
        //                 currentId = currentMenu
        //             } else {
        //                 currentId = $($('#setting_menu').find('a')[0]).attr('id');
        //             }
        //
        //             $('#' + currentId).addClass('active');
        //
        //             changeMenuPage(currentId);
        //
        //             $('#setting_menu').find('a').each(function (index, element) {
        //                 bindClickEvent($(element).attr('id'));
        //             })
        //         }
        //     },
        //     error: function () {
        //         console.log("error")
        //     }
        // });

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
        if (currentId == '9') {
            $('#system_date').load(path + '/due/dueForward?r=' + Math.random());
        } else if (currentId == '11') {
            //11表示图片设置
            $('#system_date').load(path + '/manager/uploadForward?r=' + Math.random());
        } else if (currentId == '12') {
            //12表示网站专栏设置
            $('#system_date').load(path + '/site/siteForward?r=' + Math.random());
        } else {
            $('#system_date').load(path + '/manager/gzdtForward?id=' + currentId);
        }
    }
</script>