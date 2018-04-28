package ${basePackage}.dto;
<#list properties as property>
<#if property.type??>
import ${property.type};
</#if>
</#list>


import com.rt.core.annotation.CustomSequence;
import org.springframework.format.annotation.DateTimeFormat;

@CustomSequence(seqName="seq_${moduleName}")
public class ${dtoName} {
<#list properties as property>
    <#if property.type?? && property.type == "java.util.Date">
    @DateTimeFormat(pattern = "yyyy-MM-dd")
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