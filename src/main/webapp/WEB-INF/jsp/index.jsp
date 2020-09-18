<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
%>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <%@ include file="common.jsp" %>

    <title>正定县公安交警大队-首页</title>
    <style type="text/css">
        #header_img_div {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
            /*margin-top: 10px;*/
        }

        #header_img {
            width: 100%;
            height: auto;
        }
    </style>
    <script type="text/javascript" src="<%=path%>/js/lbt1.js"></script>
</head>
<body>
<div class="main">
    <div class="main_box" style="position: relative;z-index: 1;">
        <jsp:include page="header.jsp"></jsp:include>
        <div id="header_img_div">
            <img id="header_img" src="/bureau/img/ddzc_02.jpg">
        </div>
        <div class="news">
            <%--第一行--%>
            <div class="news_box1">
                <div class="news_lb">
                    <div id="playBox">
                        <div class="pre"></div>
                        <div class="next"></div>
                        <div class="smalltitle">
                            <ul>
                                <li class="thistitle"></li>
                                <li></li>
                                <li></li>
                            </ul>
                        </div>
                        <ul class="oUlplay">
                            <c:forEach var="obj" items="${imageList}">
                                <li>
                                    <a href="" target="_blank" class="thumbnail">
                                        <img src="/bureau/images/${obj.name}" style="width: 500px; height: 328px;">
                                            <%--<p>&lt;%&ndash;此处文字后续补上&ndash;%&gt;</p>--%></a></li>
                                </li>
                            </c:forEach>
                            <%--<li><a href="" target="_blank">--%>
                                <%--<img src="<%=path%>/img/img_change/ic10.jpg" style="width: 500px; height: 328px;">--%>
                                <%--&lt;%&ndash;<p>&lt;%&ndash;此处文字后续补上&ndash;%&gt;</p>&ndash;%&gt;</a></li>--%>
                            <%--<li><a href="" target="_blank">--%>
                                <%--<img src="<%=path%>/img/img_change/ic9.jpg" style="width: 500px; height: 328px">--%>
                                <%--&lt;%&ndash;<p></p>&ndash;%&gt;</a></li>--%>
                            <%--<li><a href="" target="_blank">--%>
                                <%--<img src="<%=path%>/img/img_change/ic11.jpg" style="width: 500px;height: 328px">--%>
                                <%--&lt;%&ndash;<p></p>&ndash;%&gt;</a></li>--%>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="news_box2">
                <div class="news_jfxw_title">
                    <font>交管要闻</font><span><a href="javascript:getMore('gzdt')">更多</a></span>
                    <%--<a href="<%=path%>/index/advic">更多</a>--%>
                </div>
                <div class="news_jfxw_content">
                    <ul>
                        <c:forEach var="obj" items="${gzdtList}">
                            <li>
                                <a href="<%=path%>/articleDetail?id=${obj.id}">
                                    <img src="<%=path%>/img/index/news_list_ico.png">
                                    <div class="ellipsis">${obj.title}</div>
                                </a>
                                <span>${obj.createTimeStr}</span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <%--第二行 交警风采--%>
            <div class="news_box1" style="width: 100%;">
                <div class="dq_picture">
                    <div class="dq_picture_box">
                        <div class="yc_studio_slider">
                            <div id="slider">
                                <ul>
                                    <li><img src="<%=path%>/img/img_change/1.jpg" alt="" width="212" height="159"/><a
                                            target="_blank" href="" class="img_mark nodis">交警风采</a></li>
                                    <li><img src="<%=path%>/img/img_change/2.jpg" alt="" width="212" height="159"/><a
                                            target="_blank" href="" class="img_mark nodis">交警风采</a></li>
                                    <li><img src="<%=path%>/img/img_change/3.jpg" alt="" width="212" height="159"/><a
                                            target="_blank" href="" class="img_mark nodis">交警风采</a></li>
                                    <li><img src="<%=path%>/img/img_change/4.jpg" alt="" width="212" height="159"/><a
                                            target="_blank" href="" class="img_mark nodis">交警风采</a></li>
                                    <li><img src="<%=path%>/img/img_change/5.jpg" alt="" width="212" height="159"/><a
                                            target="_blank" href="" class="img_mark nodis">交警风采</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <script src="<%=path%>/js/jquery.sudoSlider.min.js"></script>
                    <script type="text/javascript">
                        $(document).ready(function () {
                            //头部选中
                            $("#li1").css("color", "red");
                            //页面加载完毕的时候从数据库中查询数据
                            //小图轮播
                            var sudoSlider = $("#slider").sudoSlider({
                                slideCount: 4,
                                continuous: true,
                                numeric: false,
                                prevNext: true,
                                continuous: true,
                                auto: true,
                                speed: 800,
                                pause: 3000,
                                prevHtml: '<a href="#" class="prevBtn"></a>',
                                nextHtml: '<a href="#" class="nextBtn"></a>'
                            });
                            $("#slider li").on("mouseenter", function () {
                                $(this).find(".img_mark").fadeIn(200).removeClass("nodis");
                            })
                            $("#slider li").on("mouseleave", function () {
                                $(this).find(".img_mark").fadeOut(200).addClass("nodis")
                            })
                        });
                    </script>
                </div>
            </div>
            <%--第三行--%>
            <div class="news_box4">
                <div class="news_tzgg_title">
                    <font>通知通报</font><span><a href="javascript:getMore('tztb')">更多</a></span><%--跳转到对应的页面去--%>
                </div>
                <div class="words11_zzgz_xfgz_content">
                    <div class="box">
                        <ul>
                            <c:forEach var="obj" items="${tztbList}">
                                <li>
                                    <a href="<%=path%>/articleDetail?id=${obj.id}&type=S">
                                        <img  src="<%=path%>/img/index/news_list_ico.png">
                                        <div>${obj.title}</div>
                                    </a>
                                    <span>${obj.createTimeStr}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="news_box5" style="margin-left: 15px;">
                <div class="news_tzgg_title">
                    <font>秩序通报</font><span><a href="javascript:getMore('zxtb')">更多</a></span><%--跳转到对应的页面去--%>
                </div>
                <div class="words11_zzgz_xfgz_content">
                    <div class="box">
                        <ul>
                            <c:forEach var="obj" items="${zxtbList}">
                                <li>
                                    <a href="<%=path%>/articleDetail?id=${obj.id}"><img
                                            src="<%=path%>/img/index/news_list_ico.png"> <div>${obj.title}</div>
                                    </a><span>${obj.createTimeStr}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="news_box3">
                <div style="width: 100%;height: auto;margin-top: 5px;">
                    <div align="center" style="margin-top: 85px;">
                    </div>
                </div>
                <table class="table table-striped table-hover" width="100%"
                       style=" margin-left: 10px;font-size: larger">
                    <c:forEach var="obj" items="${dueList}" varStatus="abc">
                        <c:if test="${abc.index <=5}">
                            <tr>
                                <td width="52%">
                                        ${obj.key}:
                                </td>
                                <td>
                                        ${obj.value}
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </div>
            <div class="ad">
                <img src="<%=path%>/img/ad/ad_blue.jpg"/>
            </div>
            <%--第四行--%>
            <div class="news_box4">
                <div class="news_tzgg_title">
                    <font>政工党建</font><span><a href="javascript:getMore('zgdj')">更多</a></span><%--跳转到对应的页面去--%>
                </div>
                <div class="words11_zzgz_xfgz_content">
                    <div class="box">
                        <ul>
                            <c:forEach var="obj" items="${zgdjList}">
                                <li>
                                    <a href="<%=path%>/articleDetail?id=${obj.id}"><img
                                            src="<%=path%>/img/index/news_list_ico.png"> <div class="ellipsis">${obj.title}</div>
                                    </a><span>${obj.createTimeStr}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="news_box5" style="margin-left: 15px;">
                <div class="news_tzgg_title">
                    <font>规范执法</font><span><a href="javascript:getMore('mtyq')">更多</a></span><%--跳转到对应的页面去--%>
                </div>
                <div class="words11_zzgz_xfgz_content">
                    <div class="box">
                        <ul>
                            <c:forEach var="obj" items="${mtyqList}">
                                <li>
                                    <a href="<%=path%>/articleDetail?id=${obj.id}"><img
                                            src="<%=path%>/img/index/news_list_ico.png"> <div class="ellipsis">${obj.title}</div>
                                    </a><span>${obj.createTimeStr}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="news_box6">
                <div style="width: 100%;height: auto;margin-top: 5px;">
                    <div align="center" style="margin-top: 55px;">
                    </div>
                </div>
                <table class="table table-striped table-hover" width="100%" style="font-size: 15">
                    <c:forEach var="obj" items="${dueList}" varStatus="abc">
                        <c:if test="${abc.index >5}">
                            <tr>
                                <td width="52%">
                                        ${obj.key}:
                                </td>
                                <td>
                                        ${obj.value}
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>
                </table>
            </div>
            <div class="ad">
                <img src="<%=path%>/img/ad/ad_02.jpg"/>
            </div>
            <%--第五行--%>
            <div class="news_box4">
                <div class="news_tzgg_title">
                    <font>专项整治</font><span><a href="javascript:getMore('zxzz')">更多</a></span><%--跳转到对应的页面去--%>
                </div>
                <div class="words11_zzgz_xfgz_content">
                    <div class="box">
                        <ul>
                            <c:forEach var="obj" items="${zxzzList}">
                                <li>
                                    <a href="<%=path%>/articleDetail?id=${obj.id}"><img
                                            src="<%=path%>/img/index/news_list_ico.png"> <div class="ellipsis">${obj.title}</div>
                                    </a><span>${obj.createTimeStr}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="news_box5" style="margin-left: 15px;">
                <div class="news_tzgg_title">
                    <font>部门工作</font><span><a href="javascript:getMore('bmgz')">更多</a></span><%--跳转到对应的页面去--%>
                </div>
                <div class="words11_zzgz_xfgz_content">
                    <div class="box">
                        <ul>
                            <c:forEach var="obj" items="${bmgzList}">
                                <li>
                                    <a href="<%=path%>/articleDetail?id=${obj.id}"><img
                                            src="<%=path%>/img/index/news_list_ico.png"> <div class="ellipsis">${obj.title}</div>
                                    </a><span>${obj.createTimeStr}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="news_box7">
                <div style="width: 100%;height: auto;margin-top: 5px;">
                    <div align="center" style="margin-top: 85px;">
                    </div>
                </div>

                <table width="100%" align="center" style="margin-left: 4px">
                    <c:forEach var="obj" items="${careList}">
                        <tr>
                            <td>
                                <span>${obj.content}</span>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
            <%--第六行 图片新闻--%>
            <div class="news_box1" style="width: 100%">
                <div class="news_tzgg_title">
                    <font>图片新闻</font><span><%--<a href="javascript:getMore('tpxw')">更多</a></span>--%><%--跳转到对应的页面去--%>
                </div>
                <div class="ttxw">
                    <div class="dq_picture_box">
                        <div id="bottom_slider">
                            <ul class="oUlplay">
                                <li><a target="_blank" href=""><img style="float: left; padding-right: 4.5px;"
                                                                    src="<%=path%>/img/img_change/ic10.jpg" alt=""
                                                                    width="190"
                                                                    height="137"/>
                                    <p>帮扶共建活动</p></a></li>
                                <li><a target="_blank" href=""><img style="float: left; padding-right: 4.5px;"
                                                                    src="<%=path%>/img/img_change/b2.jpg" alt=""
                                                                    width="236"
                                                                    height="137"/>
                                    <p>社会主义核心价值观宣传教育</p></a></li>
                                <li><a target="_blank" href=""><img style="float: left; padding-right: 4.5px;"
                                                                    src="<%=path%>/img/img_change/b3.jpg" alt=""
                                                                    width="236"
                                                                    height="137"/>
                                    <p>学雷锋志愿服务</p></a></li>
                                <li><a target="_blank" href=""><img style="float: left; padding-right: 4.5px;"
                                                                    src="<%=path%>/img/img_change/b4.jpg" alt=""
                                                                    width="236"
                                                                    height="137"/>
                                    <p>思想道德建设</p></a></li>
                                <li><a target="_blank" href=""><img style="float: left;"
                                                                    src="<%=path%>/img/img_change/b5.jpg" alt=""
                                                                    width="236"
                                                                    height="137"/>
                                    <p>创城工作推进部署</p></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- main 结束 -->
    <div style="height: 1px;width:100%;background-color: #0a287e;"></div>
    <jsp:include page="bottom.jsp"></jsp:include>
</div>
</body>
<script type="text/javascript">
    function getMore(type) {
        window.location.href = "/bureau/other?type=" + type;
    }

</script>

</html>