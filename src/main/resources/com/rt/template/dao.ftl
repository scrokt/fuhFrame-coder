package ${basePackage}.dao;

import java.util.List;

import cn.ymcd.core.base.BaseDAO;
import ${basePackage}.action.form.${formName};
import ${basePackage}.dto.${dtoName};

public interface ${daoName} extends BaseDAO {

    int deleteByPrimaryKey(Long id);

    int insert(${dtoName} record);

    int insertSelective(${dtoName} record);

    ${dtoName} selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(${dtoName} record);

    int updateByPrimaryKey(${dtoName} record);

    List<${dtoName}> findBySearchForm(${formName} searchForm);
}