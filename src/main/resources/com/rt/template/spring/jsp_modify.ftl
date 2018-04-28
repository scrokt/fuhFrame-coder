<%@page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${r'${path}'}/js/jvc.js"></script>
<script type="text/javascript" src="${r'${path}'}/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${r'${path}'}/js/comcommon.js"></script>
<link href="${r'${path}'}/css/jvc/main.css" rel="stylesheet" type="text/css" />
<link href="${r'${path}'}/css/main.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
	jvc.include("jvc.window");
	jvc.include("jvc.data");		
	jvc.include("jvc.ui.form");
	jvc.init("main();"); 
	dowhat='<c:if test="${r'${dto'}==null}">add</c:if><c:if test="${r'${dto'}!=null}">update</c:if>';
	function main(){
	
	}
	function save(me,callback){  
		//验证空值的统一方法
		<#assign a=0>
		if(!(<#list properties as property><#if property.edit><#if property.nullAble==false><#if a!=0>&&</#if>checkEmpty("${property.name}","${property.cnName}")</#if><#assign a=a+1></#if></#list>)){
			return;
		}
		//验证数字
		if(!(true <#list properties as property><#if property.edit><#if property.simpleType=="Long" || property.simpleType=="Integer">&& checkNum("${property.name}","${property.cnName}")</#if></#if></#list>)){
			return;
		}
		
		$$("frm").json="${r'${path}'}/${moduleName}/doModify.action?cmd="+dowhat;
		jvc.data.submit($$("frm"),saveok,me,callback);	
	}
	function saveok(j,me,callback){  
		if(j.returnvalue==1){    
			callback();
			top.jvc.window.tips(j.message,"success");
			me.close();			
		} else{ 
			top.jvc.window.tips(j.message,"error");
		}
	} 
</script>
</head>
<body style="font-size:9pt;"> 
<div id="of">
<form  name="frm" id="frm">  
  <center ><c:if test="${r'${dto'}!=null}"><#list properties as property><#if property.id><input type="hidden" id="${property.name}" name="${property.name}" value="${r'${dto'}.${property.name} }"/></#if></#list></c:if>
  <table width="100%">
  <#list properties as property>
  <#if property.edit>
  <#if property.id>
  <tr>
  <td align="right"><#if property.nullAble==false><font color="red">*&nbsp;</font></#if>${property.cnName}：</td>
  <td align="left"><input class="input_text" <c:if test="${r'${dto'}!=null}">disabled="disabled" </c:if><c:if test="${r'${dto'}==null}">id="${property.name}" name="${property.name}" </c:if> value="${r'${dto'}.${property.name} }" style="width:200px" maxlength="${property.dataLength}"/></td>
  </tr>
  <#else>
  <tr>
  <td align="right"><#if property.nullAble==false><font color="red">*&nbsp;</font></#if>${property.cnName}：</td>
  <td align="left"><input class="input_text" id="${property.name}" name="${property.name}"  value="${r'${dto'}.${property.name} }" style="width:200px" maxlength="${property.dataLength}"/></td>
  </tr>
  </#if>
  </#if>
  </#list>
  </table>
  </center>
</form>
</div>
  
</body>  
</html>