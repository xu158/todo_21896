<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<title>代办事项</title>
<jsp:include page="/part/manager.css.jsp"></jsp:include>
<script type="text/javascript">
    var msg = '${msg}';
    if(msg!=""&&msg!=undefined){
        alert(msg);
    }
	function model(obj,flag){
		if(flag == 1){
			//insert
			$("#myform")[0].reset();
			$("#myform").attr("action","${pageContext.request.contextPath}/addtodoitem.html");
		}else{
			//modify
			var curTr = $(obj).parent().parent();
			var tds = curTr.find("td");
			$("#todoItemId").val(tds[0].innerText);
			$("#todoItemTitle").val(tds[1].innerText);
			$("#todoItemContent").val(tds[2].innerText);
			$("#priority").val(tds[3].innerText);
			$("#myform").attr("action","${pageContext.request.contextPath}/modifyToDoItem.html");
		}
	}
	
	function deleteGoods(id){
		if(confirm("你确定要删除事项"+id+"吗？")){
			location.href = "${pageContext.request.contextPath}/deletetodoitem.html?id="+id;
		}
	}
</script>
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
                        <h1>测试Jenkins</h1>
						<!-- start dataTables -->
						<!-- 表格格式：面板中嵌套表格 -->
						<div class="panel panel-default">
							<!-- 面板头放：页面标题，刷新按钮，添加按钮 -->
							<div class="panel-heading">
								<font size="4">待办事项管理</font> <a
									href="<%=basePath%>selectalltodoitem.html"> <span
									class="glyphicon glyphicon-repeat"></span>
								</a>
								<span style="float: right">
									<button type="button" class="btn btn-default btn-sm"
										data-toggle="modal" data-target="#myModal" onclick="model(this,1)">
										<span class="glyphicon glyphicon-plane"></span> 添加待办事项
									</button>
								</span>
							</div>
							<!-- 面板体放：表格内容，按照dataTable格式来构造-->
							<div class="panel-body">
								<div class="table-responsive">
									<table class="table table-striped table-bordered table-hover"
										id="dataTables-example">
										<thead>
											<tr>
												<th>序号</th>
												<th>标题</th>
												<th>内容</th>
												<th>优先级</th>
												<th>创建时间</th>
												<th>修改时间</th>
												<th>编辑</th>
												<th>删除</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${not empty toDoItemList }">
												<c:forEach items="${toDoItemList }" var="item" varStatus="status">
													<tr>
														<td>${item.todoItemId }</td>
														<td>${item.todoItemTitle }</td>
														<td>${item.todoItemContent }</td>
														<td>${item.priority }</td>
														<td><fmt:formatDate value="${item.creationDate }" pattern="yyyy-MM-dd HH:mm"/></td>
														<td><fmt:formatDate value="${item.lastUpdateDate }" pattern="yyyy-MM-dd HH:mm"/></td>
														<td>
															<a data-toggle="modal" data-target="#myModal" onclick="model(this,2)">
																<span class="glyphicon glyphicon-edit"></span>
															</a>
														</td>
														<td>
															<a onclick="deleteGoods('${item.todoItemId }')">
																<span class="glyphicon glyphicon-remove"></span>
															</a>
														</td>
													</tr>
												</c:forEach>
											</c:if>
										</tbody>
									</table>
								</div>
							</div>
						</div>
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
										<form action="" method="post" role="form" id="myform">
											<div class="form-group">
												<table class="table" >
													<thead>
														<tr>
															<th>代办事项：<input type="hidden" id="todoItemId" name="todoItemId"></th>
															<th></th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><b>标题:</b></td>
															<td><input type="text" id="todoItemTitle" datatype="*" nullmsg="待办事项标题不能为空！"name="todoItemTitle" class="form-control"/></td>
														</tr>
														<tr>
															<td><b>内容:</b></td>
															<td><input type="text" id="todoItemContent" datatype="*" nullmsg="待办事项内容不能为空！"name="todoItemContent" class="form-control"/></td>
														</tr>
														<tr>
															<td><b>优先级：</b></td>
															<td>
																<select id="priority" name="priority" class="form-control">
																	<option value="low">low</option>
																	<option>medium</option>
																	<option>high</option>
																</select>
															</td>
														</tr>
													</tbody>
												</table>
												<div class="modal-footer">
													<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
													<input type="submit" id="todoitemsubmit" value="提交" class="btn btn-primary">
												</div>
											</div>
										</form>
									</div>
								</div>
							</div>
							<!-- /.modal-dialog -->
						</div>
						<!-- /.modal -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/part/manager.js.jsp"></jsp:include>
</body>
<script>
    $("#myform").Validform({
        btnSubmit: "#todoitemsubmit",
        tiptype:function(msg,o,cssctl){
            if(o.type==3){
                alert(msg);
            }

        },
        tipSweep:true
    });

</script>
</html>