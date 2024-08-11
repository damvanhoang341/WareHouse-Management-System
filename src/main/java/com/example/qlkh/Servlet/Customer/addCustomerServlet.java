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

@WebServlet(name = "addCustomerServlet", value = "/addCustomerServlet")
public class addCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomersDAO customersDAO = new CustomersDAO();
        request.setAttribute("customertype", customersDAO.getAllType());
        request.getRequestDispatcher("Customer/AddCustomer.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String customerName = request.getParameter("customerName");
        String customerPhone = request.getParameter("customerPhone");
        String customerAddress = request.getParameter("customerAddress");
        String customerTax = request.getParameter("customerTax");
        int customerTypeId = Integer.parseInt(request.getParameter("customerTypeId"));

        Customers customer = new Customers();
        customer.setCustomerName(customerName);
        customer.setCustomerPhone(customerPhone);
        CustomerType customerType = new CustomerType();
        customerType.setCustomerTypeId(customerTypeId);
        customer.setCt_Id(customerType);
        customer.setCustomerAddress(customerAddress);
        customer.setCustomerTax(customerTax);

        // Call the addCustomer method of CustomersDAO to save the new customer
        CustomersDAO customersDAO = new CustomersDAO();

        boolean phoneExist = customersDAO.checkCustomerPhoneExists(customerPhone);
        if(phoneExist){
            request.setAttribute("error2", "Khách hàng đã có trong hệ thống");
            request.getRequestDispatcher("Customer/AddCustomer.jsp").forward(request, response);
        }else{
            boolean isAdded = customersDAO.addCustomer(customer);
            if (isAdded) {
                request.setAttribute("success","Thêm thành công");
                request.setAttribute("customer", customersDAO.getAllCustomers());
                request.getRequestDispatcher("Customer/CustomerList.jsp").forward(request,response);
            } else {
                request.setAttribute("error2", "thêm thất bại ,hãy thử lại");
                request.getRequestDispatcher("Customer/AddCustomer.jsp").forward(request, response); // Forward back to the form
            }
        }

    }
}
