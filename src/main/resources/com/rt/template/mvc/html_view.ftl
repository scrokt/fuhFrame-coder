<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>修改${moduleName}</title>
<link href="${r'${context}'}/html/images/layout.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="${r'${context}'}/html/jquery-1.12.0.min.js"></script>
<script type="text/javascript" src="${r'${context}'}/html/lhgdialog/lhgdialog.min.js"></script>
<script type="text/javascript" src="${r'${context}'}/html/datepicker/WdatePicker.js"></script>
<script type="text/javascript">
	var api = frameElement.api, W = api.opener;
	$(function() {

	});
</script>
</head>
<body style="background:#fff;">
<form id="frm" action="${r'${context}'}/${moduleName}/doEdit" method="post">
<div class="layer_cont">
  <table class="task_tab">
  	<#list properties as property>
    <tr>
      <#if property.name == 'id'>
      	<td>
      	<input  type="hidden" name="${property.name}" value="${r'${result.data.'}${property.name}!}"/>
      	</td>
      <#else>
      <td align="right" width="130px">
      <#if property.nullAble><#else><font color="red">*</font></#if>
      <#if property.cnName??>${property.cnName}<#else>${property.name!}</#if>:</td>
      <td  >
	      <#if property.simpleType == 'Date'>
	      <input id="${property.name}" readonly="readonly" class="Wdate" type="text" name="${property.name}" value="${r'<#if result.data.'}${property.name}${r'??>${result.data.'}${property.name}${r'?date}<#else></#if>'}" onClick="WdatePicker()"/>
	      <#else>
	      <input id="${property.name}" readonly="readonly" class="task_text2" type="text" name="${property.name}" value="${r'${result.data.'}${property.name}!}"/>
	      </#if>
      </td>
      </#if>
    </tr>
    </#list>
  </table>
</div>
</form>
</body>
</html>
