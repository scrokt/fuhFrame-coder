package ${basePackage}.dto;
<#list properties as property>
<#if property.type??>
import ${property.type};
</#if>
</#list>


import org.codehaus.jackson.annotate.JsonIgnore;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import cn.ymcd.core.annotation.CustomSequence;

@JsonIgnoreProperties(ignoreUnknown=true)
@CustomSequence(seqName="seq_${moduleName}")
public class ${dtoName} {
<#list properties as property>
    <#if property.type?? && property.type == "java.util.Date">
    @JsonIgnore
    </#if>
    private ${property.simpleType} ${property.name};

</#list>
<#list properties as property>
    
    public ${property.simpleType} ${property.getMethodName}(){
        return ${property.name};
    }
    
    public void ${property.setMethodName}(${property.simpleType} ${property.name}) {
        this.${property.name} = ${property.name};
    }
</#list>
}