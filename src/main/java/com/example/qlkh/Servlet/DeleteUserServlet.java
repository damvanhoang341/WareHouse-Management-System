package com.example.qlkh.Servlet;

import com.example.qlkh.DAO.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "DeleteUserServlet", value = "/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
              int id = Integer.parseInt(request.getParameter("id"));
        UserDAO userDAO = new UserDAO();
        userDAO.deleteUser(id);
        response.sendRedirect("/ListUserServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
