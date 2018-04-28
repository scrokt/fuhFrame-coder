<%@page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${r'${path}'}/layui/css/layui.css">
</head>

<body>
<div class="layui-main" style="margin-top: 15px;">
		<blockquote class="layui-elem-quote" style="margin-bottom: -10px;border-top: 1px solid #e2e2e2;border-right: 1px solid #e2e2e2;" >
		<form id="searchFrm" class="layui-form">
		<#list properties as property><#if property.search>
			<label>${property.cnName}</label>
			<input type="text" id="${property.name}" name="${property.name}" placeholder="请输入" autocomplete="off" class="layui-input" style="display: inline;width:200px;">
		</#if></#list>
			<button class="layui-btn" lay-submit lay-filter="search">查询</button>
			<button class="layui-btn layui-btn-primary" lay-submit lay-filter="add">添加</button>
		<div class="layui-form-item" style="margin-bottom: 0px;">
		</form>
		</blockquote>
	
	<table id="dataTable" lay-filter="dataTable"></table>
</div>
<script type="text/javascript" src="${r'${path}'}/js/jquery-1.7.2.min.js"></script>
<script src="${r'${path}'}/layui/layui.js"></script>
<script src="${r'${path}'}/js/layuicommon.js"></script>
<script type="text/javascript">

layui.use(['table','layer'], function(){
	var table = layui.table,layer = layui.layer;
	table.render({
	  elem: '#dataTable'
	  ,id: 'dataTable'
	  ,height: 'full-103' //容器高度
	  ,url: '${r'${path}'}/${moduleName}/doSearch.action?layui=1'
	  ,where: active.buildWhere()
	  ,page:true
	  ,limit:10
	  ,request:{pageName:'page.pageIndex',limitName:'page.pageSize'}
	  ,response:{statusCode:100,dataName:'res'}
	  ,cols: [[{field:'row', title:'序号', width:60},
	          <#list properties as property><#if property.show==true>
	          {field:'${property.name}', title:'${property.cnName}', width:100, sort: false},
	          </#if></#list>
	          {title:'操作', fixed:'right', width:110, align:'center', toolbar: '#barTpl'}]] //设置表头
	});
	
	//监听工具条
	table.on('tool(dataTable)', function(obj){
	  var data = obj.data; //获得当前行数据
	  var layEvent = obj.event; //获得 lay-event 对应的值

	  if(layEvent === 'del'){ //删除
	    layer.confirm('是否确定删除${moduleCnName}？', function(index){
	      <#assign a=0>
	      $.post("${r'${path}'}/${moduleName}/doDelete.action?layui=1&<#list properties as property><#if property.id><#if a!=0>+"&</#if>${property.name}="+data.${property.name}<#assign a=a+1></#if></#list>,function(ret){
	    	  if(ret.returnvalue==1){
	  			layer.msg(ret.message, {icon: 1});
	  			active.reload();
		  	  }else{ 
		  		layer.msg(ret.message, {icon: 2});
		  	  }
	      });
	    });
	  } else if(layEvent === 'edit'){ //编辑
	    layer.open({
	      type: 2,
	      title: '编辑${moduleCnName}',
	      area : ['550px' , '500px'],<#assign a=0>
	      content: "${r'${path}'}/${moduleName}/goModify.action?<#list properties as property><#if property.id><#if a!=0>+"&</#if>${property.name}="+data.${property.name}<#assign a=a+1></#if></#list>,
	      btn: ['保存'],
	      yes: function(index, layero){
	    	    var iframeWin = window[layero.find('iframe')[0]['name']];
	    	    iframeWin.save();
	    	  }
	    });
	  }
	});
	form.on('submit(search)', function(data){
	  layui.table.reload('dataTable', {where: active.buildWhere()});
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
	form.on('submit(add)', function(data){
	  active.add();
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
	
	form.verify(extVerify);

});

var active = {
  reload: function(){
    layui.table.reload('dataTable', {where: active.buildWhere()});
  }
  ,buildWhere: function(){
	  var where = $('#searchFrm').serializeObject();
	  return where;
  }
  ,add: function(){
	  layer.open({
	      type: 2,
	      title: '添加${moduleCnName}',
	      area : ['550px' , '500px'],
	      content: '${r'${path}'}/${moduleName}/goModify.action',
	      btn: ['保存'],
	      yes: function(index, layero){
	    	    var iframeWin = window[layero.find('iframe')[0]['name']];
	    	    iframeWin.save();
	    	  }
	    });
  }
};
</script>
<%@include file="/center/common/layui_tpls.jsp" %>
</body>
</html>
