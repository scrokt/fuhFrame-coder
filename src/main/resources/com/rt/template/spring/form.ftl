package ${basePackage}.search;

<#assign b=0>
<#list properties as property>
<#if property.type?? && property.search>
<#if b==0><#assign b=b+1>
import ${property.type};</#if>
</#if>
</#list>

import cn.ymcd.ods.db.base.annotation.BeforeSql;
import cn.ymcd.ods.db.base.annotation.SearchExpr;
import cn.ymcd.ods.db.base.search.JoinSearchForm;

/**
 * ${moduleCnName}SearchForm
 * @projectName:${projectName}
 * @author:${author}
 * @date:${dateStr}
 * @version ${version}
 */
@BeforeSql("select * from ${tableName} ")
public class ${formName} extends JoinSearchForm {
<#list properties as property>
<#if property.search>
    @SearchExpr(expr = "${property.searchExpr}")
    private ${property.simpleType} ${property.name};
</#if>
</#list>
<#list properties as property><#if property.search>
    
    public ${property.simpleType} ${property.getMethodName}(){
        return ${property.name};
    }
    
    public void ${property.setMethodName}(${property.simpleType} ${property.name}) {
        this.${property.name} = ${property.name};
    }
</#if></#list>
}