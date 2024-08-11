package com.example.qlkh.Servlet.phieuThu_traNo;

import com.example.qlkh.DAO.CustomersDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.User;
import com.example.qlkh.model.Customers;
import com.example.qlkh.model.PhieuThuNo;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "danhsachUserServlet", value = "/debt")
public class danhsachUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //khai bao UserDao
        UserDAO userDao = new UserDAO();
        List<User> listUser = userDao.getAllUser();
        CustomersDAO customersDao = new CustomersDAO();
        List<Customers> customersList = customersDao.getDebtCustomers();
        req.setAttribute("CustomersList",customersList);
        req.setAttribute("list",listUser);
        //tra ve trang jsp
        req.getRequestDispatcher("phieuThuNo.jsp").forward(req, resp);
    }
}
