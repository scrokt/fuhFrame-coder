package com.rt.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;


public class ExcelPoi {
    private HSSFSheet sheet = null;
    private HSSFWorkbook workbook = null;
    private HSSFFont font = null;
    private HSSFFont fontStyle = null;
    private HSSFCellStyle style = null;
    private HSSFCellStyle styleright = null;
    private HSSFCellStyle styleHeader = null;
    private Map totalMap = new HashMap();
    private OutputStream out;
    int row;
    int maxCol = 1;

    public ExcelPoi() {
        this.row = -1;
    }

    public void setOutputSream(OutputStream os) throws Exception {
        this.workbook = new HSSFWorkbook();
        this.font = this.workbook.createFont();
        this.style = this.workbook.createCellStyle();
        this.font.setColor((short)10);
        this.font.setBoldweight((short)700);
        this.style.setFont(this.font);
        this.style.setAlignment((short)2);
        this.fontStyle = this.workbook.createFont();
        this.styleHeader = this.workbook.createCellStyle();
        this.fontStyle.setColor((short)32767);
        this.fontStyle.setBoldweight((short)700);
        this.fontStyle.setFontHeightInPoints((short)24);

        this.styleHeader.setWrapText(false);
        this.styleHeader.setFont(this.fontStyle);

        this.styleHeader.setAlignment((short)2);

        this.styleright = this.workbook.createCellStyle();
        this.styleright.setAlignment((short)3);

        this.out = os;
    }

    public void addSheet(String FileName, int index) {
        try {
            HSSFWorkbook oldWorkbook = new HSSFWorkbook(new FileInputStream(new File(FileName)));
            HSSFSheet oldsheet = oldWorkbook.getSheetAt(index);
            HSSFSheet newsheet = this.workbook.createSheet();
            this.workbook.setSheetName(1, oldWorkbook.getSheetName(index));

            Region region = null;
            for (int i = 0; i < oldsheet.getNumMergedRegions(); i++) {
                region = oldsheet.getMergedRegionAt(i);
                newsheet.addMergedRegion(region);
            }

            for (int rownum = 0; rownum < oldsheet.getPhysicalNumberOfRows(); rownum++) {
                HSSFRow row = oldsheet.getRow(rownum + 1);
                HSSFRow newrow = newsheet.createRow(rownum + 1);
                newrow.setHeight(row.getHeight());

                for (int i = 0; i < row.getLastCellNum(); i++) {
                    HSSFCell oldcell = row.getCell((short)i);

                    if (oldcell != null) {
                        HSSFCell newcell = newrow.createCell((short)i);
                        newcell.setCellType(1);

                        HSSFCellStyle cellstyle = this.workbook.createCellStyle();
                        cellstyle.setAlignment(oldcell.getCellStyle().getAlignment());
                        cellstyle.setFillBackgroundColor(oldcell.getCellStyle().getFillBackgroundColor());
                        cellstyle.setFillForegroundColor(oldcell.getCellStyle().getFillForegroundColor());
                        cellstyle.setFont(oldWorkbook.getFontAt(oldcell.getCellStyle().getFontIndex()));
                        cellstyle.setFillPattern(oldcell.getCellStyle().getFillPattern());
                        cellstyle.setBorderBottom(oldcell.getCellStyle().getBorderBottom());
                        cellstyle.setBorderLeft(oldcell.getCellStyle().getBorderLeft());
                        cellstyle.setBorderTop(oldcell.getCellStyle().getBorderTop());
                        cellstyle.setBorderRight(oldcell.getCellStyle().getBorderRight());
                        newcell.setCellStyle(cellstyle);
                        String value = "";
                        if (oldcell.getCellType() == 1)
                            value = oldcell.getStringCellValue();
                        newcell.setCellValue(value);
                    }
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void createSheet(String sheetName) {
        this.sheet = this.workbook.createSheet();
        this.workbook.setSheetName(0, sheetName);
    }

    public void addSheet(String sheetName) {
        this.row = -1;
        this.maxCol = 0;
        this.sheet = this.workbook.createSheet(sheetName);
    }

    public void setHeader(String header) {
        setCellText(0, 0, header, "header");
    }

    public boolean IsSum(int col) {
        return this.totalMap.containsKey(String.valueOf(col));
    }

    public void setTitle(int col, String title, boolean isSum) {
        setCellText(1, col - 1, title, "title");
        if (isSum)
            this.totalMap.put(String.valueOf(col - 1), "0");
    }

    public void setTitle(int col, String title) {
        setTitle(col, title, false);
    }

    private void setTotalInt(int col, String value) {
        if (col == 0)
            return;
        String total = String.valueOf(this.totalMap.get(String.valueOf(col)));
        total = String.valueOf(Integer.parseInt(total) + Integer.parseInt(value));
        this.totalMap.put(String.valueOf(col), total);
    }

    private void setTotalMoney(int col, String value) {
        if (col == 0)
            return;
        String total = String.valueOf(this.totalMap.get(String.valueOf(col)));
        total = new DecimalFormat("###,##0.00").format(Double.parseDouble(total) + Double.parseDouble(value));
        this.totalMap.put(String.valueOf(col), total);
    }

    public boolean setCellText(int row, int col, String text, String format) {
        if (col > this.maxCol)
            this.maxCol = col;
        HSSFRow hsrow = null;
        boolean issum = IsSum(col);
        if (row > this.row) {
            for (int i = this.row + 1; i < row + 1; i++)
                hsrow = this.sheet.createRow((short)row);
            this.row = row;
        } else {
            hsrow = this.sheet.getRow(row);
        }
        try {
            HSSFCell cell = hsrow.createCell((short)col);
            if (format.equals("header")) {
                cell.setCellStyle(this.styleHeader);
                cell.setCellValue(text);
                hsrow.setHeight((short)1000);
            } else if (format.equals("title")) {
                cell.setCellStyle(this.style);
                cell.setCellValue(text);
            } else if (format.equals("money")) {
                cell.setCellValue(Double.parseDouble(text));
                if (issum)
                    setTotalMoney(col, text);

            } else if (format.equals("money2")) {
                cell.setCellValue(Double.parseDouble(text) / 100.0D);
                if (issum)
                    setTotalMoney(col, String.valueOf(Double.parseDouble(text) / 100.0D));

            } else if (format.equals("date")) {
                cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd").parse(text));
            } else if (format.equals("datetime")) {
                cell.setCellValue(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(text));
            } else if ((format.equals("int")) || (format.equals("0"))) {
                cell.setCellType(0);

                cell.setCellValue(Integer.parseInt(text));
                if (issum)
                    setTotalInt(col, text);
            } else if (format.equals("text")) {
                cell.setCellValue(text);
                if (issum)
                    setTotalMoney(col, text);

            } else if (format.startsWith("string")) {
                cell.setCellValue(text.trim());

                if (issum)
                    setTotalMoney(col, text);
            } else if (format.startsWith("right")) {
                cell.setCellValue(text.trim());
                if (format.indexOf("string") > 0) {
                    Integer.parseInt(format.replaceFirst("string", "0"));
                }
                cell.setCellStyle(this.styleright);
                if (issum)
                    setTotalMoney(col, text);

            } else {
                cell.setCellValue(text);
                if (issum)
                    setTotalMoney(col, text);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void setText(int row, int col, String text) {
        setText(row, col, text, "");
    }

    public boolean setText(int row, int col, String text, String format) {
        return setCellText(row + 1, col - 1, text, format);
    }

    public void merge(int row1, int col1, int row2, int col2) {
        this.sheet.addMergedRegion(new Region(row1, (short)col1, row2, (short)col2));
    }

    public void setTime() {
        this.sheet.addMergedRegion(new Region(this.row + 2, (short)0, this.row + 2, (short)this.maxCol));
        setText(this.row + 1, 1, "时间：" + new SimpleDateFormat("yyyy-MM-dd").format(new Date()), "right");
    }

    public void setTotal() {
        if (this.totalMap.size() == 0)
            return;
        int totalRow = this.row;
        setText(totalRow, 1, "合计：", "title");
        for (Iterator it = this.totalMap.entrySet().iterator(); it.hasNext();) {
            Map.Entry e = (Map.Entry)it.next();
            if (!String.valueOf(e.getKey()).equals("0"))
                setText(totalRow, 1 + Integer.parseInt(String.valueOf(e.getKey())), String.valueOf(e.getValue()),
                        "right");
        }
    }

    public void write() {
        try {
            if (this.out != null)
                this.workbook.write(this.out);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void addMergedRegion() {
        this.sheet.addMergedRegion(new Region(0, (short)0, 0, (short)this.maxCol));
    }

    public void close() {
        try {
            if (this.out != null)
                this.out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public String getCellStringValue(HSSFCell cell) {
        String cellValue = "";
        switch (cell.getCellType()) {
        case HSSFCell.CELL_TYPE_STRING:
            cellValue = cell.getStringCellValue();
            if (cellValue.trim().equals("") || cellValue.trim().length() <= 0)
                cellValue = " ";
            break;
        case HSSFCell.CELL_TYPE_NUMERIC:
            cellValue = String.valueOf(cell.getNumericCellValue());
            break;
        case HSSFCell.CELL_TYPE_FORMULA:
            cell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
            cellValue = String.valueOf(cell.getNumericCellValue());
            break;
        case HSSFCell.CELL_TYPE_BLANK:
            cellValue = " ";
            break;
        case HSSFCell.CELL_TYPE_BOOLEAN:
            break;
        case HSSFCell.CELL_TYPE_ERROR:
            break;
        default:
            break;
        }
        return cellValue;
    }

}
