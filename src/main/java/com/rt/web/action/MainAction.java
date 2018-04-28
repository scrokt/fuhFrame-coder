package com.rt.web.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import redis.clients.jedis.JedisPool;
import cn.ymcd.ods.util.GsonUtil;
import cn.ymcd.ods.util.PojoUtils;
import cn.ymcd.redis.SimpleRedisDAO;
import cn.ymcd.redis.odsconfig.RedisConfig;
import cn.ymcd.web.base.BaseAction;
import cn.ymcd.web.model.SimpleRetMsg;

import com.rt.encrypt.ZipUtil;
import com.rt.gencode.DataBind;
import com.rt.gencode.Generator;
import com.rt.gencode.Generator.GenWhat;
import com.rt.gencode.Model;
import com.rt.gencode.Property;
import com.rt.util.ExcelPoi;
import com.rt.web.filter.RequestHolder;

/**
 * 主控制器，就这一个
 * 
 * @author fuh 2016年3月3日
 */
@Controller
public class MainAction extends BaseAction{

    private static final String E_GENCODE = "D:/gencode/";
    private static final String E_GENEXCEL = "D:/genexcel/";
    private AtomicLong atomicLong = new AtomicLong(0L);
    private static SimpleRedisDAO simpleRedisDAO = null;

    // 首页,填写项目地址和基础包名
    @RequestMapping("goIndex")
    public ModelAndView goIndex() {
        return wrap("main/index");
    }

    @RequestMapping("goIndexLu")
    public ModelAndView goIndexBs() {
        return wrap("main/index_lu");
    }

    // 保存，进入导入sql页面
    @RequestMapping("goModelConfirm")
    public ModelAndView goModelConfirm(DataBind dataBind) {

        dataBind.genModel();
        ModelAndView mav = wrap("main/model_confirm");
        mav.addObject("model", dataBind.getModel());
        return mav;
    }

    @RequestMapping("goModelConfirmLu")
    public ModelAndView goModelConfirmLu(DataBind dataBind) {

        dataBind.genModel();
        ModelAndView mav = wrap("main/model_confirm_lu");
        mav.addObject("model", dataBind.getModel());
        return mav;
    }

    @RequestMapping("goGenResult")
    public ModelAndView goGenResult(Model model) {
        Generator generator = new Generator("spring", model);
        String id = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + "-" + atomicLong.addAndGet(1L);
        String codeBasePath = E_GENCODE + id;
        generator.setBasePath(codeBasePath);
        ModelAndView wrap = wrap("main/genResult");
        try {
            // generator.generateAll();
            generator.generateWhat(GenWhat.DTO);
            generator.generateWhat(GenWhat.DAO);
            generator.generateWhat(GenWhat.FORM);
            generator.generateWhat(GenWhat.SERVICE);
            generator.generateWhat(GenWhat.SERVICE_IMPL);
            generator.generateWhat(GenWhat.ACTION);
            generator.generateWhat("jsp_list");
            generator.generateWhat("jsp_modify");
            ZipUtil.zip(codeBasePath);

            wrap.addObject("message", "生成成功");
            wrap.addObject("id", id);
        } catch (Exception e) {
            e.printStackTrace();
            wrap.addObject("message", "生成失败");
        }
        return wrap;
    }

    @RequestMapping("goGenResultLu")
    public ModelAndView goGenResultLu(Model model) {
        Generator generator = new Generator(model.getSub(), model);
        String id = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + "-" + atomicLong.addAndGet(1L);
        String codeBasePath = E_GENCODE + id;
        generator.setBasePath(codeBasePath);
        ModelAndView wrap = wrap("main/genResultLu");
        try {
            // generator.generateAll();
            generator.generateWhat(GenWhat.DTO);
            generator.generateWhat(GenWhat.DAO);
            generator.generateWhat(GenWhat.FORM);
            generator.generateWhat(GenWhat.SERVICE);
            generator.generateWhat(GenWhat.SERVICE_IMPL);
            generator.generateWhat(GenWhat.ACTION);
            generator.generateWhat("jsp_list");
            generator.generateWhat("jsp_modify");
            ZipUtil.zip(codeBasePath);

            wrap.addObject("message", "生成成功");
            wrap.addObject("id", id);
        } catch (Exception e) {
            e.printStackTrace();
            wrap.addObject("message", "生成失败");
        }
        return wrap;
    }

    @RequestMapping("doDownloadZip")
    public void doDownloadZip(String id, HttpServletResponse response) {
        try {
            // path是指欲下载的文件的路径。
            String path = E_GENCODE + id + ".zip";
            File file = new File(path);
            // 取得文件名。
            String filename = file.getName();
            // 以流的形式下载文件。
            InputStream fis = new BufferedInputStream(new FileInputStream(path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            // 设置response的Header
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
            response.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    @RequestMapping("doDownloadExcel")
    public void doDownloadExcel(String id, HttpServletResponse response) {
        try {
            // path是指欲下载的文件的路径。
            String path = E_GENEXCEL + id + ".xls";
            File file = new File(path);
            // 取得文件名。
            String filename = file.getName();
            // 以流的形式下载文件。
            InputStream fis = new BufferedInputStream(new FileInputStream(path));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            // 设置response的Header
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
            response.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    // -----------------------------------------------------------
    // -- 导出Excel
    // -----------------------------------------------------------
    @RequestMapping("goIndex2")
    public ModelAndView goIndex2() {
        return wrap("main/index2");
    }

    @RequestMapping("goGenExcel")
    public ModelAndView goGenExcel(DataBind dataBind) throws ClassNotFoundException, SQLException {
        String id = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()) + "-" + atomicLong.addAndGet(1L);
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection connection = DriverManager.getConnection(dataBind.getDbUrl(), dataBind.getUsername(),
                dataBind.getPassword());

        Statement statement = connection.createStatement();
        ResultSet tableSet = statement.executeQuery("select table_name,comments from user_tab_comments");
        List<Model> mList = new ArrayList<Model>();
        while (tableSet.next()) {
            String tableName = tableSet.getString("table_name");
            String comments = tableSet.getString("comments");
            Model model = dataBind.getModel(connection, tableName);
            model.setTableComment(comments);
            mList.add(model);
        }
        connection.close();
        ExcelPoi el = new ExcelPoi();
        int tableNoCommentCount = 0, propertyCount = 0, propertyNoCommentCount = 0;
        try {
            el.setOutputSream(new FileOutputStream(E_GENEXCEL + id + ".xls"));
            /*
             * HttpServletResponse response = RequestHolder.getResponse();
             * el.setOutputSream(response.getOutputStream()); response.setHeader("Pragma", "no-cache");
             * response.setHeader("Cache-Control", "no-cache"); response.setHeader("Cache-Control", "no-store");
             * response.setDateHeader("Expires", 0); response.setContentType("application/octet-stream");
             */
            String name = "EXCEL";
            /*
             * response.setHeader("Content-Disposition", "attachment; filename=" +
             * java.net.URLEncoder.encode(name+".xls", "UTF-8"));
             */

            String titles = "序号|应用系统名称|信息资源名称|信息资源代码|信息资源提供方|资源提供方代码|摘要|信息资源格式|信息项英文|信息项名称|数据类型";
            String fields = "row|C-江西省公安厅互联网虚拟身份采集分析系统（涉密）|tableName|C-|C-网安|C-|tableComment|C-数据库oracle|column|cnName|dataType";

            el.createSheet("Sheet1");
            el.setHeader(name);
            String[] titleArray = titles.split("\\|");
            String[] fieldArray = fields.split("\\|");
            for (int i = 0; i < titleArray.length; i++) {
                String title = titleArray[i];
                el.setTitle(i + 1, title);
            }
            int row = 0;
            for (int j = 0; j < mList.size(); j++) {
                Model model = mList.get(j);
                if (model.getTableComment() == null) {
                    tableNoCommentCount++;
                }
                propertyCount += model.getProperties().size();
                for (int k = 0; k < model.getProperties().size(); k++) {
                    Property property = model.getProperties().get(k);
                    if (property.getCnName() == null) {
                        propertyNoCommentCount++;
                    }
                    for (int i = 0; i < fieldArray.length; i++) {
                        String field = fieldArray[i];
                        String text = null;

                        if ("row".equals(field)) {
                            text = (row + 1) + "";
                        } else if (field.startsWith("C-")) {
                            text = field.substring(2);
                        } else if (field.equals("tableName")) {
                            text = model.getTableName();
                        } else if (field.equals("tableComment")) {
                            text = model.getTableComment();
                        } else {
                            Object propertyValue = PojoUtils.getPropertyValue(property, fieldArray[i]);
                            if (propertyValue instanceof Date) {
                                text = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format((Date)propertyValue);
                            } else {
                                if (propertyValue != null) {
                                    text = propertyValue.toString();
                                    if (field.equals("dataType")) {
                                        if (text.contains("CHAR")) {
                                            text = "C" + property.getDataLength();
                                        } else if (text.contains("NUMBER")) {
                                            if (property.getDataScale() > 0) {
                                                text = "B(" + property.getDataLength() + "," + property.getDataScale()
                                                        + ")";
                                            } else {
                                                text = "N";
                                            }
                                        } else if (text.contains("FLOAT")) {
                                            text = "F";
                                        } else if (text.equals("DATE") || text.contains("TIMESTAMP")) {
                                            text = "T";
                                        } else if (text.equals("CLOB")) {
                                            text = "CM";
                                        } else if (text.equals("BLOB")) {
                                            text = "BM";
                                        }
                                    }
                                }
                            }
                        }

                        el.setText(row + 1, i + 1, text);
                    }
                    row++;
                }
            }
            el.setTime();
            el.write();

        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            el.close();
        }
        ModelAndView mav = wrap("main/genExcel");
        mav.addObject("model", dataBind.getModel());
        mav.addObject("message", "成功");
        mav.addObject("tableCount", mList.size());
        mav.addObject("tableNoCommentCount", tableNoCommentCount);
        mav.addObject("propertyCount", propertyCount);
        mav.addObject("propertyNoCommentCount", propertyNoCommentCount);
        mav.addObject("id", id);
        return mav;

    }

    @RequestMapping("goIndex3")
    public ModelAndView goIndex3() {
        return wrap("main/index3");
    }

    @RequestMapping("goRedis")
    public ModelAndView goRedis(String ip, int port) {

        JedisPool jedisPool = RedisConfig.getJedisPool(ip, port);
        simpleRedisDAO = new SimpleRedisDAO();
        simpleRedisDAO.setJedisPool(jedisPool);
        return wrap("main/goRedis");
    }

    @RequestMapping(value="doRedisSearch",produces="text/json;charset=UTF-8")
    @ResponseBody
    public String doRedisSearch(String table, String key,int start,int end) {
        if(StringUtils.isEmpty(key)){
            if(!table.endsWith("_key")){
                table = table+"_key";
            }
            List<String> findKeys = simpleRedisDAO.findKeys(table, start, end);
            if(CollectionUtils.isEmpty(findKeys)){
                return returnMessage("0", "未找到列表数据");
            }
            return returnMessage("1", "1", findKeys);
        }else{
            String findByKey = simpleRedisDAO.findByKey(key, table);
            if(findByKey == null){
                return returnMessage("0", "未找到key数据");
            }
            return returnMessage("2", "1", findByKey);
        }
    }
    
    protected String returnMessage(String code, String message, Object obj) {
        SimpleRetMsg simpleRetMsg = new SimpleRetMsg(code, message, obj);
        return GsonUtil.toJson(simpleRetMsg);
    }

    /*
     * // 确定生成，进入结果页面
     * 
     * @RequestMapping("goGenResult") public ModelAndView goGenResult() { // 解析sql，生成model Generator generator = new
     * Generator("mvc"); generator.setModel(DataBind.instance.model); ModelAndView wrap = wrap("genResult.html"); try {
     * generator.generateAll(); generator.generateWhat("html_main"); generator.generateWhat("html_add");
     * generator.generateWhat("html_edit"); generator.generateWhat("html_view"); wrap.addObject("message","生成成功"); }
     * catch (Exception e) { e.printStackTrace(); wrap.addObject("message","生成失败"); } return wrap; }
     */

    private ModelAndView wrap(String viewName) {
        ModelAndView modelAndView = new ModelAndView(viewName);
        modelAndView.addObject("context", RequestHolder.getRequest().getContextPath());
        return modelAndView;
    }
}
