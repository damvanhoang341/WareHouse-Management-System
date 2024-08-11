package com.example.qlkh.Servlet.debt;

import com.example.qlkh.DAO.OutputDao;
import com.example.qlkh.dto.DebtCollectionDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "DebtCollectionServlet", value = "/debt-collection")
public class DebtCollectionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OutputDao outputDao = new OutputDao();
        List<DebtCollectionDTO> list = outputDao.getAllDebtCollection();
        request.setAttribute("list", list);
        request.getRequestDispatcher("debt/debtCollection.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
