package com.rt.gencode;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Model {

    private String moduleCnName = "模块";
    private String moduleName;
    private String basePackage;
    private String tableName;
    private String tableComment;
    private String db;
    private String author;
    private String projectName;
    private String version;
    private String sub;
    private List<Property> properties;

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getBasePackage() {
        return basePackage;
    }

    public void setBasePackage(String basePackage) {
        this.basePackage = basePackage;
    }

    public String getDtoName() {
        return moduleName.substring(0, 1).toUpperCase() + moduleName.substring(1) + "DTO";
    }

    public String getDtoVarName() {
        return moduleName + "DTO";
    }

    public String getDaoName() {
        return moduleName.substring(0, 1).toUpperCase() + moduleName.substring(1) + "DAO";
    }

    public String getDaoVarName() {
        return moduleName + "DAO";
    }

    public String getActionName() {
        return moduleName.substring(0, 1).toUpperCase() + moduleName.substring(1) + "Action";
    }

    public String getFormName() {
        return moduleName.substring(0, 1).toUpperCase() + moduleName.substring(1) + "SearchForm";
    }

    public String getFormVarName() {
        return moduleName + "SearchForm";
    }

    public String getServiceName() {
        return moduleName.substring(0, 1).toUpperCase() + moduleName.substring(1) + "Service";
    }

    public String getServiceVarName() {
        return moduleName + "Service";
    }

    public String getServiceImplName() {
        return moduleName.substring(0, 1).toUpperCase() + moduleName.substring(1) + "ServiceImpl";
    }

    public List<Property> getProperties() {
        return properties;
    }

    public void setProperties(List<Property> properties) {
        this.properties = properties;
    }

    public void setProperty(Property property) {
        if (this.properties == null) {
            properties = new ArrayList<Property>();
        }
        this.properties.add(property);
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getModuleCnName() {
        return moduleCnName;
    }

    public void setModuleCnName(String moduleCnName) {
        this.moduleCnName = moduleCnName;
    }

    public String getDb() {
        return db;
    }

    public void setDb(String db) {
        this.db = db;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getProjectName() {
        return projectName;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getDateStr() {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    }

    public String getSub() {
        return sub;
    }

    public void setSub(String sub) {
        this.sub = sub;
    }
    
    public String getTm(){
        if(db.equals("DEFAULT_DS")){
            return "tm";
        }else if(db.equals("ELEFENCE_DS")){
            return "elefenceTM";
        }else if(db.equals("PICKDATA_DS")){
            return "pickdataTM";
        }else if(db.equals("TM_DS")){
            return "tmTM";
        }else if(db.equals("BR_DS")){
            return "brTM";
        }else if(db.equals("IDENTITY_DS")){
            return "identityTM";
        }
        return "tm";
    }

    public String getTableComment() {
        return tableComment;
    }

    public void setTableComment(String tableComment) {
        this.tableComment = tableComment;
    }

}
