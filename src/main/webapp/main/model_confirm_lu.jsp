<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>RT代码生成工具</title>
<link rel="stylesheet" href="${context }/layui/css/layui.css">
<style type="text/css">
.layui-table input {
	border: 0;
	height: 38px;
	margin: -9px -15px;
	width: 106px;
}
</style>
</head>
<body>
	<ul class="layui-nav">
		<li class="layui-nav-item"><a href="">RT代码生成工具</a></li>
	</ul>
	<form class="layui-form layui-form-pane"
		action="${context }/goGenResultLu.action" method="post"
		style="margin-top: 15px;">
		<input type="hidden" name="db" value="${model.db}"/>
		<ul class="layui-timeline">
			<li class="layui-timeline-item layui-row"><i
				class="layui-icon layui-timeline-axis"></i>
				<div class="layui-timeline-content layui-text layui-col-md4">
					<h3 class="layui-timeline-title">基础配置</h3>
					<div class="layui-form-item">
						<label class="layui-form-label">基础包名</label>
						<div class="layui-input-block">
							<input type="text" name="basePackage" lay-verify="required"
								value="${model.basePackage}" placeholder="请输入"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">模块名</label>
						<div class="layui-input-block">
							<input type="text" name="moduleName" lay-verify="required"
								value="${model.moduleName}" placeholder="请输入" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">模块中文名</label>
						<div class="layui-input-block">
							<input type="text" name="moduleCnName" lay-verify="required"
								value="${model.moduleCnName}" placeholder="请输入"
								autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">表名</label>
						<div class="layui-input-block">
							<input type="text" name="tableName" lay-verify="required"
								value="${model.tableName}" placeholder="请输入" autocomplete="off"
								class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label" title="注释：projectName">注释：projectName</label>
						<div class="layui-input-block">
							<select name="sub" >
								<option value="spring">spring</option>
								<option value="layui">layui</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label" title="注释：projectName">注释：projectName</label>
						<div class="layui-input-block">
							<input type="text" name="projectName" lay-verify="required"
								placeholder="请输入" autocomplete="off" class="layui-input"/>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label" title="注释：author">注释：author</label>
						<div class="layui-input-block">
							<input type="text" name="author" lay-verify="required"
								placeholder="请输入" autocomplete="off" class="layui-input"/>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label" title="注释：version">注释：version</label>
						<div class="layui-input-block">
							<input type="text" name="version" lay-verify="required"
								placeholder="请输入" autocomplete="off" class="layui-input"/>
						</div>
					</div>
				</div></li>
			<li class="layui-timeline-item"><i
				class="layui-icon layui-timeline-axis"></i>
				<div class="layui-timeline-content layui-text">
					<h3 class="layui-timeline-title">字段配置</h3>
					<table class="layui-table" lay-even="">
						<thead>
							<tr>
								<th width="80px">名称</th>
								<th width="80px">类型</th>
								<th width="80px">列</th>
								<th width="80px">Jdbc类型</th>
								<th width="80px">中文名</th>
								<th width="80px">是否允许空</th>
								<th width="80px">是否主键</th>
								<th width="80px">是否查询</th>
								<th width="80px">查询表达式</th>
								<th width="80px">列表是否显示</th>
								<th width="80px">列表显示宽度</th>
								<th width="80px">表单是否编辑</th>
								<th></th>
							</tr>
						</thead>
						<c:forEach items="${model.properties }" var="property"
							varStatus="status">
							<input type="hidden" name="properties[${status.index }].dataType"
								value="${property.dataType }" />
							<input type="hidden"
								name="properties[${status.index }].dataLength"
								value="${property.dataLength }" />
							<tr>
								<td><input type="text" class="a"
									name="properties[${status.index }].name"
									value="${property.name }" /></td>
								<td><input type="text"
									name="properties[${status.index }].simpleType"
									value="${property.simpleType }" /></td>
								<td><input type="text"
									name="properties[${status.index }].column"
									value="${property.column }" /></td>
								<td><input type="text"
									name="properties[${status.index }].jdbcType"
									value="${property.jdbcType }" /></td>
								<td><input type="text"
									name="properties[${status.index }].cnName"
									value="${property.cnName }" /></td>
								<td><input type="text"
									name="properties[${status.index }].nullAble"
									value="${property.nullAble }" /></td>
								<td><input type="text"
									name="properties[${status.index }].id" value="${property.id }" /></td>
								<td><input type="text"
									name="properties[${status.index }].search" value="false" /></td>
								<td><input type="text"
									name="properties[${status.index }].searchExpr" value="=" /></td>
								<td><input type="text"
									name="properties[${status.index }].show" value="true" /></td>
								<td><input type="text"
									name="properties[${status.index }].width" value="10" /></td>
								<td><input type="text"
									name="properties[${status.index }].edit" value="true" /></td>
							</tr>
						</c:forEach>
					</table>
				</div></li>
			<li class="layui-timeline-item"><i
				class="layui-icon layui-timeline-axis"></i>
				<div class="layui-timeline-content layui-text">
					
						<button class="layui-btn" lay-submit lay-filter="next">
							下一步<i class="layui-icon">&#xe65b;</i>
						</button>
					
				</div></li>
		</ul>
	</form>

	<!-- 你的HTML代码 -->

	<script src="${context }/layui/layui.js"></script>
	<script>
		//一般直接写在一个js文件中
		layui.use([ 'layer', 'form', 'element', 'table' ], function() {
			var layer = layui.layer, form = layui.form;
			var element = layui.element;
			var table = layui.table;
			//layer.msg('Hello World');
		});
	</script>
</body>
</html>