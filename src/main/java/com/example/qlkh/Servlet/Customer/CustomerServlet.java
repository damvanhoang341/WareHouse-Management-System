package com.example.qlkh.Servlet.Customer;

import com.example.qlkh.DAO.CustomersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "CustomerServlet", value = "/CustomerServlet")
public class CustomerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomersDAO customersDAO = new CustomersDAO();
        request.setAttribute("customer", customersDAO.getAllCustomers());
        request.setAttribute("customertype", customersDAO.getAllType());
        request.getRequestDispatcher("Customer/CustomerList.jsp").forward(request, response);
    }
}
