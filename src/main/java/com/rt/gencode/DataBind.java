package com.rt.gencode;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;
import java.util.Set;

public class DataBind {

    private String id;
    private String basePackage;
    private String module;
    private String moduleName;
    private String dbUrl;
    private String username;
    private String password;
    private String table;
    private String db;
    private Model model;

    public void genModel() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection(dbUrl, username, password);
            this.model = getModel(connection,table);
        }catch (ClassNotFoundException e) {
                e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Model getModel(Connection connection,String tableName){
        try{
            Statement statement = connection.createStatement();
            ResultSet columnSet = statement.executeQuery("select * from user_tab_cols where table_name='"
                    + tableName.toUpperCase() + "'");
            Statement statement2 = connection.createStatement();
            ResultSet commentSet = statement2.executeQuery("select * from user_col_comments where table_name='"
                    + tableName.toUpperCase() + "'");
            Statement statement3 = connection.createStatement();
            ResultSet pkSet = statement3
                    .executeQuery("select * from user_cons_columns where constraint_name = (select constraint_name from user_constraints where table_name='"
                            + tableName.toUpperCase() + "' and constraint_type='P')");
            Set<String> pks = new HashSet<String>();
            while (pkSet.next()) {
                String column = pkSet.getString("COLUMN_NAME");
                pks.add(column);
            }
            Model model = new Model();
            model.setBasePackage(basePackage);
            model.setModuleCnName(moduleName);
            model.setModuleName(module);
            model.setTableName(tableName);
            model.setDb(db);
            while (columnSet.next()) {
                commentSet.next();
                Property property = new Property();
                property.setColumn(columnSet.getString("COLUMN_NAME"));
                property.setName(this.columnToJava(property.getColumn()));
                property.setCnName(commentSet.getString("COMMENTS"));
                property.setDataType(columnSet.getString("DATA_TYPE"));
                // System.out.println(columnSet.getString("NULLABLE"));
                property.setNullAble(columnSet.getString("NULLABLE").equals("Y"));
                // property.setType((property.getColumn()));
                String javaTypeFrom = this.javaTypeFrom(property.getDataType());
                if ("Long".equals(javaTypeFrom)) {
                    if (!property.getName().toLowerCase().endsWith("id")) {
                        javaTypeFrom = "Integer";
                    }
                }
                property.setSimpleType(javaTypeFrom);
                property.setJdbcType(this.jdbcTypeFrom(property.getDataType()));
                property.setDataLength(columnSet.getInt("DATA_LENGTH"));
                property.setDataScale(columnSet.getInt("DATA_SCALE"));
                if (pks.contains(property.getColumn())) {
                    property.setId(true);
                }
                model.setProperty(property);
            }
            columnSet.close();
            commentSet.close();
            pkSet.close();
            statement.close();
            statement2.close();
            statement3.close();
            return model;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private String columnToJava(String column) {
        String lowerCase = column.toLowerCase();
        String[] split = lowerCase.split("_");
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < split.length; i++) {
            if (i == 0) {
                sb.append(split[i]);
            } else {
                sb.append(split[i].substring(0, 1).toUpperCase()).append(split[i].substring(1));
            }
        }
        return sb.toString();
    }

    private String javaTypeFrom(String type) {
        type = type.toLowerCase();
        if (type.indexOf("num") > -1) {
            return "Long";
        } else if (type.indexOf("decimal") > -1) {
            return "Double";
        } else if (type.indexOf("float") > -1) {
            return "Float";
        } else if (type.indexOf("int") > -1) {
            return "Long";
        } else if (type.indexOf("varchar") > -1 || type.indexOf("char") > -1) {
            return "String";
        } else if (type.indexOf("date") > -1 || type.indexOf("datetime") > -1 || type.indexOf("timestamp") > -1) {
            return "Date";
        }
        return "String";
    }

    private String jdbcTypeFrom(String type) {
        type = type.toLowerCase();
        if (type.indexOf("num") > -1 || type.indexOf("decimal") > -1) {
            return "DECIMAL";
        } else if (type.indexOf("int") > -1) {
            return "NUMERIC";
        } else if (type.indexOf("varchar") > -1) {
            return "VARCHAR";
        } else if (type.indexOf("char") > -1) {
            return "CHAR";
        } else if (type.indexOf("date") > -1 || type.indexOf("datetime") > -1 || type.indexOf("timestamp") > -1) {
            return "TIMESTAMP";
        }
        return "VARCHAR";
    }

    public String getBasePackage() {
        return basePackage;
    }

    public void setBasePackage(String basePackage) {
        this.basePackage = basePackage;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getDbUrl() {
        return dbUrl;
    }

    public void setDbUrl(String dbUrl) {
        this.dbUrl = dbUrl;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTable() {
        return table;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }

    public String getDb() {
        return db;
    }

    public void setDb(String db) {
        this.db = db;
    }

}
