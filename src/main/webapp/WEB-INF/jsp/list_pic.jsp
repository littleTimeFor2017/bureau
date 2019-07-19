<%@page contentType="text/html;charset=UTF-8"
		pageEncoding="UTF-8"
%>
<html lang="zh-CN">

<head>
	<meta charset="utf-8">
	<%@ include file="common.jsp" %>
	<title>工作动态</title>
	<script type="text/javascript">
        $(function () {
			$("#li2").css("color","red");
		});
	</script>
</head>
	<body>
	<div class="top">
		<jsp:include page="top.jsp"></jsp:include>
	</div>
		<!-- main 开始 -->
		<div class="main">
			<div class="main_box">
				<jsp:include page="header.jsp"></jsp:include>
				<!-- banner 结束 -->
				<div class="address">
					<img src="/bureau/img/address_ico.png"/>
					<a href="javascript:void(0);">首页</a>
					<%--<a>：</a><a href="javascript:void(0);">警务快讯</a>--%>
					<%--<a>&gt;</a>--%>
					<%--<a href="javascript:void(0);">警务快讯</a>--%>
					<%--<a>&gt;</a>--%>
					<%--<a href="javascript:void(0);">局内要闻</a>--%>
				</div>
				<!-- address 结束 -->

				<!-- list_main 开始 -->
				<div class="list_main">
					<!-- hot 开始 -->
					<%--<div class="hot">--%>
						<%--<div class="hot_title">--%>
							<%--警务快讯--%>
						<%--</div>--%>
						<%--<div class="hot_content">--%>
							<%--<div class="hot_content_box">--%>
								<%--<div class="hot_content_box_title">--%>
									<%--<img src="/bureau/img/hot_list_ico.png" />警务快讯--%>
								<%--</div>--%>
								<%--<div class="hot_content_box_content">--%>
									<%--<ul>--%>
										<%--<li><a href="#">局内要闻</a></li>--%>
										<%--<li><a href="#">会议活动</a></li>--%>
										<%--<li><a href="#">领导讲话</a></li>--%>
									<%--</ul>--%>
								<%--</div>--%>
							<%--</div>--%>
							<%--<div class="hot_content_box">--%>
								<%--<div class="hot_content_box_title">--%>
									<%--<img src="/bureau/img/hot_list_ico.png" />和谐警营建设专栏--%>
								<%--</div>--%>
								<%--<div class="hot_content_box_content">--%>
									<%--<ul>--%>
										<%--<li><a href="#">上级来文</a></li>--%>
										<%--<li><a href="#">和谐警营建设专刊</a></li>--%>
										<%--<li><a href="#">经验交流</a></li>--%>
									<%--</ul>--%>
								<%--</div>--%>
							<%--</div>--%>
							<%--<div class="hot_content_box">--%>
								<%--<div class="hot_content_box_title">--%>
									<%--<img src="/bureau/img/hot_list_ico.png" />援疆特刊--%>
								<%--</div>--%>
								<%--<div class="hot_content_box_content">--%>
									<%--<ul>--%>
										<%--<li><a href="#">援疆快讯</a></li>--%>
										<%--<li><a href="#">民警心声</a></li>--%>
										<%--<li><a href="#">突出战绩</a></li>--%>
										<%--<li><a href="#">后方支援</a></li>--%>
									<%--</ul>--%>
								<%--</div>--%>
							<%--</div>--%>
						<%--</div>--%>
					<%--</div>--%>
					<!-- hot 结束 -->
					<!-- list_con 开始 -->
					<div class="list_pic_con">
						<div class="list_pic_con_title">
							<font>工作动态</font>
						</div>
						<div class="list_pic_con_content">
							<ul>
								<li>
									<img src="/bureau/img/list_wz/pic_list_PIC1.png">
									<p class="title"><a href="content.html">五年后我市力争成为制造业强市</a></p>
									<p class="time">时间：2015-06-05</p>
									<p class="con">除了各大网站也是进大网大网站也是牛，肉战略要地站也是口牛高端战略要地,除了各大网站也是进大网大网站也是牛肉战略要地站也是口牛高端战略要地,除了各大网站也是进大网大网站…<a href="content.html">【查看全文】</a></p>
									</p>
								</li>
								<li>
									<img src="/bureau/img/list_wz/pic_list_PIC2.png">
									<p class="title"><a href="content.html">上官吉庆在陕西代表团媒体开放日上回答媒体提问</a></p>
									<p class="time">时间：2015-06-05</p>
									<p class="con">除了各大网站也是进大网大网站也是牛，肉战略要地站也是口牛高端战略要地,除了各大网站也是进大网大网站也是牛肉战略要地站也是口牛高端战略要地,除了各大网站也是进大网大网站…<a href="content.html">【查看全文】</a></p>
									</p>
								</li>
								<li>
									<img src="/bureau/img/list_wz/pic_list_PIC3.png">
									<p class="title"><a href="#">我市全面排查物业管理 项目特种设备安全隐患</a></p>
									<p class="time">时间：2015-06-05</p>
									<p class="con">除了各大网站也是进大网大网站也是牛，肉战略要地站也是口牛高端战略要地,除了各大网站也是进大网大网站也是牛肉战略要地站也是口牛高端战略要地,除了各大网站也是进大网大网站…<a href="#">【查看全文】</a></p>
									</p>
								</li>
							</ul>
							<div class="page">
								<ul>
									<li class="border_3">共195条</li>
									<li class="border_3">共50页</li>
									<li class="border_3"><a href="">首页</a></li>
									<li class="border_3"><a href="">《</a></li>
									<li class="border_3 active"><a href="">1</a></li>
									<li class="border_3"><a href="">2</a></li>
									<li class="border_3"><a href="">3</a></li>
									<li class="border_3"><a href="">末页</a></li>
									<li class="border_3"><a href="">》</a></li>
									<li class="border_3" style="margin-right: -5px; padding: 1px;"><input class="text" type="text" value="1"></li>
									<li class="border_4"><a href="">跳转</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			<jsp:include page="bottom.jsp"></jsp:include>
			</div>
		</div>
		<!-- main 结束 -->

	</body>

</html>