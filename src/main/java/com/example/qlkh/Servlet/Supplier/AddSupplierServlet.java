package com.example.qlkh.Servlet.Supplier;

import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.model.Suppliers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AddSupplierServlet", value = "/AddSupplierServlet")
public class AddSupplierServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the form page if accessed via GET
        request.getRequestDispatcher("Supplier/add-supplier.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set the request encoding to UTF-8
        request.setCharacterEncoding("UTF-8");

        // Get form parameters
        String supplierName = request.getParameter("suppliername");
        String supplierPhone = request.getParameter("supplierphone");
        String supplierAddress = request.getParameter("address");
        String taxCode = request.getParameter("taxCode");
        // Check if all parameters are present
        if (supplierName == null || supplierName.isEmpty() ||
                supplierPhone == null || supplierPhone.isEmpty() ||
                supplierAddress == null || supplierAddress.isEmpty()) {
            // Set error message and forward back to form
            request.setAttribute("error2", "Hãy nhập đẩy đủ");
            request.getRequestDispatcher("/add-supplier.jsp").forward(request, response);
            return;
        }

        // Create a new supplier object
        Suppliers supplier = new Suppliers();
        supplier.setSupplierName(supplierName);
        supplier.setSupplierPhone(supplierPhone);
        supplier.setSupplierAddress(supplierAddress);
        supplier.setTax(taxCode);
        // Add supplier to database
        SupplierDAO supplierDAO = new SupplierDAO();
        boolean supplierExists = supplierDAO.isSupplierExists(supplierPhone, supplierAddress);
        if(supplierExists){
            request.setAttribute("error2", "Nhà cung cấp đã tồn tại");
            request.getRequestDispatcher("Supplier/add-supplier.jsp").forward(request, response);
        }else{
            boolean isAdded = supplierDAO.addSupplier(supplier);

            // Handle result
            if (isAdded) {
                // Redirect to the supplier list page with a success message
                request.setAttribute("success", "Supplier added successfully.");
                List<Suppliers> suppliers = supplierDAO.getAllSuppliers();
                request.setAttribute("supplier", suppliers);
                request.getRequestDispatcher("Supplier/ListSuppliers.jsp").forward(request,response); // Change this path as needed
            } else {
                // Set error message and forward back to form
                request.setAttribute("error2", "thêm thất bại hãy thử lại");
                request.getRequestDispatcher("Supplier/add-supplier.jsp").forward(request, response);
            }
        }
    }
}
