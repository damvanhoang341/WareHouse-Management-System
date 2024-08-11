package com.example.qlkh.Servlet.debt;

import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.model.Suppliers;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchDebtPaidServlet", value = "/search-debt-paid")
public class SearchDebtPaidServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ten = request.getParameter("ten");
        String sdt = request.getParameter("sdt");
        String mst = request.getParameter("mst");
        SupplierDAO supplierDAO = new SupplierDAO();
        List<Suppliers> suppliers = supplierDAO.searchSuppliers(ten, sdt, mst);
        if(suppliers.size() > 0) {
            request.setAttribute("suppliers", suppliers);
            request.getRequestDispatcher("debt/debtPaid.jsp").forward(request, response);
        }else{
            request.setAttribute("message", "Không có kết quả phù hợp");
            request.getRequestDispatcher("debt/debtPaid.jsp").forward(request, response);
        }
    }
}
