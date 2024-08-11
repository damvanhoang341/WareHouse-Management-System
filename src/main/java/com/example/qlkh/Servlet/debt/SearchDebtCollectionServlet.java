package com.example.qlkh.Servlet.debt;

import com.example.qlkh.DAO.OutputDao;
import com.example.qlkh.dto.DebtCollectionDTO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "SearchDebtCollectionServlet", value = "/search-debt-collection")
public class SearchDebtCollectionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ten = request.getParameter("ten");
        String sdt = request.getParameter("sdt");
        OutputDao outputDao = new OutputDao();
        List<DebtCollectionDTO> list = outputDao.searchDebtCollection(ten, sdt);
        request.setAttribute("list", list);
        request.getRequestDispatcher("debt/debtCollection.jsp").forward(request, response);
    }
}

