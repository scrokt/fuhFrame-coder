package ${basePackage}.dto;
<#assign b=0>
<#list properties as property>
<#if property.type??>
<#if b==0><#assign b=b+1>
import ${property.type};</#if>
</#if>
</#list>

import cn.ymcd.ods.db.base.annotation.Table;
import cn.ymcd.ods.db.base.annotation.UpdateKey;

/**
 * ${moduleCnName}DTO
 * @projectName:${projectName}
 * @author:${author}
 * @date:${dateStr}
 * @version ${version}
 */
@Table(name="${tableName}")<#assign a=0>
@UpdateKey(keys="<#list properties as property><#if property.id><#if a!=0>,</#if>${property.name}<#assign a=a+1></#if></#list>")
public class ${dtoName} {
<#list properties as property>
	
    /**
     * <#if property.cnName?? && property.cnName!="">${property.cnName}<br/></#if> TYPE:${property.dataType}(${property.dataLength})
     */
    private ${property.simpleType} ${property.name};
</#list>
<#list properties as property>
    
    <#if property.cnName?? && property.cnName!="">/**
     * ${property.cnName}
     */</#if>
    public ${property.simpleType} ${property.getMethodName}(){
        return ${property.name};
    }
    
    <#if property.cnName?? && property.cnName!="">/**
     * ${property.cnName}
     */</#if>
    public void ${property.setMethodName}(${property.simpleType} ${property.name}) {
        this.${property.name} = ${property.name};
    }
</#list>

    @Override
    public String toString() {
        return "${dtoName} [<#list properties as property><#if property_index!=0>", </#if>${property.name}=" + ${property.name} +</#list> "]";
    }
}