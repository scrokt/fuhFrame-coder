<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${basePackage}.dao.${daoName}" >
  <resultMap id="BaseResultMap" type="${basePackage}.dto.${dtoName}" >
<#list properties as property>
    <#if property.id>
    <id column="ID" property="id" jdbcType="DECIMAL" />
    <#else>
    <result column="${property.column}" property="${property.name}" jdbcType="${property.jdbcType}" />
    </#if>
</#list>
  </resultMap>
  <sql id="Base_Column_List" >
<#list properties as property>
    <#if property_has_next>
    ${property.column},
    <#else>
    ${property.column}
    </#if>
</#list>
  </sql>
  <select id="selectByPrimaryKey" resultMap="BaseResultMap" parameterType="java.lang.Long" >
    select 
    <include refid="Base_Column_List" />
    from ${tableName}
    where ID = ${r'#'}{id,jdbcType=DECIMAL}
  </select>
  <select id="findBySearchForm" resultMap="BaseResultMap" parameterType="com.rt.core.util.pager.BaseSearchForm">
    select 
    <include refid="Base_Column_List" />
    from ${tableName} 
    <where>  
    <#list properties as property>
        <if test="${property.name}!=null and ${property.name} != ''">
            and ${property.column} = ${r'#'}{${property.name}}
        </if>
    </#list>
    </where>
  </select>
  <delete id="deleteByPrimaryKey" parameterType="java.lang.Long" >
    delete from ${tableName}
    where ID = ${r'#'}{id,jdbcType=DECIMAL}
  </delete>
  <insert id="insert" parameterType="${basePackage}.dto.${dtoName}" >

    insert into ${tableName} (<include refid="Base_Column_List" />)
    values (
    <#list properties as property>
    <#if property_has_next>
    ${r'#'}{${property.name},jdbcType=${property.jdbcType}},
    <#else>
    ${r'#'}{${property.name},jdbcType=${property.jdbcType}}
    </#if>
    </#list>
    )
  </insert>
  <insert id="insertSelective" parameterType="${basePackage}.dto.${dtoName}" >
    insert into ${tableName}
    <trim prefix="(" suffix=")" suffixOverrides="," >
    <#list properties as property>
      <if test="${property.name} != null and ${property.name} != ''" >
        ${property.column},
      </if>
    </#list>
    </trim>
    <trim prefix="values (" suffix=")" suffixOverrides="," >
    <#list properties as property>
      <if test="${property.name} != null and ${property.name} != ''" >
        ${r'#'}{${property.name},jdbcType=${property.jdbcType}},
      </if>
    </#list>
    </trim>
  </insert>
  <update id="updateByPrimaryKeySelective" parameterType="${basePackage}.dto.${dtoName}" >
    update ${tableName}
    <set >
    <#list properties as property>
      <#if !property.id>
      <if test="${property.name} != null " >
        ${property.column} = ${r'#'}{${property.name},jdbcType=${property.jdbcType}},
      </if>
      </#if>
    </#list>
    </set>
    where ID = ${r'#'}{id,jdbcType=DECIMAL}
  </update>
  <update id="updateByPrimaryKey" parameterType="${basePackage}.dto.${dtoName}" >
    update ${tableName}
    set 
    <#list properties as property>
    <#if !property.id>
     <#if property_has_next>
      ${property.column}=${r'#'}{${property.name},jdbcType=${property.jdbcType}},
    <#else>
      ${property.column}=${r'#'}{${property.name},jdbcType=${property.jdbcType}}
     </#if>
    </#if>
    </#list>
    where ID = ${r'#'}{id,jdbcType=DECIMAL}
  </update>
</mapper>