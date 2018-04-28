<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理系统</title>
<link href="${r'${context}'}/html/images/layout.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${r'${context}'}/html/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="${r'${context}'}/html/lhgdialog/lhgdialog.min.js"></script>
<script type="text/javascript" src="${r'${context}'}/html/datepicker/WdatePicker.js"></script>
<script type="text/javascript">

	$(function() {

	});

	function goAdd(){
		$.dialog({
			title:'新增',
			content:'url:${r'${context}'}/${moduleName}/goAdd',
			lock:true,width:500,height:300,zIndex:1000
		});	
	}
	function goEdit(id){
		$.dialog({
			title:'修改',
			content:'url:${r'${context}'}/${moduleName}/goEdit?id='+id,
			lock:true,width:500,height:300,zIndex:1000
		});	
	}
	function goView(id){
		$.dialog({
			title:'查看',
			content:'url:${r'${context}'}/${moduleName}/goView?id='+id,
			lock:true,width:500,height:300,zIndex:1000
		});	
	}
	function doDel(id){
		$.post("${r'${context}'}/${moduleName}/doDelete",{id:id},function(data){
			$.dialog.tips("删除成功",0.5,'tips.gif',function(){
				//并刷新页面
				goMain();
			});
		});
	}
	function changePage(pageIndex){
		$("#pageIndex").val(pageIndex);
		goMain();
	}
	function changeSize(pageSize){
		$("#pageSize").val(pageSize);
		goMain();
	}
	function goMain(){
		$('#search').submit();
	}
</script>
</head>
<body>
<form id="search" action="${r'${context}'}/${moduleName}/goMain" method="post">
  <div class="c_right">
    <div class="r_top">
      <table class="position fl" cellpadding="0" cellspacing="0">
        <tr>
          <td><img src="${r'${context}'}/html/images/position.png" width="36" height="39" /></td>
          <td><font color="#9c9c9c">您的位置</font></td>
          <td><font color="#9c9c9c"></font></td>
          <td><font color="#4c8fbd">${moduleCnName}</font></td>
        </tr>
      </table>
    </div>
    <div class="r_content">
      <div class="search_box">
        <table class="search fl" cellpadding="0" cellspacing="0">
          <tr>
            <td><span>编号：</span></td>
            <td><input  class="slk" type="text" name="id" value="${r'${result.searchForm.id!}'}"/></td>
            <td><input class="btn_search" type="button" value="搜索" onclick="goMain()"/></td>
          </tr>
        </table>
        <table class="search fr" cellpadding="0" cellspacing="0">
          <tr>
            <td><a  href="javascript:void(0);" onclick="goAdd()" class="btn_add" ></a></td>
          </tr>
        </table>
      </div>
      <div class="neirong">
		<table class="tab" cellpadding="0" cellspacing="0">
          <tr>
          <#list properties as property>
          <#if property.name == 'id'>
          <#else>
            <th><#if property.cnName??>${property.cnName}<#else>${property.name!}</#if></th>
          </#if>
          </#list>
            <th width="120px">操作</th>
          </tr>
          ${r'<#if result.data?size == 0>'}
          	<tr><td colspan="${properties?size}">查询结果无数据</td></tr>
          ${r'<#else>'}
          ${r'<#list result.data as row>'}
		  <tr>
			<#list properties as property>
			 	<#if property.name == 'id'>
          		<#else>
          		  <#if property.simpleType == 'Date'>
          		  ${r'<#if row.'}${property.name}${r'??><td>${row.'}${property.name}${r'?date}</td><#else><td></td></#if>'}
          		  <#else>
			      <td>${r'${row.'}${property.name}!}</td>
			      </#if>
				</#if>
			</#list>
			<td>
				<div class="cz_box">
					<a class="view" title="查看" onclick="goView(${r'${row.id!}'})"></a>
					<a class="edit" title="编辑" onclick="goEdit(${r'${row.id!}'})"></a>
					<a class="del" title="删除" onclick="doDel(${r'${row.id!}'})"></a>
				</div>
			</td>
			</tr>
		  ${r'</#list>'}
		  ${r'</#if>'}
        </table>
        ${r'<@c.pager result=result />'}
      </div>
    </div>
  </div>
 </form>
</body>
</html>
