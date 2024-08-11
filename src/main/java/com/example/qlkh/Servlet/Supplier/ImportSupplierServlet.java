package com.example.qlkh.Servlet.Supplier;

import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.model.Suppliers;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ImportSupplierServlet", value = "/import")
@MultipartConfig
public class ImportSupplierServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("file");
        SupplierDAO supplierDAO =  new SupplierDAO();

        if (filePart != null) {
            try (InputStream inputStream = filePart.getInputStream()) {
                List<Suppliers> suppliersList = parseExcelFile(inputStream);
                boolean check = supplierDAO.addAllSupplier(suppliersList);
                if (check) {
                    response.getWriter().write("{\"success\": true}");
                } else {
                    String errorMessage = "Import thất bại!";
                    response.getWriter().write("{\"error\": \"" + errorMessage + "\"}");
                }
            } catch (Exception e) {
                String errorMessage = "Import thất bại: " + e.getMessage();
                response.getWriter().write("{\"error\": \"" + errorMessage + "\"}");
            }
        } else {
            String errorMessage = "Import thất bại: " ;
            response.getWriter().write("{\"error\": \"" + errorMessage + "\"}");
        }
    }
    private List<Suppliers> parseExcelFile(InputStream inputStream) throws Exception {
        List<Suppliers> list = new ArrayList<>();
        Workbook workbook = new XSSFWorkbook(inputStream);
        Sheet sheet = workbook.getSheetAt(0);

        for (Row row : sheet) {
            if (row.getRowNum() == 0) { // Skip header row
                continue;
            }

            Suppliers suppliers = new Suppliers();

            // Read the supplier name
            suppliers.setSupplierName(getCellValue(row.getCell(0)));

            // Read the supplier phone
            suppliers.setSupplierPhone(getCellValue(row.getCell(1)));

            // Read the supplier address
            suppliers.setSupplierAddress(getCellValue(row.getCell(2)));

            // Convert the debt value from string to double
            try {
                double debt = getNumericCellValue(row.getCell(3));
                suppliers.setDebt(debt);
            } catch (NumberFormatException e) {
                // Handle cases where the value cannot be parsed as double
                suppliers.setDebt(0.0); // or set a default value or handle the error as needed
            }

            // Read the tax
            suppliers.setTax(getCellValue(row.getCell(4)));

            list.add(suppliers);
        }

        workbook.close();
        return list;
    }

    private String getCellValue(org.apache.poi.ss.usermodel.Cell cell) {
        if (cell == null) {
            return "";
        }

        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                // Convert numeric cell value to string
                return String.valueOf(cell.getNumericCellValue());
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                // Handle formula cases if necessary
                return cell.getCellFormula();
            default:
                return "";
        }
    }

    private double getNumericCellValue(org.apache.poi.ss.usermodel.Cell cell) throws NumberFormatException {
        if (cell == null) {
            return 0.0;
        }

        switch (cell.getCellType()) {
            case NUMERIC:
                return cell.getNumericCellValue();
            case STRING:
                return Double.parseDouble(cell.getStringCellValue());
            default:
                throw new NumberFormatException("Cell type is not numeric or string");
        }
    }

}
