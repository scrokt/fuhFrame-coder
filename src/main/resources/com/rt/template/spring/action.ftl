package ${basePackage}.web;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.ymcd.ods.OdsComponent;
import cn.ymcd.ods.db.base.search.Page;
import ${basePackage}.dto.${dtoName};
import ${basePackage}.search.${formName};
import ${basePackage}.service.${serviceName};
import cn.ymcd.web.base.BaseAction;

@RequestMapping("/${moduleName}")
@Controller
public class ${actionName} extends BaseAction {

    private ${serviceName} ${serviceVarName} = OdsComponent.getBean(${serviceName}.class);

    @RequestMapping("/goList")
    public ModelAndView goList() {
        return getBaseMav("center/${moduleName}/${moduleName}_list");
    }

    @RequestMapping("/doSearch")
    @ResponseBody
    public String doSearch(${formName} searchForm) {
        if (searchForm.getPage() == null) {
            searchForm.setPage(new Page());
        }
        List<${dtoName}> list = ${serviceVarName}.findBySearchForm(searchForm);
        return returnList(list, searchForm);
    }

    @RequestMapping("/goModify")
    public ModelAndView goModify(${dtoName} ${dtoVarName}) {
        ${dtoName} findById = ${serviceVarName}.findById(${dtoVarName});
        ModelAndView mav = getBaseMav("center/${moduleName}/${moduleName}_modify");
        mav.addObject("dto", findById);
        return mav;
    }

    @RequestMapping("/doModify")
    @ResponseBody
    public String doModify(${dtoName} ${dtoVarName}, String cmd) {
        if ("add".equals(cmd)) {
            if (${serviceVarName}.findById(${dtoVarName}) != null) {
                return returnCodeMsg("-1", "存在主键重复的数据");
            }
            ${serviceVarName}.insert(${dtoVarName});
        } else {
            ${serviceVarName}.update(${dtoVarName});
        }
        return returnMsg("1", "操作成功");
    }

    @RequestMapping("/doDelete")
    @ResponseBody
    public String doDelete(${dtoName} ${dtoVarName}) {
        ${serviceVarName}.delete(${dtoVarName});
        return returnMsg("1", "操作成功");
    }

}