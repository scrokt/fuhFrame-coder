package ${basePackage}.service;

import java.util.List;

import ${basePackage}.action.form.${formName};
import ${basePackage}.dto.${dtoName};

public interface ${serviceName} {

    int deleteByPrimaryKey(Long id);

    int insert(${dtoName} record);

    int insertSelective(${dtoName} record);

    ${dtoName} selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(${dtoName} record);

    int updateByPrimaryKey(${dtoName} record);

    List<${dtoName}> findBySearchForm(${formName} searchForm);
}
