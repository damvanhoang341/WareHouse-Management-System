package com.example.qlkh.Servlet.phieuThu_traNo;

import com.example.qlkh.DAO.RepaymentSlipDAO;
import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.RepaymentSlip;
import com.example.qlkh.model.Suppliers;
import com.example.qlkh.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "listDebtPay", value = "/listRepayment")
public class listDebtPay extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RepaymentSlipDAO repaymentSlipDAO = new RepaymentSlipDAO();
        UserDAO dat = new UserDAO();
        List<User> userList = dat.getAllUser();
        request.setAttribute("listofuser",userList);

        SupplierDAO supplierDAO = new SupplierDAO();
        List<Suppliers> suppliersList = supplierDAO.getDebtSuppliers();
        request.setAttribute("listofsuppliers",suppliersList);
        request.setAttribute("listofreplayments",repaymentSlipDAO.repaymentSlipList());
        request.getRequestDispatcher("list_replayment.jsp").forward(request, response);
    }
}
