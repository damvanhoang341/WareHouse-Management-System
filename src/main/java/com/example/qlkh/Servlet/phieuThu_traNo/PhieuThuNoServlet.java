package com.example.qlkh.Servlet.phieuThu_traNo;


import com.example.qlkh.DAO.PhieuThuNoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.ParseException;
import java.util.List;

import com.example.qlkh.DAO.PhieuThuNoDao;
import com.example.qlkh.model.PhieuThuNo;

@WebServlet(name = "PhieuThuNoServlet", value = "/listDebt")
public class PhieuThuNoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PhieuThuNoDao p =new PhieuThuNoDao();
        req.setAttribute("lt",p.listPhieuThu());
        req.getRequestDispatcher("listPhieuThuNo.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }
}
