package com.example.qlkh.Servlet.phieuThu_traNo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.User;
import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.model.Suppliers;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UpdateRepaymetSlip", value = "/repayment")
public class UpdateRepaymetSlip extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO dat = new UserDAO();
        List<User> userList = dat.getAllUser();
        req.setAttribute("listofuser",userList);
        SupplierDAO supplierDAO = new SupplierDAO();
        List<Suppliers> suppliersList = supplierDAO.getDebtSuppliers();
        req.setAttribute("listofsuppliers",suppliersList);

        req.getRequestDispatcher("phieuTraNo.jsp").forward(req,resp);
    }
}
