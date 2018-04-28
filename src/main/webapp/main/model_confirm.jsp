<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>RT代码生成工具</title>
<script type="text/javascript">
</script>
</head>
<body>
<h2>欢迎使用RT代码生成工具V1.0！</h2><br/>

<h4>确认</h4><br/>
<form action="${context}/goGenResult.action" method="post"><input type="hidden" name="db" value="${model.db}"/>
<table>
	<tr><td>基础包名</td><td><input type="text" name="basePackage" value="${model.basePackage}"/></td></tr>
	<tr><td>模块名</td><td><input type="text" name="moduleName" value="${model.moduleName}"/></td></tr>
	<tr><td>模块中文名</td><td><input type="text" name="moduleCnName" value="${model.moduleCnName}"/></td></tr>
	<tr><td>表名</td><td><input type="text" name="tableName" value="${model.tableName}"/></td></tr>
	
	<tr><td>注释：projectName</td><td><input type="text" name="projectName" value="${model.projectName}"/></td></tr>
	<tr><td>注释：author</td><td><input type="text" name="author" value="${model.author}"/></td></tr>
	<tr><td>注释：version</td><td><input type="text" name="version" value="${model.version}"/></td></tr>
</table>
<table  cellspacing="0">
	<tr><th>名称</th><th>类型</th><th>列</th><th>MybatisJdbc类型</th><th>中文名</th><th>是否允许空</th><th>是否主键</th><th>是否查询</th><th>查询表达式</th><th>列表是否显示</th><th>列表显示宽度</th><th>表单是否编辑</th></tr>
<c:forEach items="${model.properties }" var="property"  varStatus="status">
	<input type="hidden" name="properties[${status.index }].dataType" value="${property.dataType }"/>
	<input type="hidden" name="properties[${status.index }].dataLength" value="${property.dataLength }"/>
	<tr>
		<td><input type="text" name="properties[${status.index }].name" value="${property.name }"/></td>
		<td><input type="text" name="properties[${status.index }].simpleType" value="${property.simpleType }"/></td>
		<td><input type="text" name="properties[${status.index }].column" value="${property.column }"/></td>
		<td><input type="text" name="properties[${status.index }].jdbcType" value="${property.jdbcType }"/></td>
		<td><input type="text" name="properties[${status.index }].cnName" value="${property.cnName }"/></td>
		<td><input type="text" name="properties[${status.index }].nullAble" value="${property.nullAble }"/></td>
		<td><input type="text" name="properties[${status.index }].id" value="${property.id }"/></td>
		<td><input type="text" name="properties[${status.index }].search" value="false"/></td>
		<td><input type="text" name="properties[${status.index }].searchExpr" value="="/></td>
		<td><input type="text" name="properties[${status.index }].show" value="true"/></td>
		<td><input type="text" name="properties[${status.index }].width" value="10"/></td>
		<td><input type="text" name="properties[${status.index }].edit" value="true"/></td>
	</tr>
</c:forEach>
</table>
<input type="submit" value="下一步"/>
</form>

</body>
</html>
