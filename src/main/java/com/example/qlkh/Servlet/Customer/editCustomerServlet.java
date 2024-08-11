package com.example.qlkh.Servlet.Customer;

import com.example.qlkh.DAO.CustomersDAO;
import com.example.qlkh.model.CustomerType;
import com.example.qlkh.model.Customers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "editCustomerServlet", value = "/editCustomerServlet")
public class editCustomerServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerID = Integer.parseInt(request.getParameter("cid"));
        CustomersDAO customersDAO=new CustomersDAO();
        request.setAttribute("customer",customersDAO.getCustomerById(customerID));
        request.setAttribute("customerTypes", customersDAO.getAllType());
        request.getRequestDispatcher("Customer/EditCustomer.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomersDAO customersDAO=new CustomersDAO();
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String customerName = request.getParameter("customerName");
        String customerPhone = request.getParameter("customerPhone");
        int customerTypeId = Integer.parseInt(request.getParameter("customerTypeId"));
        String customerAddress = request.getParameter("customerAddress");
        String customerTax = request.getParameter("customerTax");
        // Construct the updated customer object
        Customers updatedCustomer = new Customers();
        updatedCustomer.setCustomerId(customerId);
        updatedCustomer.setCustomerName(customerName);
        updatedCustomer.setCustomerPhone(customerPhone);
        updatedCustomer.setCustomerAddress( customerAddress);
        updatedCustomer.setCustomerTax( customerTax);
        CustomerType customerType = new CustomerType();
        customerType.setCustomerTypeId(customerTypeId);
        updatedCustomer.setCt_Id(customerType);


        // Update the customer
        boolean success = customersDAO.updateCustomer(updatedCustomer);

        if (success) {
            request.setAttribute("success","Cập nhật thành công");
            request.setAttribute("customer", customersDAO.getAllCustomers());
            request.setAttribute("customertype", customersDAO.getAllType());
            request.getRequestDispatcher("Customer/CustomerList.jsp").forward(request,response);
        } else {
            request.setAttribute("error2", "cập nhật không thành công"); // Set error message if update fails
            request.getRequestDispatcher("Customer/EditCustomer.jsp").forward(request,response);
        }
    }
}
