package com.example.qlkh.Servlet;

import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
@WebServlet(name = "ListUserServlet", value = "/ListUserServlet")
public class ListUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO1 = new UserDAO();
        List<User> list = userDAO1.getAllUser();
        request.setAttribute("data", list);
        RequestDispatcher dispatcher = request.getRequestDispatcher("staffManager.jsp");
        dispatcher.forward(request, response);
    }

}
