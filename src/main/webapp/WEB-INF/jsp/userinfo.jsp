<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta content="" name="description" />
	<meta content="webthemez" name="author" />
	<title>个人信息维护</title>
	<jsp:include page="/part/manager.css.jsp"></jsp:include>
</head>
<body>
<div id="wrapper">
	<!--头部：页面标题栏-->
	<jsp:include page="/part/manager.header.jsp"></jsp:include>
	<!--导航栏：页面菜单栏-->
	<jsp:include page="/part/manager.menu.jsp"></jsp:include>
	<!--表格-->
	<div id="page-wrapper">
		<div id="page-inner">
			<div class="row">
				<div class="col-md-12">
					<!-- 表格格式：面板中嵌套表格 -->
					<div class="panel panel-default">
						<!-- 面板头放：页面标题，刷新按钮，添加按钮 -->
						<div class="panel-heading">
							<font size="4">个人信息</font> <a
								href="<%=basePath%>getuserinfo.html"> <span
								class="glyphicon glyphicon-repeat"></span>
						</a>
							<span style="float: right">
									<button type="button" class="btn btn-default btn-sm"
											data-toggle="modal" data-target="#myModal">
										<span class="glyphicon glyphicon-plane"></span> 修改密码
									</button>
								</span>
						</div>
						<form action="<%=basePath%>updateusermessage.html" id="userinfo"method="post" class="form-horizontal">
							<div class="container">
								<input type="hidden" name="userId" value="${user.userId}">
								<div class="row form-group">
									<label class="control-label col-lg-1" >姓名</label>
									<div class="col-lg-5 col-md-6">
										<label class="control-label col-lg-1" >${user.userName}</label>
									</div>
								</div>
								<div class="row form-group">
									<label class="control-label col-lg-1" >性别</label>
									<div class="col-lg-5 col-md-6">
												<select id="sex" name="sex"  class="form-control">
													<option value="f">f</option>
													<option>m</option>
												</select>
									</div>
								</div>
								<div class="row form-group">
									<label class="control-label col-lg-1" >年龄</label>
									<div class="col-lg-5 col-md-6">
										<input class="form-control" value="${user.age}" datatype="/^[0-9]$|^1[0-9]$|^[2-9]\d$|^1\d{2}$/" errormsg="年龄为1-200之间！" name="age" id="age" type="text">
									</div>
								</div>
								<div class="row form-group">
									<label class="control-label col-lg-1" >电话</label>
									<div class="col-lg-5 col-md-6">
										<input class="form-control" value="${user.phoneNumber}" datatype="m" errormsg="请输入正确的电话号码！" name="phoneNumber" id="phoneNumber"type="text">
									</div>
								</div>
								<div class="row form-group">
									<label class="control-label col-lg-1">备注</label>
									<input type="hidden" name="comments" id="comments" >
									<div class="col-lg-5 col-md-6">
										<textarea class="form-control" rows="5"  id="commentstext" name="commentstext">${user.comments}</textarea>
									</div>
								</div>
								<button type="submit" class="btn btn-primary" id="updateinfo" style="margin-left: 180px;margin-right: 200px">提交</button>
								<button type="button" onclick="getuserinfo()" class="btn btn-default">重置</button>
							</div>
						</form>


						<!--End dataTables -->
						<!-- 按钮触发模态框 -->
						<!-- 模态框（Modal） myModal-->
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
							 aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">×</button>
										<!-- 表单嵌套表格：规范表单格式 -->
										<form action="<%=basePath%>updatepassword.html" method="post" role="form" id="myform">
											<div class="form-group">
												<table class="table" >
													<thead>

													<tr>
														<th>修改密码：<input type="hidden" name="userId" value="${user.userId}"></th>
														<th></th>
													</tr>
													</thead>
													<tbody>
													<tr>
														<td><b>密码:</b></td>
														<td><input type="password" id="password" datatype="*" nullmsg="密码不能为空！" name="password" class="form-control"/></td>
													</tr>
													<tr>
														<td><b>确认密码:</b></td>
														<td><input type="password" id="conpassword" datatype="*" recheck="password" nullmsg="确认密码不能为空！" errormsg="您两次输入的账号密码不一致！" name="conpassword" class="form-control"/></td>
													</tr>

													</tbody>
												</table>
												<div class="modal-footer">
													<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
													<input type="submit" id="updatepassword"value="提交" class="btn btn-primary">
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
							<!-- /.modal-dialog -->
						</div>
						<!-- /.modal -->
				<div>
			</div>
		</div>
	</div>

</div>
<jsp:include page="/part/manager.js.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function getuserinfo() {
        location.href = "${pageContext.request.contextPath}/getuserinfo.html";
    }
    var msg = '${msg}';
    if(msg!=""&&msg!=undefined){
        alert(msg);
    }
    $("#userinfo").Validform({
        btnSubmit: "#updateinfo",
        tiptype:function(msg,o,cssctl){
            if(o.type==3){
                alert(msg);
			}

        },
        beforeSubmit:function(curform){
            addtocomments();
        },
        tipSweep:true
    });
    $("#myform").Validform({
        btnSubmit: "#updatepassword",
        tiptype:function(msg,o,cssctl){
            if(o.type==3){
                alert(msg);
            }

        },
        tipSweep:true
    });
    function addtocomments() {
		$("#comments").val($("#commentstext").val());
    }
</script>
</html>