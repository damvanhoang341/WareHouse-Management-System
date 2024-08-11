package com.example.qlkh.Servlet.Customer;

import com.example.qlkh.DAO.CustomersDAO;
import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.model.CustomerType;
import com.example.qlkh.model.Customers;
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

@WebServlet(name = "ImportCustomerServlet", value = "/import-customer")
@MultipartConfig
public class ImportCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("file");
        CustomersDAO customersDAO =  new CustomersDAO();

        if (filePart != null) {
            try (InputStream inputStream = filePart.getInputStream()) {
                List<Customers> customersList = parseExcelFile(inputStream);
                boolean check = customersDAO.addAllCustomer(customersList);
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
    private List<Customers> parseExcelFile(InputStream inputStream) throws Exception {
        List<Customers> list = new ArrayList<>();
        Workbook workbook = new XSSFWorkbook(inputStream);
        Sheet sheet = workbook.getSheetAt(0);
        for (Row row : sheet) {
            if (row.getRowNum() == 0) { // Skip header row
                continue;
            }
            String type = row.getCell(1).getStringCellValue();

            Customers customers = new Customers();
            customers.setCustomerName(row.getCell(0).getStringCellValue());
            CustomerType customerType = new CustomerType();
            if(type.equals("Khách lẻ")){
                customerType.setCustomerTypeId(1);
            }else if(type.equals("Khách xưởng")){
                customerType.setCustomerTypeId(2);
            }else{
                throw new IllegalArgumentException("Không tìm thấy loại khách hàng");
            }
            customers.setCt_Id(customerType);
            customers.setCustomerPhone(row.getCell(2).getStringCellValue());
            customers.setCustomerAddress(row.getCell(3).getStringCellValue());
            customers.setCustomerTax(row.getCell(4).getStringCellValue());
            list.add(customers);
        }
        workbook.close();
        return list;
    }
}
