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

<h4>生成结果</h4><br/>
表总数：${tableCount }，缺失备注数：${tableNoCommentCount }<br/>
字段总数：${propertyCount }，缺失备注数：${propertyNoCommentCount }<br/>
${message} <a href="${context}/doDownloadExcel.action?id=${id}" target="_blank">下载</a><br/><br/>

<a href="${context}/goIndex2.action">返回首页</a>
</body>
</html>
