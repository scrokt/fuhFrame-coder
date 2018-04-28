package ${basePackage}.action;

import java.util.List;

import javax.ws.rs.BeanParam;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.ymcd.core.annotation.OperatorLog;
import cn.ymcd.core.util.message.RsfMessage;
import cn.ymcd.core.util.message.RsfMessage.MsgCode;
import ${basePackage}.action.form.${formName};
import ${basePackage}.dao.${daoName};
import ${basePackage}.dto.${dtoName};
import ${basePackage}.service.${serviceName};

/**
 * ${moduleCnName}
 *
 */
@Path("/sys")
@Component
public class ${actionName} {

    @Autowired
    private ${daoName} ${daoVarName};
    @Autowired
    private ${serviceName} ${serviceVarName};

    /**
     * 新增
     * 
     * @param name
     * @return
     */
    @POST
    @Path("/${moduleName}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @OperatorLog(module = "${moduleCnName}", operate = "新增")
    public String add(${dtoName} ${dtoVarName}) {
        ${daoVarName}.insert(${dtoVarName});
        return RsfMessage.message(MsgCode.SUCCESS, "新增成功", ${dtoVarName});
    }

    /**
     * 删除
     * 
     * @param id
     * @return
     */
    @DELETE
    @Path("/${moduleName}/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @OperatorLog(module = "${moduleCnName}", operate = "删除")
    public String delete(@PathParam("id") Long id) {
        int result = ${daoVarName}.deleteByPrimaryKey(id);
        return RsfMessage.message(MsgCode.SUCCESS, "删除成功", result);

    }

    /**
     * 修改
     * 
     * @return
     */
    @PUT
    @Path("/${moduleName}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @OperatorLog(module = "${moduleCnName}", operate = "修改")
    public String edit(${dtoName} ${dtoVarName}) {
        ${daoVarName}.updateByPrimaryKeySelective(${dtoVarName});
        return RsfMessage.message(MsgCode.SUCCESS, "修改成功");
    }

    /**
     * 查询
     * 
     * 分页查询 传入的值有自定义searchForm的字段 和baseSearchForm的Page对象 pageIndex和pageSize
     * 
     * @return
     */
    @GET
    @Path("/${moduleName}")
    @Produces(MediaType.APPLICATION_JSON)
    @OperatorLog(module = "${moduleCnName}", operate = "查询")
    public String search(@BeanParam ${formName} searchForm) {
        List<${dtoName}> ${dtoVarName}s = ${daoVarName}.findBySearchForm(searchForm);
        return RsfMessage.message(MsgCode.SUCCESS, "查询成功",
                searchForm.getRowTotal(), ${dtoVarName}s.size(), ${dtoVarName}s);
    }

}
