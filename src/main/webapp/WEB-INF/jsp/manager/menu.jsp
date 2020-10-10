<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
%>
<div class="sidebar hidden-print" role="complementary">
    <div id="navigation" class="left-nav">
        <div id="test1" class="list-group"></div>
    </div>
</div>
<link href="<%=path %>/common/layui/css/layui.css" rel="stylesheet">
<script type="text/javascript" src="<%=path %>/common/layui/layui.all.js"></script>
<%--本地调用--%>
<script type="text/javascript" src="<%=path %>/common/profile/http_cdn.polyfill.io_v2_polyfill.js"></script>
<script type="text/javascript">
    var path = '<%=path%>';
    var currentMenu = "";

    var firstId = "";
    $(function () {
        initMenu();
        changeMenuPage(1)
        //获取第一个非子菜单的id
    });
    var categoryList = [];

    function initMenu(){
        $.ajax({
            url: path + "/manager/getAllCategorys?r=" + Math.random(),
            type: 'POST',
            dataType: "json",
            success: function (data) {
                if (data && data.success) {
                    categoryList = data.list;
                    var ieVersion = IEVersion();
                    var convertElement;
                    if (ieVersion == -1) {
                        console.log("非ie")
                        // convertElement = convert(categoryList);
                    } else {
                        console.log("ie")
                    }
                    convertElement = convertIE(categoryList);
                    var replaceAll = JSON.stringify(convertElement).replace(/name/g,"title");
                    // //页面显示需要，需提供数组类型参数
                    layui.use('tree', function () {
                        var tree = layui.tree;
                        var inst1 = tree.render({
                            elem: '#test1',
                            data: eval(replaceAll),
                            click: function (obj) {
                                if (!obj.data.children) {
                                    changeMenuPage(obj.data.id);
                                }
                            }
                        })
                    });
                }
            }
        })
    }



    // function resoleData() {
    //     return new Promise(function (resolve) {
    //         $.ajax({
    //             url: path + "/manager/getAllCategorys?r=" + Math.random(),
    //             type: 'POST',
    //             dataType: "json",
    //             success: function (data) {
    //                 if (data && data.success) {
    //                     categoryList = data.list;
    //                     var ieVersion = IEVersion();
    //                     var convertElement;
    //                     if (ieVersion == -1) {
    //                         console.log("非ie")
    //                         // convertElement = convert(categoryList);
    //                     } else {
    //                         console.log("ie")
    //                     }
    //                     convertElement = convertIE(categoryList);
    //
    //                     //转换成json字符串，然后替换数据库字段name为title
    //                     // let replaceAll = JSON.stringify(convertElement).replaceAll("name", "title");
    //                     var replaceAll = JSON.stringify(convertElement).replace(/name/g,"title");
    //                     console.log(replaceAll);
    //                     //页面显示需要，需提供数组类型参数
    //                     resolve(eval(replaceAll));
    //                 }
    //             }
    //         })
    //     }).then(function (data) {
    //         layui.use('tree', function () {
    //             var tree = layui.tree;
    //             var inst1 = tree.render({
    //                 elem: '#test1',
    //                 data: data,
    //                 click: function (obj) {
    //                     if (!obj.data.children) {
    //                         changeMenuPage(obj.data.id);
    //                     }
    //                 }
    //             })
    //         });
    //     })
    // }
    //



    // function convert(list) {
    //     const res = [];
    //     const map = list.reduce((res, v) => (res[v.id] = v, res), {})
    //     for (const item of list) {
    //         if (item.parentId === -1) {
    //             res.push(item);
    //             continue
    //         }
    //         if (item.parentId in map) {
    //             const parent = map[item.parentId];
    //             parent.children = parent.children || []
    //             parent.children.push(item)
    //         }
    //     }
    //     return res
    // }

    //适配ie
    function convertIE(list) {
        var res = [];
        // const map = list.reduce((res, v) => (res[v.id] = v, res), {})
        var map = {};
        for (var i = 0; i < list.length; i++) {
            map[list[i].id]= list[i];
        }
        for (var i = 0; i < list.length; i++) {
            if (list[i].parentId === -1) {
                res.push(list[i]);
                continue
            }

            if(typeof map[list[i].parentId] !="undefined" || map[list[i].parentId] != null){
                var parent = map[list[i].parentId];
                parent.children = parent.children || [];
                parent.children.push(list[i])
            }
            // if (list[i].parentId in map) {
            //     const parent = map[list[i].parentId]
            //     parent.children = parent.children || []
            //     parent.children.push(list[i])
            // }
        }
        return res
    }

    function IEVersion() {
        var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
        var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1; //判断是否IE<11浏览器
        var isEdge = userAgent.indexOf("Edge") > -1 && !isIE; //判断是否IE的Edge浏览器
        var isIE11 = userAgent.indexOf('Trident') > -1 && userAgent.indexOf("rv:11.0") > -1;
        if (isIE) {
            var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
            reIE.test(userAgent);
            var fIEVersion = parseFloat(RegExp["$1"]);
            if (fIEVersion == 7) {
                return 7;
            } else if (fIEVersion == 8) {
                return 8;
            } else if (fIEVersion == 9) {
                return 9;
            } else if (fIEVersion == 10) {
                return 10;
            } else {
                return 6;//IE版本<=7
            }
        } else if (isEdge) {
            return 'edge';//edge
        } else if (isIE11) {
            return 11; //IE11
        } else {
            return -1;//不是ie浏览器
        }
    }


    function changeMenuPage(currentId) {
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