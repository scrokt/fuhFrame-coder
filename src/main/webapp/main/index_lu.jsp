<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>RT代码生成工具</title>
<link rel="stylesheet" href="${context }/layui/css/layui.css">
</head>
<body>
	<ul class="layui-nav">
		<li class="layui-nav-item"><a href="">RT代码生成工具</a></li>
	</ul>
	<div class="layui-container " style="margin-top: 15px;">
		<div class="layui-row">
			<div class="layui-col-md4">
				<div>&nbsp;</div>
			</div>
			<div class="layui-col-md4">
				<form class="layui-form layui-form-pane" action="${context }/goModelConfirmLu.action" method="post">
					<div class="layui-form-item">
						<label class="layui-form-label">基础包名</label>
						<div class="layui-input-block">
							<input type="text" name="basePackage" lay-verify="required"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">模块名</label>
						<div class="layui-input-block">
							<input type="text" name="module" lay-verify="required"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">模块中文名</label>
						<div class="layui-input-block">
							<input type="text" name="moduleName" lay-verify="required"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">数据库地址</label>
						<div class="layui-input-block">
							<input type="text" name="dbUrl" lay-verify="required"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">用户名</label>
						<div class="layui-input-block">
							<input type="text" name="username" lay-verify="required"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">密码</label>
						<div class="layui-input-block">
							<input type="text" name="password" lay-verify="required"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">表名</label>
						<div class="layui-input-block">
							<input type="text" name="table" lay-verify="required"
								placeholder="请输入" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">分库</label>
						<div class="layui-input-block">
							<select name="db">
								<option value="DEFAULT_DS">DEFAULT_DS</option>
								<option value="ELEFENCE_DS">ELEFENCE_DS</option>
								<option value="PICKDATA_DS">PICKDATA_DS</option>
								<option value="TM_DS">TM_DS</option>
								<option value="BR_DS">BR_DS</option>
								<option value="IDENTITY_DS">IDENTITY_DS</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-input-block">
							<button class="layui-btn" lay-submit="" lay-filter="demo2">
								下一步<i class="layui-icon">&#xe65b;</i>
							</button>
						</div>
					</div>
				</form>
			</div>
			<div class="layui-col-md4">
				<div>&nbsp;</div>
			</div>
		</div>
	</div>
	<!-- 你的HTML代码 -->

	<script src="${context }/layui/layui.js"></script>
	<script>
		//一般直接写在一个js文件中
		layui.use([ 'layer', 'form' ], function() {
			var layer = layui.layer, form = layui.form;
			//layer.msg('Hello World');
		});
	</script>
</body>
</html>