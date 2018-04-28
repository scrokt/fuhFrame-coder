<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Redis查询</title>
<script type="text/javascript" src="${path }/html/jquery-1.12.0.min.js"></script>
<script type="text/javascript">
function search(){
	var table = $("#table").val();
	var key = $("#key").val();
	var start = $("#start").val();
	var end = $("#end").val();
	$("#content").html('');
	$.getJSON("${path}/doRedisSearch.action?table="+table+"&key="+key
			+"&start="+start+"&end="+end,
			function(data){
				if(data.code=='0'){
					$("#content").html(data.message);
				}else if(data.code=='1'){
					for(var i=0;i<data.data.length;i++){
						$("#content").append(data.data[i]+"<br/>");
					}
					start=end;
					end+=100;
				}else{
					$("#content").html(data.data);
				}
			});
}
</script>
</head>
<body>
<h2>欢迎使用Redis查询！</h2><br/>

<div>
	<input id="table" type="text" name="table" placeholder="redis表"/>
	<input id="key" type="text" name="key" placeholder="key"/>
	<input id="start" type="text" name="start" placeholder="start" value="0"/>
	<input id="end" type="text" name="end" placeholder="end" value="100"/>
	<input type="button" onclick="search()" value="查询"/>
</div>
<div id="content" style="margin-top: 20px;">


</div>
</body>
</html>
