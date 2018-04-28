package ${basePackage}.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.rt.core.annotation.OperatorLog;
import com.rt.core.base.BaseAction;
import com.rt.core.util.Result;
import com.rt.core.util.pager.Page;
import com.rt.core.util.Result.MsgCode;
import ${basePackage}.action.form.${formName};
import ${basePackage}.dao.${daoName};
import ${basePackage}.dto.${dtoName};
import ${basePackage}.service.${serviceName};

/**
 * <#if moduleCnName??>${moduleCnName}<#else>${moduleName}</#if>
 * 
 */
@Controller
public class ${actionName} extends BaseAction {

	@Autowired
	private ${daoName} ${daoVarName};
	@Autowired
	private ${serviceName} ${serviceVarName};

	/**
	 * 查询
	 * 
	 * 分页查询 传入的值有自定义searchForm的字段 和baseSearchForm的Page对象 pageIndex和pageSize
	 * 
	 * @return
	 */
	@OperatorLog(module = "${moduleCnName}", operate = "查询")
	@RequestMapping("/${moduleName}/goMain")
	public ModelAndView goMain(${formName} searchForm) {
		if(searchForm.getPage() == null){
			searchForm.setPage(new Page());
		}
		List<${dtoName}> ${dtoVarName}s = ${daoVarName}.findBySearchForm(searchForm);
		return wrap("/${moduleName}/main.html", Result.result(${dtoVarName}s, searchForm));
	}

	/**
	 * 新增
	 * 
	 * @param name
	 * @return
	 */
	@RequestMapping("/${moduleName}/goAdd")
	public ModelAndView goAdd() {
		return wrap("/${moduleName}/add.html");
	}

	@RequestMapping("/${moduleName}/doAdd")
	@ResponseBody
	@OperatorLog(module = "${moduleCnName}", operate = "新增")
	public String doAdd(${dtoName} ${dtoVarName}) {
		${daoVarName}.insert(${dtoVarName});
		return Result.message(MsgCode.SUCCESS, "新增成功", ${dtoVarName});
	}

	/**
	 * 删除
	 * 
	 * @param id
	 * @return
	 */
	@OperatorLog(module = "${moduleCnName}", operate = "删除")
	@ResponseBody
	@RequestMapping("/${moduleName}/doDelete")
	public String delete(Long id) {
		int result = ${daoVarName}.deleteByPrimaryKey(id);
		return Result.message(MsgCode.SUCCESS, "删除成功", result);

	}

	/**
	 * 修改
	 * 
	 * @return
	 */
	@RequestMapping("/${moduleName}/goEdit")
	public ModelAndView goEdit(Long id) {
		${dtoName} ${dtoVarName} = ${daoVarName}.selectByPrimaryKey(id);
		return wrap("/${moduleName}/edit.html", Result.result(${dtoVarName}));
	}

	@RequestMapping("/${moduleName}/doEdit")
	@ResponseBody
	@OperatorLog(module = "${moduleCnName}", operate = "修改")
	public String doEdit(${dtoName} ${dtoVarName}) {
		int result = ${daoVarName}.updateByPrimaryKeySelective(${dtoVarName});
		return Result.message(MsgCode.SUCCESS, "修改成功", result);
	}
	
	/**
	 * 查看
	 * 
	 * @return
	 */
	@RequestMapping("/${moduleName}/goView")
	public ModelAndView goView(Long id) {
		${dtoName} ${dtoVarName} = ${daoVarName}.selectByPrimaryKey(id);
		return wrap("/${moduleName}/view.html", Result.result(${dtoVarName}));
	}

}
