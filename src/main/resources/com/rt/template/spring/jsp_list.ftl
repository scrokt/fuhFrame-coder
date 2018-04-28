<%@page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="${r'${path}'}/js/jvc.js"></script>
<script type="text/javascript" src="${r'${path}'}/js/comcommon.js"></script>
<script type="text/javascript" src="${r'${path}'}/js/jquery-1.7.2.min.js"></script>
<link href="${r'${path}'}/css/jvc/main.css" rel="stylesheet" type="text/css" />
<link href="${r'${path}'}/css/main.css" type="text/css" rel="stylesheet" />
<script type="text/javascript">
	jvc.include("jvc.window");
	jvc.include("jvc.data");
	jvc.init("main()");
	function main(isLoadPage) {
		jvc.data.submit2($$("frm"), $$("data"), $$("data_page"), isLoadPage);

	}
	<#assign a=0>
	function del(<#list properties as property><#if property.id><#if a!=0>,</#if>${property.name}<#assign a=a+1></#if></#list>) {
		top.jvc.window.confirm("确定删除${moduleCnName}吗?", function() {
			<#assign a=0>
			jvc.data.query("${r'${path}'}/${moduleName}/doDelete.action?<#list properties as property><#if property.id><#if a!=0>+"&</#if>${property.name}="+${property.name}<#assign a=a+1></#if></#list>, dealReturnMsg);
		});
	}

	function getoperate(status) {
		str = '<span>';<#assign a=0>
		str += '<a href="javascript:top.jvc.window.open({url:\'${r'${path}'}/${moduleName}/goModify.action?<#list properties as property><#if property.id><#if a!=0>&</#if>${property.name}=@${property.name}<#assign a=a+1></#if></#list>\',id:\'1\',title:\'修改\',width:550,height:300,lock:true,cancel:true,ok:function(){this.frame.save(this,function(){main(true);});return false;}})" title="修改">';
		str += '修改</a>&nbsp;';<#assign a=0>
		str += '<a href="javascript:del(<#list properties as property><#if property.id><#if a!=0>,</#if>\'@${property.name}\'<#assign a=a+1></#if></#list>)" title="删除">删除</a>&nbsp;';
		str += '</span>';
		return str;
	}
</script>
</head>

<body>

	<div class="table">
		<div class="query_box">
			<form name="frm" id="frm" json="${r'${path}'}/${moduleName}/doSearch.action"
				onsubmit="return false;">
			<table>
				<tr><#assign a=0><#list properties as property><#if property.search><#if (a+1)%5==0>
				</tr><tr>
</#if>

					<td>${property.cnName}：</td>
					<td><input class="input_text" id="${property.name}" name="${property.name}" />&nbsp;&nbsp;</td>
					<#assign a=a+1></#if></#list>
					<td><input class="bt3" value="查询" type="button"
						onclick="main();" /></td>
				</tr>
				
			</table>	
			</form>
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr class="title">
				<th width="5%">序号</th>
				<#list properties as property>
<#if property.show==true>				<th width="${property.width}%">${property.cnName}</th>
</#if></#list>
				<th width="10%">操作</th>
			</tr>
			<tbody id="data">
				<tr class="first" style="display: none;">
					<td align="center" fld="row"></td>
					<#list properties as property>
<#if property.show==true>					<td align="center" fld="${property.name}" title="@${property.name}"></td>
</#if></#list>
					<td align="center" fld="getoperate()"></td>
				</tr>
			</tbody>
			<tr class="footer">
				<td height="36" colspan="9"><input style="cursor: pointer;"
					type="button"
					onclick="javascript:top.jvc.window.open({url:'${r'${path}'}/${moduleName}/goModify.action',id:'1',title:'添加${moduleCnName}',width:550,height:300,lock:true,cancel:true,ok:function(){this.frame.save(this,function(){main(true);});return false;}})"
					value="" class="bt_add" name="textfield2" /></td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr>
				<td align="right" class="page" height="49">
					<!-- 分页控件 -->
					<div style="float: right" id="data_page" />
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
