<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<body>
	<!--导航栏class="active-menu-->
	<nav class="navbar-default navbar-side" role="navigation">
		<div class="sidebar-collapse">
			<ul class="nav" id="main-menu">
				<li><a href="<%=basePath%>selectalltodoitem.html"> <i
						class="fa fa-desktop"></i>代办事项列表
				</a></li>
				<li><a href="<%=basePath%>getuserinfo.html"> <i
						class="fa fa-table"></i>个人信息维护
				</a></li>
			</ul>
		</div>
	</nav>
</body>
</html>
