<%@page contentType="text/html;charset=utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="${r'${path}'}/layui/css/layui.css">
</head>
</head>
<body>
<div style="padding:20px;">
<form id="frm" class="layui-form">
  <c:if test="${r'${dto!=null}'}">
  <#list properties as property><#if property.id>
  <input type="hidden" id="${property.name}" name="${property.name}" value="${r'${dto'}.${property.name} }"/>
  </#if></#list>
  </c:if>
  <#list properties as property>
  <#if property.edit>
  <div class="layui-form-item">
    <label class="layui-form-label">${property.cnName}：</label>
    <div class="layui-input-block">
      <input type="text" id="${property.name}" name="${property.name}" value="${r'${dto'}.${property.name} }" maxlength="${property.dataLength}" class="layui-input" <#if property.nullAble==false>required lay-verify="required<#if property.simpleType=="Long" || property.simpleType=="Integer">|number</#if>" </#if>autocomplete="off"/>
    </div>
  </div>
  </#if>
  </#list>
  <button id="save" lay-submit lay-filter="*" style="display: none;">提交</button>
</form>
</div>
<script src="${r'${path}'}/layui/layui.js"></script>
<script type="text/javascript">
layui.use(['form','layer'], function(){
	var form = layui.form,$ = layui.$;
	if('${r'${cmd }'}' == 'update'){
		$('#code').attr('readonly','readonly');
	}

	form.on('submit(*)', function(data){
	  $.post("${r'${path}'}/${moduleName}/doModify.action?layui=1&cmd=${r'${cmd}'}", $("#frm").serialize(),function(ret){
			if(ret.returnvalue==1){
				parent.active.reload();
				parent.layer.msg(ret.message, {icon: 1});
				var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
				parent.layer.close(index); //再执行关闭 
			}else{ 
				parent.layer.msg(ret.message, {icon: 2});
			}
		});
	  return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	});
});
function save(){
	layui.$("#save").click();
}
</script>
</body>  
</html>