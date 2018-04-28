package ${basePackage}.action.form;

import javax.ws.rs.QueryParam;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import cn.ymcd.core.util.pager.BaseSearchForm;
<#list properties as property>
    <#if property.type??>
import ${property.type};
    </#if>
</#list>

@JsonIgnoreProperties(ignoreUnknown=true)
public class ${formName} extends BaseSearchForm {

<#list properties as property>
    @QueryParam("${property.name}")
    private ${property.simpleType} ${property.name};
</#list>

<#list properties as property>
    public ${property.simpleType} ${property.getMethodName}() {
        return ${property.name};
    }
    
    public void ${property.setMethodName}(${property.simpleType} ${property.name}) {
        this.${property.name} = ${property.name};
    }
</#list>

}
