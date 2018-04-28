<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>导出Excel</title>
<script type="text/javascript">
</script>
</head>
<body>
<h2>欢迎导出Excel！</h2><br/>

<h4>首页</h4><br/>
<form action="${context}/goGenExcel.action" method="post">
<table>
	<tr><td>数据库地址</td><td><input type="text" name="dbUrl"/></td></tr>
	<tr><td>用户名</td><td><input type="text" name="username"/></td></tr>
	<tr><td>密码</td><td><input type="text" name="password"/></td></tr>
</table>
<input type="submit" value="下一步"/>
</form>
</body>
</html>
