package ${basePackage}.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import ${basePackage}.action.form.${formName};
import ${basePackage}.dao.${daoName};
import ${basePackage}.dto.${dtoName};
import ${basePackage}.service.${serviceName};

@Component
public class ${serviceImplName} implements ${serviceName} {

    @Autowired
    private ${daoName} ${daoVarName};
    
    @Override
    public List<${dtoName}> findBySearchForm(${formName} searchForm) {
        return ${daoVarName}.findBySearchForm(searchForm);
    }

    @Override
    public int deleteByPrimaryKey(Long id) {
        return ${daoVarName}.deleteByPrimaryKey(id);
    }

    @Override
    public int insert(${dtoName} record) {
        return ${daoVarName}.insert(record);
    }

    @Override
    public int insertSelective(${dtoName} record) {
        return ${daoVarName}.insertSelective(record);
    }

    @Override
    public ${dtoName} selectByPrimaryKey(Long id) {
        return ${daoVarName}.selectByPrimaryKey(id);
    }

    @Override
    public int updateByPrimaryKeySelective(${dtoName} record) {
        return ${daoVarName}.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(${dtoName} record) {
        return ${daoVarName}.updateByPrimaryKey(record);
    }

}
