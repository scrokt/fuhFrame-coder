package com.rt.gencode;

public class Property {

    private String name;
    private String type;
    private String simpleType;
    private String column;
    private String jdbcType;
    private String dataType;
    private String cnName;
    private boolean nullAble;
    private boolean id;
    private boolean search;
    private String searchExpr;
    private int dataLength;
    private int dataScale;
    private boolean show;
    private int width;
    private boolean edit;

    public Property() {
        super();
    }

    public Property(String name, String type, String simpleType) {
        super();
        this.name = name;
        this.type = type;
        this.simpleType = simpleType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        if (simpleType != null && simpleType.equals("Date")) {
            return "java.util.Date";
        }
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getSimpleType() {
        return simpleType;
    }

    public void setSimpleType(String simpleType) {
        this.simpleType = simpleType;
    }

    public String getGetMethodName() {
        String getMethodName = null;
        // 判断第二个字母是否为大写
        if (name.length() == 1) {
            getMethodName = "get" + name.toUpperCase();
        } else {
            char second = name.charAt(1);
            if (second >= 'A' && second <= 'Z') {
                getMethodName = "get" + name;
            } else {
                getMethodName = "get" + name.substring(0, 1).toUpperCase() + name.substring(1);
            }
        }
        return getMethodName;
    }

    public String getSetMethodName() {
        String setMethodName = null;
        // 判断第二个字母是否为大写
        if (name.length() == 1) {
            setMethodName = "set" + name.toUpperCase();
        } else {
            char second = name.charAt(1);
            if (second >= 'A' && second <= 'Z') {
                setMethodName = "set" + name;
            } else {
                setMethodName = "set" + name.substring(0, 1).toUpperCase() + name.substring(1);
            }
        }
        return setMethodName;
    }

    public String getColumn() {
        if (column == null) {
            return name;
        }
        return column;
    }

    public void setColumn(String column) {
        this.column = column;
    }

    public String getJdbcType() {
        if (jdbcType != null && !"".equals(jdbcType)) {
            return jdbcType;
        }
        if (simpleType == null) {
            return null;
        }
        if (simpleType.equals("Long") || simpleType.equals("Integer") || simpleType.equals("Short")) {
            return "DECIMAL";
        }
        if (simpleType.equals("String")) {
            return "VARCHAR";
        }
        if (simpleType.equals("Date")) {
            return "TIMESTAMP";
        }
        return null;
    }

    public void setJdbcType(String jdbcType) {
        this.jdbcType = jdbcType;
    }

    public boolean isId() {
        return id;
    }

    public String getCnName() {
        return cnName;
    }

    public void setCnName(String cnName) {
        this.cnName = cnName;
    }

    public boolean isNullAble() {
        return nullAble;
    }

    public void setNullAble(boolean nullAble) {
        this.nullAble = nullAble;
    }

    public void setId(boolean id) {
        this.id = id;
    }

    public boolean isSearch() {
        return search;
    }

    public void setSearch(boolean search) {
        this.search = search;
    }

    public String getSearchExpr() {
        return searchExpr;
    }

    public void setSearchExpr(String searchExpr) {
        this.searchExpr = searchExpr;
    }

    public int getDataLength() {
        return dataLength;
    }

    public void setDataLength(int dataLength) {
        this.dataLength = dataLength;
    }

    public String getDataType() {
        return dataType;
    }

    public void setDataType(String dataType) {
        this.dataType = dataType;
    }

    public boolean isShow() {
        return show;
    }

    public void setShow(boolean show) {
        this.show = show;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public boolean isEdit() {
        return edit;
    }

    public void setEdit(boolean edit) {
        this.edit = edit;
    }

    public int getDataScale() {
        return dataScale;
    }

    public void setDataScale(int dataScale) {
        this.dataScale = dataScale;
    }

}
