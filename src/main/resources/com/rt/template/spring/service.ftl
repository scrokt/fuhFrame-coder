package ${basePackage}.service;

import java.util.List;

import ${basePackage}.dto.${dtoName};
import ${basePackage}.search.${formName};

/**
 * ${moduleCnName}服务接口
 * @projectName:${projectName}
 * @author:${author}
 * @date:${dateStr}
 * @version ${version}
 */
public interface ${serviceName} {

    int insert(${dtoName} ${dtoVarName});

    int update(${dtoName} ${dtoVarName});

    ${dtoName} findById(${dtoName} ${dtoVarName});

    int delete(${dtoName} ${dtoVarName});
    
    List<${dtoName}> findBySearchForm(${formName} ${formVarName});
    
    int countBySearchForm(${formName} ${formVarName});

}
