<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新增${moduleName}</title>
<link href="${r'${context}'}/html/images/layout.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${r'${context}'}/html/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="${r'${context}'}/html/lhgdialog/lhgdialog.min.js"></script>
<script type="text/javascript" src="${r'${context}'}/html/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="${r'${context}'}/html/js/comcommon.js"></script>
<script type="text/javascript">
	var api = frameElement.api, W = api.opener;
	
	$(function() {

	});

	function doSave(){
		<!-- 检查非空 -->
		<#list properties as property>
		<#if !property.id && !property.nullAble>
		if(!checkEmpty('${property.name}','${property.cnName}')){
			return ;
		}
		</#if>
		</#list>
		//提交
		$.post("${r'${context}'}/${moduleName}/doAdd", $("#frm").serialize(),function(data){
			//关闭窗口
			api.close();
			//提示
			W.$.dialog.tips("新增成功",0.5,'tips.gif',function(){
				//并刷新父页面
				W.goMain();
			});
		});
	}
	
	function doClose(){
		api.close();
	}
</script>
</head>
<body style="background:#fff;">
<form id="frm" action="${r'${context}'}/${moduleName}/doAdd" method="post">
<div class="layer_cont">
  <table class="task_tab">
  	<#list properties as property>
    <tr>
      <#if property.name == 'id'>
      <#else>
      <td align="right" width="130px">
      <#if property.nullAble><#else><font color="red">*</font></#if>
      <#if property.cnName??>${property.cnName}<#else>${property.name!}</#if>:</td>
      <td  >
      	<#if property.simpleType == 'Date'>
      	<input id="${property.name}" class="Wdate" type="text" name="${property.name}" onClick="WdatePicker()"/>
      	<#else>
      	<input id="${property.name}" class="task_text2" type="text" name="${property.name}"/>
      	</#if>
      </#if>
      </td>
    </tr>
    </#list>
  </table>
</div>
<div class="layer_foot">
  <input class="layer_qx" type="button" onclick="doClose()" value="取消"/>
  <input class="layer_qd" type="button" onclick="doSave()" value="确定"/>
</div>
</form>
</body>
</html>
