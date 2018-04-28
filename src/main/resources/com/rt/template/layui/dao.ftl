package ${basePackage}.dao;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import cn.ymcd.ods.db.base.dao.BaseDAO;
import ${basePackage}.dto.${dtoName};

/**
 * ${moduleCnName}DAO
 * @projectName:${projectName}
 * @author:${author}
 * @date:${dateStr}
 * @version ${version}
 */
@Repository
public class ${daoName} extends BaseDAO<${dtoName}> {

    @Autowired
    public ${daoName}(@Qualifier(${db}) DataSource dataSource) {
        setDataSource(dataSource);
    }
}