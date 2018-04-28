<%@ page language="java" pageEncoding="UTF-8"%>
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

<h4>首页</h4><br/>
<form action="${context}/goModelConfirm.action" method="post">
<table>
	<tr><td>基础包名</td><td><input type="text" name="basePackage"/></td></tr>
	<tr><td>模块名</td><td><input type="text" name="module"/></td></tr>
	<tr><td>模块中文名</td><td><input type="text" name="moduleName"/></td></tr>
	<tr><td>数据库地址</td><td><input type="text" name="dbUrl"/></td></tr>
	<tr><td>用户名</td><td><input type="text" name="username"/></td></tr>
	<tr><td>密码</td><td><input type="text" name="password"/></td></tr>
	<tr><td>表名</td><td><input type="text" name="table"/></td></tr>
	<tr><td>分库</td><td>
		<select name="db">
			<option value="DEFAULT_DS">DEFAULT_DS</option>
			<option value="ELEFENCE_DS">ELEFENCE_DS</option>
			<option value="PICKDATA_DS">PICKDATA_DS</option>
			<option value="TM_DS">TM_DS</option>
			<option value="BR_DS">BR_DS</option>
			<option value="IDENTITY_DS">IDENTITY_DS</option>
		</select></td></tr>
</table>
<input type="submit" value="下一步"/>
</form>
</body>
</html>
