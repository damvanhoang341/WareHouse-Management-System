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


@WebServlet(name = "ListSupplierServlet", value = "/supplier")
public class ListSupplierServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SupplierDAO supplierDAO = new SupplierDAO();
        List<Suppliers> suppliers = supplierDAO.getAllSuppliers();
        request.setAttribute("supplier", suppliers);
        request.getRequestDispatcher("Supplier/ListSuppliers.jsp").forward(request, response);
    }
}
