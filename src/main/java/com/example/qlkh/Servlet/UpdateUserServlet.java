package com.example.qlkh.Servlet;

import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "UpdateUserServlet ", value = "/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        int id = Integer.parseInt(request.getParameter("uid"));
        User user = userDAO.getUserById(id);
        request.setAttribute("user", user);
        request.getRequestDispatcher("/user/update-user.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set request encoding to handle UTF-8 characters
        request.setCharacterEncoding("UTF-8");
        UserDAO userDAO = new UserDAO();
        // Retrieve the parameters from the request
        int userId = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        int roleId = Integer.parseInt(request.getParameter("role"));

        // Create a user object
        User user = new User();
        user.setId(userId);
        user.setName(name);
        user.setPhone(phone);
        user.setEmail(email);
        user.setAddress(address);
        user.setRoleId(roleId);

        // Update the user in the database
        boolean isUpdated = userDAO.updateUser(user);

        if (isUpdated) {
            List<User> users = userDAO.getAllUser();
            // Redirect to a success page or display a success message
            request.setAttribute("success", "Cập nhật thành công");
            request.setAttribute("data", users);
            request.getRequestDispatcher("staffManager.jsp").forward(request, response);
        } else {
            // Set an error message in the request scope and forward back to the form
            request.setAttribute("error", "Cập nhật thất bại ,vui lòng thử lại");
            request.getRequestDispatcher("/user/update-user.jsp").forward(request, response);
        }
        ;
    }
}
