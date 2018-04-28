package ${basePackage}.action.form;

import com.rt.core.util.pager.BaseSearchForm;
<#list properties as property>
    <#if property.type??>
import ${property.type};
    </#if>
</#list>

public class ${formName} extends BaseSearchForm {

<#list properties as property>
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
