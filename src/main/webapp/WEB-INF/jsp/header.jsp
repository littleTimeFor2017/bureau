<%@page contentType="text/html;charset=UTF-8"
        pageEncoding="UTF-8"
%>
<%@ include file="common.jsp" %>
<style type="text/css">
    .logo .logo_img {
        float: left;
        height: 159px;
        width: 100%;
        position: relative;
        z-index: 1;
    }

    .logo .logo_img img {
        height: 159px;
        width: 100%;
        background-repeat: no-repeat;
        margin-top: -14px;
    }

    .logo .logo_font {
        position: relative;
    }

    .logo .logo_font .title_font {
        position: absolute;
        width: 500px;
        height: 50px;
        font-weight: bold;
        font-size: 35px;
        font-family: "微软雅黑";
        color: #0a287e;
        margin-top: 45px;
        margin-left: 180px;
        z-index: 15;
        text-shadow: 1px 1px whitesmoke;
    }

    .logo .flexslider {
        height: 159px;
        width: 30%;
        position: absolute;
        z-index: 10;
        margin-left: 660px;
        overflow: hidden;

    }
    .navbar .nav > li > a:active {
        color: red;
    }
</style>

<script type="text/javascript">
    $(function () {
        $(".flexslider").flexslider({
            animation: 'fade',
            slideshowSpeed: 4000, //展示时间间隔ms
            animationSpeed: 400, //滚动时间ms
            touch: true //是否支持触屏滑动
        });
    });
    function getPhone(){
        // var url = encodeURI('http://10,25.1.22');
        var url = encodeURI('http://10.25.1.22');
        window.location.href=url;

    }
</script>

<!-- logo 开始 -->
<div class="logo" style="float:left">
    <%--//背景图--%>
    <div class="logo_img">
        <img src="/bureau/img/index/bg2.jpg"/>
    </div>
</div>
<!-- logo 结束 -->
<!-- banner 开始 -->
<div class="banner">
        <ul id="header_ul">
            <li class="right_border"><a id="li1" href="/bureau/index">首页</a></li>
            <li class="right_border"><a id="li2" href="/bureau/other?type=gzdt">交管要闻</a></li>
            <li class="right_border"><a id="li3" href="/bureau/other?type=tztb">通知通报</a></li>
            <li class="right_border"><a id="li4" href="/bureau/other?type=zxtb">秩序通报</a></li>
            <li class="right_border"><a id="li5" href="/bureau/other?type=zgdj">政工党建</a></li>
            <li class="right_border"><a id="li6" href="/bureau/other?type=mtyq">规范执法</a></li>
            <li class="right_border"><a id="li7" href="/bureau/other?type=zxzz">专项整治</a></li>
            <li class="right_border"><a id="li8" href="/bureau/other?type=bmgz">部门工作</a></li>
            <%--<li class="right_border"><a id="li9" href="https://www.baidu.com">电话查询</a></li>--%>
            <li class="right_border"><a id="li9"  onclick="getPhone()">电话查询</a></li>
            <li><a id="li10" href="/bureau/manager">管理后台</a></li>
        </ul>
</div>

<!-- banner 结束 -->