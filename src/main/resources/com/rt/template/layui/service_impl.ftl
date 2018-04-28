package ${basePackage}.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.util.Assert;

import ${basePackage}.search.${formName};
import ${basePackage}.dao.${daoName};
import ${basePackage}.dto.${dtoName};
import ${basePackage}.service.${serviceName};

/**
 * ${moduleCnName}服务实现
 * @projectName:${projectName}
 * @author:${author}
 * @date:${dateStr}
 * @version ${version}
 */
@Service
@Transactional(value = "tm",propagation=Propagation.SUPPORTS)
public class ${serviceImplName} implements ${serviceName} {

    @Autowired
    private ${daoName} ${daoVarName};
    
  	@Override
    public int insert(${dtoName} ${dtoVarName}) {
        Assert.notNull(${dtoVarName});
        return ${daoVarName}.insert(${dtoVarName});
    }

    @Override
    public int update(${dtoName} ${dtoVarName}) {
        Assert.notNull(${dtoVarName});
        return ${daoVarName}.update(${dtoVarName});
    }

    @Override
    public ${dtoName} findById(${dtoName} ${dtoVarName}) {
        Assert.notNull(${dtoVarName});
        return ${daoVarName}.findById(${dtoVarName});
    }

    @Override
    public int delete(${dtoName} ${dtoVarName}) {
        return ${daoVarName}.delete(${dtoVarName});
    }

    @Override
    public List<${dtoName}> findBySearchForm(${formName} searchForm) {
        return ${daoVarName}.findBySearchForm(searchForm, ${dtoName}.class);
    }

    @Override
    public int countBySearchForm(${formName} searchForm) {
        return ${daoVarName}.countBySearchForm(searchForm);
    }
}
