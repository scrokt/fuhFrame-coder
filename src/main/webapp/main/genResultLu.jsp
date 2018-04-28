<%@ page language="java" pageEncoding="UTF-8"%>
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

	<div class="layui-main" style="margin-top: 15px;">
	<blockquote class="layui-elem-quote">
		${message}。
		<a class="layui-btn" href="${context}/doDownloadZip.action?id=${id}" target="_blank">下载</a>
		<a class="layui-btn layui-btn-primary" href="${context}/goIndexLu.action">返回首页</a>
	</blockquote> 
		
	</div>
</body>
</html>
