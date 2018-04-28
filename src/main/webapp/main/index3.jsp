<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Redis查询</title>
<script type="text/javascript">
</script>
</head>
<body>
<h2>欢迎使用Redis查询！</h2><br/>

<h4>首页</h4><br/>
<form action="${context}/goRedis.action" method="post">
<table>
	<tr><td>Reids地址</td><td><input type="text" name="ip"/></td></tr>
	<tr><td>端口</td><td><input type="text" name="port"/></td></tr>
</table>
<input type="submit" value="下一步"/>
</form>
</body>
</html>
