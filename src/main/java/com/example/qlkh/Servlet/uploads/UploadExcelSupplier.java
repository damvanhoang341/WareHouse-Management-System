package com.example.qlkh.Servlet.uploads;

import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.model.Suppliers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UploadExcelSupplier", value = "/UploadExcelSupplier")
@MultipartConfig
public class UploadExcelSupplier extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        BufferedReader reader = request.getReader();
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sb.append(line);
        }

        String requestBody = sb.toString();
        List<Suppliers> suppliers = parseJsonToSuppliers(requestBody);

        SupplierDAO supplierDAO = new SupplierDAO();
        boolean success = true;

        for (Suppliers supplier : suppliers) {
            if (!supplierDAO.addSupplier(supplier)) {
                success = false;
                break;
            }
        }

        response.setContentType("application/json");
        response.getWriter().write("{\"success\":" + success + "}");
    }

    private List<Suppliers> parseJsonToSuppliers(String json) {
        List<Suppliers> suppliers = new ArrayList<>();
        json = json.substring(1, json.length() - 1); // Bỏ dấu ngoặc vuông [] bao quanh
        String[] jsonObjects = json.split("\\},\\{");

        for (String jsonObject : jsonObjects) {
            jsonObject = jsonObject.replace("{", "").replace("}", "").replace("\"", "");
            String[] keyValuePairs = jsonObject.split(",");

            Suppliers supplier = new Suppliers();
            for (String pair : keyValuePairs) {
                String[] keyValue = pair.split(":");
                String key = keyValue[0].trim();
                String value = keyValue[1].trim();
                double price = Double.parseDouble(keyValue[2].trim());
                switch (key) {
                    case "Tên nhà cung cấp":
                        supplier.setSupplierName(value);
                        break;
                    case "Số điện thoại":
                        supplier.setSupplierPhone(value);
                        break;
                    case "Địa chỉ":
                        supplier.setSupplierAddress(value);
                        break;
                    case "Tiền nợ nhập hàng":
                        supplier.setDebt(price);
                        break;
                    case "Mã số thuế":
                        supplier.setTax(value);
                        break;
                }
            }
            suppliers.add(supplier);
        }
        return suppliers;
    }
}
