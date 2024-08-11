package com.example.qlkh.Servlet.debt;

import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.model.Suppliers;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DebtPaidServlet", value = "/debt-paid")
public class DebtPaidServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SupplierDAO supplierDAO   =  new SupplierDAO();
        List<Suppliers> suppliers = supplierDAO.getDebtSuppliers();
        request.setAttribute("suppliers", suppliers);
        request.getRequestDispatcher("debt/debtPaid.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
