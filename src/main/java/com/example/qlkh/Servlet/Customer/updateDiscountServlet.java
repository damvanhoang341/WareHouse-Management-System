package com.example.qlkh.Servlet.Customer;

import com.example.qlkh.DAO.CustomersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "updateDiscountServlet", value = "/updateDiscountServlet")
public class updateDiscountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomersDAO customerDAO;

    public void init() {
        customerDAO = new CustomersDAO(); // Initialize your DAO here
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("customertype", customerDAO.getAllType());
        request.getRequestDispatcher("Customer/CustomerList.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int customerTypeId = Integer.parseInt(request.getParameter("customerTypeId"));
        double newDiscount = Double.parseDouble(request.getParameter("newDiscount"));
        request.setAttribute("customertype", customerDAO.getAllType());
        boolean success = customerDAO.updatePaymentDiscount(customerTypeId, newDiscount);
        request.setAttribute("customer", customerDAO.getAllCustomers());
        request.setAttribute("success", success ? "Cập nhật chiết khấu thành công!" : "Cập nhật chiết khấu thất bại.");
        request.getRequestDispatcher("Customer/CustomerList.jsp").forward(request, response);
    }
}